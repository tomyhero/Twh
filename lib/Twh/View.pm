package Twh::View;
use Mouse;
use parent('Class::Data::Inheritable');
use Text::Xslate;
use Encode;

__PACKAGE__->mk_classdata('path');

has 'tx' => (is => 'rw');

sub BUILD {
    my $self = shift;
    $self->create_tx();

}

sub create_tx {
    my $self = shift;
    my $tx = Text::Xslate->new( 
        syntax => 'TTerse' ,
        path => $self->path,
    );
    $self->tx($tx);
}

sub render {
    my $self = shift;
    my $c = shift;
    my $template = shift;
    my %vars = (
        %{$c->stash},
        c => $c,
    );
    my $output = $self->tx->render( $template, \%vars );
    $output = encode('utf8',$output);
    return $output;
}


__PACKAGE__->meta->make_immutable();

no Mouse;
1;
# 手抜きView.
