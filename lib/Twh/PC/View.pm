package Twh::PC::View;
use Mouse;
extends 'Twh::View';
use Twh::Home;
my $home = Twh::Home->get;
__PACKAGE__->path([ 
$home->file('view/pc')->stringify ,
$home->file('view/pc/include')->stringify 
] );




__PACKAGE__->meta->make_immutable();

no Mouse;
1;
# 手抜きView.
