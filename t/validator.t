use Test::Most;
use File::Spec;
our @LIBS;
BEGIN {
    my $base = $ENV{TWH_HOME} || '.';
    @LIBS = (
        File::Spec->catdir($base, 'extlib/lib/perl5/'),
        File::Spec->catdir($base, 'lib'),
    );
}
use lib @LIBS;
use_ok('Twh::Validator');

{
    my $validator = Twh::Validator->instance();
}


done_testing();
