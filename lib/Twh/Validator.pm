package Twh::Validator;
use warnings;
use strict;
use parent qw(Class::Singleton);
use FormValidator::LazyWay;;
use YAML::Syck();
use Data::Section::Simple;
sub create_config {
    my $reader = Data::Section::Simple->new(__PACKAGE__);
    my $yaml = $reader->get_data_section('validate.yaml');
    my $data = YAML::Syck::Load( $yaml);
    return $data;
}
sub _new_instance {
    my $class = shift;
    my $config = $class->create_config(); 
    use Data::Dumper;
    warn Dumper $config;
    return FormValidator::LazyWay->new( config => $config ,result_class => 'Twh::Validator::Result' );
}


1;

__DATA__
@@ validate.yaml
lang: ja
rules:
    - Number
    - String
setting:
    strict:
        oauth_verifier : 
            rule :
            - String#length:
                max: 255
                min: 1
        base64: 
            rule :
            - String#length:
                max: 255
                min: 1
