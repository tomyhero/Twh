package Twh::Context;
use Mouse;
use Twh::Request;
use Twh::Response;
use Twh::DB;
use Log::Minimal;

has 'req' => ( is => 'rw',lazy_build => 1);
has 'res' => ( is => 'rw',lazy_build => 1);
has 'env' => ( is => 'rw', required => 1);
has 'dispatcher' => ( is => 'rw');
has 'view' => ( is => 'rw');
has 'stash' => ( is => 'rw' , default => sub{ +{} });
has 'template' => ( is => 'rw');
has 'finished' => ( is => 'rw', default => 0 );
has 'db' => ( is => 'rw');

my $APIS ;

BEGIN {
    # PRE LOAD API
    $APIS = {}; 
    my $finder = Module::Pluggable::Object->new(
        search_path => ['Twh::API'],
        except => qr/(^(Twh::API::Base|Twh::API::Result)$)|^Twh::API::Role::/, 
        'require' => 1,
    );
    my @classes = $finder->plugins;
    for my $class (@classes) {
        (my $moniker = $class) =~ s/^Twh::API:://;
        $APIS->{$moniker} = $class;
    }
}

sub api {
    my $c = shift;
    my $moniker = shift;
    return $APIS->{$moniker}->new( { db => $c->db } );
}
sub _build_req {
    my $c = shift;
    return Twh::Request->new($c->env);
}
sub _build_res {
    my $c = shift;
    return Twh::Response->new(200);
}


sub dispatch {
    my $c = shift;
    $c->dispatcher->match($c);
}

sub render {
    my $c = shift;
    return $c->res->finalize() if($c->finished);
    my $body = $c->view->render($c,$c->template);
    $c->res->content_type('text/html; charset=utf-8;');
    $c->res->body($body);
    my $res = $c->res->finalize();
    $c->finished(1);
    return $res;
}

sub handle_not_found {
    my $c = shift;
    $c->res->code(404);
    $c->res->body('not found');;
    $c->res->finalize();
}

sub redirect {
    my( $c, $url, $code ) = @_;
    $code ||= 302;
    $c->res->redirect($url,$code);
    $c->finished(1);
}

sub PREPARE {
    my $c = shift;
    my $db = Twh::DB->new();
    # XXX error handle.
    $db->connect();
    $c->db($db);
}
sub FINALIZE {
    my $c = shift;
    $c->db->disconnect();
}

sub member {
    my $c = shift;
    if($c->req->session->{loggin} && $c->req->session->{member_hash} ){
        return $c->req->session->{member_hash};
    }
    else {
        return;
    }

}
__PACKAGE__->meta->make_immutable();

no Mouse;
1;
