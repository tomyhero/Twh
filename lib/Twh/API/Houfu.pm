package Twh::API::Houfu;
use Mouse;
use Twh::Twitter;
use Twh::Utils;
use Log::Minimal;
extends 'Twh::API::Base';

sub profiles {
    +{
        add => {
            required => [qw/houfu_code screen_name body/],
        }
    } 
}

sub add {
    my $self = shift;
    my $args = shift;
    my $v_res = $self->validate( $args );
    my $stash = {};
    if(!$v_res->has_error){

    }
    return $self->create_result_set( { v_res => $v_res , stash => $stash } );
}

__PACKAGE__->meta->make_immutable();
no Mouse;

1;
