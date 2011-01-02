package Twh::Wiki;
use warnings;
use strict;
use base qw(Class::Singleton);
use Text::Livedoor::Wiki;

sub _new_instance {
    my $parser = Text::Livedoor::Wiki->new(
        { opts => { 
            storage => '/wiki/' 
        }}
    );
    return $parser;
}



1;
