package Twh::Controller::Auth;
use Mouse;
extends 'Twh::Controller::Base';

sub logout {
    my ( $self, $c ) = @_;

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


__PACKAGE__->meta->make_immutable();
no Mouse;

1;
