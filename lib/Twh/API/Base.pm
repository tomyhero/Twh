package Twh::API::Base;
use Mouse;
use Twh::Validator;
use Log::Minimal;
use Twh::API::Result;

sub profiles {
    my $class = shift;
    die 'abstract';
}

sub validator {
    return Twh::Validator->instance();
}

sub validate {
    my ($self,$data,$name,$stash) = @_;
    unless ($name) {
        ($name = (caller 1)[3]) =~ s/.*:://;
    }

    my $profile = $self->profiles->{$name} or die 'profile not found:' . $name ;

    if($stash){
        $profile->{stash} = $stash;
    }

    my $form
        = $self->validator->check( $data , $profile );

    return $form;
}

sub create_result_set {
    my $self = shift;
    my $args = shift;
    my $v_res = $args->{v_res} || Twh::Validator::Result->new();
    my $stash = $args->{stash} || {};

    $stash->{v} = $v_res->valid; # auto set.

    Twh::API::Result->new( v_res => $v_res , stash => $stash );
}

# XXX
sub create_error_set {
    my $self = shift;
    my $v_res = shift || Twh::Validator::Result->new();
    my $reason = shift || 'system_error';
    $v_res->custom_invalid($reason,$reason);
    Twh::API::Result->new( v_res => $v_res );
}

sub critf_validate {
    my $self = shift;
    my $api_res = shift;
    my $data = shift;
    my $e = {};
    for(@{$api_res->v_res->error_fields()}){
        $e->{$_} = $data->{$_};
    }
    critff('VALIDATION ERROR: error_dump:%s error_value_dump:%s',ddf($api_res->v_res->dump_error ), ddf($e) );
}

__PACKAGE__->meta->make_immutable();
no Mouse;

1;
