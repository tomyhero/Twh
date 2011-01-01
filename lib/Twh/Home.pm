package Twh::Home;
use strict;
use warnings;
use Twh::Utils;
use Path::Class;
our $HOME ;

sub get {
    my $class = shift;
    if($HOME){
        return $HOME;
    }
    else {
        $HOME = $class->_home();
        return $HOME;
    }
}

sub _home {
    my $class = shift;
    # Steal code from Pickles::Config
    (my $file = "$class.pm") =~ s|::|/|g;
    if (my $inc_path = $INC{$file}) {
        (my $path = $inc_path) =~ s/$file$//;
        my $home = dir($path)->absolute->cleanup;
        $home = $home->parent while $home =~ /b?lib$/;
        return $home;
    }
    return dir('/tmp/');
}
1;

=head1 NAME

Twh::Home - ホーム取得モジュール

=head1 SYONPSIS

 my $home = Twh::Home->get();

=cut
