package Twh::Dispatcher;
use Mouse;
use Log::Minimal;

has 'router' => (
    is => 'rw',
    required => 1,
);

has 'controller' => (
    is => 'rw',
    required => 1,
);

sub match {
    my $self= shift;
    my $c = shift;
    my $path  = $c->req->path_info;
    if( my $res = $self->router->match($path) ){
        my $controller = $self->controller->{$res->{controller}};
        unless($controller){
            warnf('could not found controller %s', $res->{controller} );
            $c->handle_not_found();
            return;
        }
        my $action = $res->{action};
        unless( $controller->can( $action ) ){
            warnf('could not found aciton [%s][%s]', $res->{controller} ,$res->{action});
            $c->handle_not_found();
            return;
        }
        $controller->$action( $c );
        $self->set_template( $c, $res );
        $c->render();
    }
    else {
        $c->handle_not_found();
    }
}
sub set_template {
    my $self= shift;
    my $c = shift;
    my $res = shift;
    if($res->{controller} eq 'Root') {
        $c->template( sprintf('%s.tx',lc $res->{action} ));
    }
    else {
        $c->template( sprintf('%s/%s.tx',lc $res->{controller},$res->{action} ));
    }
}

__PACKAGE__->meta->make_immutable();

no Mouse;
1;
