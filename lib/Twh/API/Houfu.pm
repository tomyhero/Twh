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
        },
        edit_body => {
            required => [qw/houfu_code screen_name body/],
        }
    } 
}

sub edit_body {
    my $self = shift;
    my $args = shift;
    my $v_res = $self->validate( $args );
    my $stash = {};
    if(!$v_res->has_error){
        my $v = $v_res->valid;
        $self->db->edit_houfu_body( $v );
    }
    return $self->create_result_set( { v_res => $v_res , stash => $stash } );
}

sub add {
    my $self = shift;
    my $args = shift;
    my $v_res = $self->validate( $args );
    my $stash = {};
    if(!$v_res->has_error){
        my $v = $v_res->valid;
        $self->db->add_houfu( $v );
    }
    return $self->create_result_set( { v_res => $v_res , stash => $stash } );
}

sub x_recents {
    my $self = shift;
    return $self->db->houfu_recents();
}

__PACKAGE__->meta->make_immutable();
no Mouse;

1;
