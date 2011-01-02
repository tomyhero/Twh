use Test::Most;
our @LIBS;
BEGIN {
    my $base = $ENV{TWH_HOME} || '.';
    @LIBS = (
        File::Spec->catdir($base, 'extlib/lib/perl5/'),
        File::Spec->catdir($base, 'lib'),
    );
}
use lib @LIBS;

use_ok('Twh::Bitly');
my $bitly = Twh::Bitly->new();

my $shorten = $bitly->shorten('http://lazy-programmer.com/');
if ($shorten->is_error) {
    warn $shorten->status_code;
    warn $shorten->status_txt; 
    ok(0);
}
else {
    my $short_url = $shorten->short_url;
    is($short_url,'http://bit.ly/hFCrIN');
}


done_testing();
