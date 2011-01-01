package Twh::Validator::Result;

use strict;
use warnings;
use parent qw(FormValidator::LazyWay::Result);

sub dump_error {
    my $self = shift;
    my $e = {};
    for(qw/invalid missing custom_invalid/){
        $e->{$_} = $self->{$_};
    }
    return $e;
}

sub error_fields {
    my $self = shift;
    my @f = ();

    if(ref $self->missing ){
        for(@{$self->missing}){
            push @f,$_;
        }
    }

    if(ref $self->invalid ){
        for my $key (keys %{$self->invalid} ){
            push @f,$key;
        }
    }
    return \@f;
}

1;
