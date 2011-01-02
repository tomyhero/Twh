package Twh::Bitly;
use warnings;
use strict;
use WebService::Bitly ;
use Twh::Config;

sub new {
    my $api_key = Twh::Config->instance->get('bitly','api_key');
    WebService::Bitly->new(
            user_name => 'tomyhero',
            user_api_key => $api_key,
    );
}



1;
