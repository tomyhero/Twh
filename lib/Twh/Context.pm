package Twh::Context;
use Mouse;
use Twh::Request;
use Twh::Response;

has 'req' => ( is => 'rw',lazy_build => 1);
has 'res' => ( is => 'rw',lazy_build => 1);
has 'env' => ( is => 'rw', required => 1);
has 'dispatcher' => ( is => 'rw');
has 'view' => ( is => 'rw');
has 'stash' => ( is => 'rw' , default => sub{ +{} });
has 'template' => ( is => 'rw');

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
    my $body = $c->view->render($c,$c->template);
    $c->res->content_type('text/html; charset=utf-8;');
    $c->res->body($body);
    $c->res->finalize();
}

sub handle_not_found {
    my $c = shift;
    $c->res->code(404);
    $c->res->body('not found');;
    $c->res->finalize();
}


__PACKAGE__->meta->make_immutable();

no Mouse;
1;
