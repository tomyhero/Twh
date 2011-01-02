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
        },
        edit_wiki_body => {
            required => [qw/houfu_code screen_name wiki_body/],
        }
    } 
}

sub edit_wiki_body {
    my $self = shift;
    my $args = shift;
    my $v_res = $self->validate( $args );
    my $stash = {};
    if(!$v_res->has_error){
        my $v = $v_res->valid;
        $self->db->edit_houfu_wiki_body( $v );
    }
    return $self->create_result_set( { v_res => $v_res , stash => $stash } );
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
    my $member = shift;
    my $base_url = shift;
    my $v_res = $self->validate( $args );
    my $stash = {};
    if(!$v_res->has_error){
        my $v = $v_res->valid;
        $self->db->add_houfu( $v );

        my $twitter =  Twh::Twitter->new();
        $twitter->access_token( $member->{access_token} );
        $twitter->access_token_secret( $member->{access_token_secret} );
        my $url = Twh::Utils::short_url( sprintf('%suser/%s/%s/',$base_url,$v->{screen_name},$v->{houfu_code}) );
        my $text = $v->{body} . ' #houfu ' .$url;
        $twitter->update( $text );    
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
