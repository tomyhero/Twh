package Twh::Controller::Root;
use Mouse;
extends 'Twh::Controller::Base';


sub index {
    my ( $self, $c ) = @_;
}

sub callback_twitter {
    my ( $self, $c ) = @_;
    my %params = ( %{$c->req->as_fdat} , base64 => $c->req->cookies->{twitter_oauth}  );
    $c->api('Twitter')->auth(\%params);
}


__PACKAGE__->meta->make_immutable();
no Mouse;

1;
