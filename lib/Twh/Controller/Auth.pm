package Twh::Controller::Auth;
use Mouse;
extends 'Twh::Controller::Base';

sub logout {
    my ( $self, $c ) = @_;
    $c->req->session->{loggin} = 0;
    $c->redirect('/');
}
sub login {
    my ( $self, $c ) = @_;
    my $data = $c->api('Twitter')->prepare_auth(  $c->req->as_fdat );
    $c->res->cookies->{twitter_oauth} = { 
        value => $data->{base64} ,
        path => '/',     
    };
    $c->redirect($data->{url}); 
}

sub callback {
    my ( $self, $c ) = @_;
    my %params = ( %{$c->req->as_fdat} , base64 => $c->req->cookies->{twitter_oauth}  );
    my $api_res = $c->api('Twitter')->auth(\%params);
    $c->res->cookies->{twitter_oauth} = { 
        value => 1,
        expires => time - 24 * 60 * 60,
    };
    if(!$api_res->has_error){
        $c->req->session->{loggin} = 1;
        $c->req->session->{member_hash} = $api_res->stash->{member_hash};
        $c->redirect('/');
    }
    else {
        # XXX 
        $c->redirect('/');
    }
}



__PACKAGE__->meta->make_immutable();
no Mouse;

1;
