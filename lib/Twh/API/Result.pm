package Twh::API::Result;
use Mouse;

has 'stash' =>( is => 'rw');
has 'errors' =>( is => 'rw');

sub has_error {
    my $self =shift;
    if($self->errors){
        return 1;
    }
    else {
        return 0;
    }

}




__PACKAGE__->meta->make_immutable();
no Mouse;

1;
