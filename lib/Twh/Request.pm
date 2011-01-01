package Twh::Request;
use strict;
use warnings;
use parent('Plack::Request');
use Hash::MultiValue;
use Encode;

sub query_parameters {
    my $self = shift;
    $self->env->{'plack.request.query'} ||= $self->decode_multivalue( Hash::MultiValue->new($self->uri->query_form) );
}
sub body_parameters {
    my $self = shift;
    unless ($self->env->{'plack.request.body'}) {
        $self->_parse_request_body;
        $self->env->{'plack.request.body'} = $self->decode_multivalue( $self->env->{'plack.request.body'} );
    }

    return $self->env->{'plack.request.body'};
}


sub decode_multivalue {
    my $self = shift;
    my $hash = shift;
    my $params = $hash->mixed;
    my $decoded_params = {};
    while (my($k, $v) = each %$params) {
        $decoded_params->{decode_utf8($k)} = ref $v eq 'ARRAY'
            ? [ map decode_utf8($_), @$v ] : decode_utf8($v);
    }
    return Hash::MultiValue->from_mixed(%$decoded_params);
}

sub as_fdat {
    my $self = shift;
    $self->parameters->as_hashref_mixed;
}

1;
