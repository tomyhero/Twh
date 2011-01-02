package Twh::Utils;
use warnings;
use strict;
use Plack::Util;
use MIME::Base64 qw(encode_base64 decode_base64);
use Storable qw(freeze thaw);
use Time::Piece;
use Twh::Bitly;

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

sub short_url {
    my $url = shift;
    my $bitly = Twh::Bitly->new();

    my $shorten = $bitly->shorten($url);
    if ($shorten->is_error) {
        return $url;
    }
    else {
        return $shorten->short_url;
    }
}
1;
