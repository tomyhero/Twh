package Twh::API::Twitter;
use Mouse;
use Twh::Twitter;
use Twh::Utils;
use Log::Minimal;
extends 'Twh::API::Base';
with 'Twh::Role::Config';

sub profiles {
    +{
        auth => {
            required => [qw/oauth_verifier base64/],
        }
    } 
}
sub _back_url {
    my $self= shift;
    my $url = shift;
    if($url){
        return $url;
    }
    else {
        return 'http://lazy-people.org/';
    }
}
sub prepare_auth {
    my $self = shift;
    my $args = shift;
    my $twitter = Twh::Twitter->new(); 
    my $url = $twitter->get_authentication_url(callback => $self->config->get('twitter','callback'));

    my $data = {
        request_token => $twitter->request_token,
        request_token_secret => $twitter->request_token_secret,
        url => $self->_back_url($args->{url}),
    };
    my $base64 = Twh::Utils::hash2base64( $data );

    return {
        url => $url,
        base64 => $base64,
    }

}

sub auth {
    my $self = shift;
    my $args = shift;
    my $v_res = $self->validate( $args );
    my $stash = {};
    if(!$v_res->has_error){
        my $v = $v_res->valid;
        my $opts = Twh::Utils::base642hash( $v->{base64} );
        my $verifier = $v->{oauth_verifier};

        my $twitter = Twh::Twitter->new(); 
        $twitter->request_token($opts->{request_token});
        $twitter->request_token_secret($opts->{request_token_secret} );
        my($access_token, $access_token_secret,$user_id, $screen_name) = $twitter->request_access_token(verifier => $verifier);



    }

     return $self->create_result_set( { v_res => $v_res , stash => $stash } );

}


__PACKAGE__->meta->make_immutable();
no Mouse;

1;
