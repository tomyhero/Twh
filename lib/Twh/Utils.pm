package Twh::Utils;
use warnings;
use strict;
use Plack::Util;
use MIME::Base64 qw(encode_base64 decode_base64);
use Storable qw(freeze thaw);
use Time::Piece;

sub hash2base64 {
    my $hash = shift;
    return encode_base64( freeze( $hash ) ) ;
}
sub base642hash {
    my $base64 = shift;
    return thaw( decode_base64( $base64 ) ) ;
}
sub load_class {
    Plack::Util::load_class(@_);
}

sub now { localtime() }

1;
