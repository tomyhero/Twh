package Twh::Controller::User;
use Mouse;
extends 'Twh::Controller::Base';

sub view {
    my ( $self, $c ,$args ) = @_;
    $c->template('user/view.tx');
    my $api_res = $c->api('User')->lookup( $args );
    if($api_res->has_error){
        $c->stash->{args} = $args;
        $c->template('user/view_notfound.tx');
    }
    else {
        $c->append_stash( $api_res->stash );
    }
}

sub houfu {
    my ( $self, $c ,$args ) = @_;
    $c->template('user/houfu.tx');
    my $api_res = $c->api('User')->lookup_houfu( $args );
    if($api_res->has_error){
        return $c->handle_not_found();
    }
    else {
        $c->append_stash( $api_res->stash );
    }
}


__PACKAGE__->meta->make_immutable();
no Mouse;

1;
