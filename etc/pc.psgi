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

$Log::Minimal::AUTODUMP=1;
use Devel::KYTProf;

my $psgi_handler =Twh::PC->new->psgi_handler();
use Plack::Session::Store::Cache;
use Plack::Session::State::Cookie;
use Cache::FastMmap;
use Twh::Home;

use Plack::Builder;
my $cache = Cache::FastMmap->new( expire_time => '7d' , share_file => '/tmp/twh' );
my $home = Twh::Home->get();
builder {
    enable 'Static',
        path => qr{^/(images|js|css|wiki)/}, root => $home->subdir('htdocs');

    enable 'Session', 
        state => Plack::Session::State::Cookie->new( session_key => 'twh_session' ),
        store => Plack::Session::Store::Cache->new( cache => $cache );
    $psgi_handler;
};
