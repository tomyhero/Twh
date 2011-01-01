package Twh::Controller::Base;
use Mouse;
use Twh::DB;

has 'db' => (
    is => 'rw',
);

sub prepare {
    my ($self,$c) = @_;
    my $db = Twh::DB->new();
    # XXX error handle.
    $db->connect();
    $self->db($db);

}
sub finalize {
    my ($self,$c) = @_;
    $self->db->disconnect();
}

__PACKAGE__->meta->make_immutable();
no Mouse;

1;
