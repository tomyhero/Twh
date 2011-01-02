package Twh::API::Result;
use Mouse;

has 'stash' =>( is => 'rw');
has 'v_res' => (is => 'rw');

sub has_error {
    my $self =shift;
     if(my $v_res = $self->v_res){
        return $v_res->has_error || 0 ; 
     }
     else {
        return 0;
     }

}




__PACKAGE__->meta->make_immutable();
no Mouse;

1;
