use Test::Most;
use_ok('Twh::Config');

BEGIN {
    $ENV{TWH_ENV} = 'test';    
}

my $config = Twh::Config->instance();
is($config->get('name'), 'test');

done_testing();
