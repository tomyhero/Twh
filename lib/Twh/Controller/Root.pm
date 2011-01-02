package Twh::Controller::Root;
use Mouse;
extends 'Twh::Controller::Base';


sub index {
    my ( $self, $c ) = @_;
    $c->stash->{recents} = $c->api('Houfu')->x_recents();
}


__PACKAGE__->meta->make_immutable();
no Mouse;

1;
