package Twh::Controller::Houfu;
use Mouse;
extends 'Twh::Controller::Base';


sub add {
    my ( $self, $c ,$args ) = @_;

    if($c->req->method eq 'POST') {
        my $houfu_code = $args->{houfu_code};
        my $data = $c->req->as_fdat;
        $data->{houfu_code} = $houfu_code;
        $data->{screen_name} = $c->member->{screen_name};
        my $api_res = $c->api('Houfu')->add($data);

        if($api_res->has_error){
            return $c->handle_error($api_res->v_res->errors);
        }



    }
    else {
        $c->redirect('/');
    }
}


__PACKAGE__->meta->make_immutable();
no Mouse;

1;
