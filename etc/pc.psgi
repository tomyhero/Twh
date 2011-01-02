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
#use Devel::KYTProf;

my $psgi_handler =Twh::PC->new->psgi_handler();
use Plack::Session::Store::Cache;
use Plack::Session::State::Cookie;
use Cache::FastMmap;
use Twh::Home;
use Twh::Config;

use Plack::Builder;

my $config = Twh::Config->instance();

my $cache = Cache::FastMmap->new( expire_time => '7d' , share_file =>  $config->get('session','share_file')  );
my $home = Twh::Home->get();
builder {
    enable_if { $_[0]->{REMOTE_ADDR} eq '127.0.0.1' }
            "Plack::Middleware::ReverseProxy";
    enable 'Static',
        path => qr{^/(images|js|css|wiki)/}, root => $home->subdir('htdocs');

    enable 'Session', 
        state => Plack::Session::State::Cookie->new( session_key =>  $config->get('session','session_key')   ),
        store => Plack::Session::Store::Cache->new( cache => $cache );

    $psgi_handler;
};
