package Twh::Utils;
use warnings;
use strict;
use Plack::Util;


sub load_class {
    Plack::Util::load_class(@_);
}
1;
