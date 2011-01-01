use Test::Most;
use_ok('Twh::Home');

isnt( Twh::Home->get() , '/tmp' );

done_testing();
