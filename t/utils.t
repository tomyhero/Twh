use Test::Most;

use_ok('Twh::Utils');

{
    my $hash = {
        hoge => 1,
        hage => 2,
    };

    my $base64 = Twh::Utils::hash2base64($hash );
    is($base64,"BAcIMTIzNDU2NzgECAgIAwIAAAAIggQAAABoYWdlCIEEAAAAaG9nZQ==\n");

    my $res = Twh::Utils::base642hash($base64);
    is_deeply($res,$hash);
}


done_testing();
