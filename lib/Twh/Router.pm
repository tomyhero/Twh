package Twh::Router;
use Mouse;

has 'file' => (
    is => 'rw',
    required => 1,
);

sub get {
    my $self = shift;
    my $file = $self->file->stringify;
    die 'could not found:' . $file unless -e $file ;
    my $router = do $file or die $!;
    return $router;
}

__PACKAGE__->meta->make_immutable();

no Mouse;

1;
