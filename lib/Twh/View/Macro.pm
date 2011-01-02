package Twh::View::Macro;

use warnings;
use strict;
use base qw/Exporter/;
use Twh::Wiki;
use Text::Xslate::Util;

our @EXPORT = qw(
    wiki
);

sub wiki {
    my $text = shift;
    my $wiki = Twh::Wiki->instance();
    Text::Xslate::Util::mark_raw($wiki->parse($text));
}

1;
