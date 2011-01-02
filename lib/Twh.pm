package Twh;
use strict;
use warnings;
our $VERSION = '0.01';
use Twh::Home;
use Twh::Utils;
use Twh::Config;
use Twh::Router;
use Twh::Dispatcher;
use Module::Pluggable::Object;
use parent('Class::Data::Inheritable');
use Plack::Util::Accessor qw(home config router api controller dispatcher view);
__PACKAGE__->mk_classdata('interface');

our $VERSION = '0.01';

sub new {
    my $class = shift;
    my $self = bless {},$class;
    $self->_setup();
    return $self;
}

sub psgi_handler {
    my $self = shift;
    my $app = sub {
        my $env = shift;
        my $c = $self->_create_context( $env );
        $c->dispatch;
    };
}
sub _create_context {
    my $self = shift;
    my $env = shift;
    my $context_class = 'Twh::' . $self->interface . '::Context';
    Twh::Utils::load_class($context_class);
    my $context = $context_class->new({ 
        dispatcher => $self->dispatcher ,
        view => $self->view,
        env => $env
    });

}

sub _setup {
    my $self = shift;
    $self->_setup_home();
    $self->_setup_config();
    $self->_setup_router();
    $self->_setup_controller();
    $self->_setup_dispatcher();
    $self->_setup_view();
}

sub _setup_dispatcher {
    my $self = shift;
    my $dispatcher = Twh::Dispatcher->new( router => $self->router , controller => $self->controller);
    $self->dispatcher($dispatcher);
}

sub _setup_home {
    my $self = shift;
    $self->home(Twh::Home->get());
}
sub _setup_config {
    my $self = shift;
    $self->config(Twh::Config->instance());
}

sub _setup_router{
    my $self = shift;
    my $file = $self->home->file('etc/router-' . lc($self->interface) . '.pl');
    my $router = Twh::Router->new( file => $file )->get(); 
    $self->router($router);
}

sub _setup_controller {
    my $self = shift;
    my $parent = 'Twh::' . $self->interface  . '::Controller';
    my $finder = Module::Pluggable::Object->new(
        search_path => [ $parent ],
        'require' => 1
    );
    my @classes = $finder->plugins;
    my $controller = {};
    for(@classes){
        my ($moniker) = $_ =~ /^${parent}::(.*)/;
        $controller->{$moniker} = $_->new();
    }

    $self->controller( $controller );
}
sub _setup_view {
    my $self = shift;
    my $view_class = 'Twh::' . $self->interface  . '::View';
    Twh::Utils::load_class($view_class);
    $self->view( $view_class->new() );
}

1;

=head1 NAME

Twh - ;-) 

=cut
