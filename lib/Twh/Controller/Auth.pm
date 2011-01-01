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

sub callback {
    my ( $self, $c ) = @_;
    my %params = ( %{$c->req->as_fdat} , base64 => $c->req->cookies->{twitter_oauth}  );
    $c->api('Twitter')->auth(\%params);
}



__PACKAGE__->meta->make_immutable();
no Mouse;

1;
