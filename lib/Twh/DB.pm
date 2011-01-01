package Twh::DB;
use Mouse;

sub connect {
warn 'todo connect';
}
sub disconnect {
warn 'todo disconnect';

}




__PACKAGE__->meta->make_immutable();
no Mouse;

1;
