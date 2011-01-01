package Twh::Twitter;
use Net::Twitter::Lite ;
use Twh::Config;

sub new{
    my $config = Twh::Config->instance()->get('twitter');
    my $nt = Net::Twitter::Lite ->new( %$config );
    return $nt;
}


1;
