package Twh::API::User;
use Mouse;
use Log::Minimal;
extends 'Twh::API::Base';

sub profiles {
    +{
        lookup => {
            required => [qw/screen_name/],
        },
        lookup_houfu => {
            required => [qw/houfu_code screen_name/],
        }
    } 
}

sub lookup {
    my $self = shift;
    my $args = shift;
    my $v_res = $self->validate( $args );
    my $stash = {};
    if(!$v_res->has_error){
        my $v = $v_res->valid;
        my $user_hash  = $self->db->lookup_member( $v->{screen_name} );
        $stash->{user_hash} = $user_hash;
    }
     return $self->create_result_set( { v_res => $v_res , stash => $stash } );
}
sub lookup_houfu {
    my $self = shift;
    my $args = shift;
    my $v_res = $self->validate( $args );
    my $stash = {};
    if(!$v_res->has_error){
        my $v = $v_res->valid;
        my $user_hash  = $self->db->lookup_member( $v->{screen_name} );
        my $houfu_hash = $self->db->lookup_houfu( $v->{screen_name},$v->{houfu_code});
        $stash->{user_hash} = $user_hash;
        $stash->{houfu_hash} = $houfu_hash;
    }

     return $self->create_result_set( { v_res => $v_res , stash => $stash } );
}


__PACKAGE__->meta->make_immutable();
no Mouse;

1;
