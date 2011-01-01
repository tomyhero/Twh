#!/usr/bin/env perl
use warnings;
use strict;
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
use Twh::PC;

my $psgi_handler =Twh::PC->new->psgi_handler();

return $psgi_handler;
