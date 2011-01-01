package Twh::Config;
use warnings;
use strict;
use parent 'Class::Singleton';
use Plack::Util::Accessor qw(_config);
use Twh::Home;
use Log::Minimal;

sub _new_instance {
    my $class = shift;
    my $self  = bless { }, $class;
    my $config = $self->_load_config();
    $self->_config($config);
    return $self;
}

sub get {
    my $self = shift;
    my $key = shift;
    my $section = shift;

    if($section){
        return $self->_config->{$key}{$section};
    }
    else {
        return $self->_config->{$key};
    }

}

sub _load_config {
    my $self = shift;
    my $files = $self->_get_config_files();
    my %config = ();
    for my $file( @{$files} ) {
        my $data = do $file;     
        for my $key( keys %$data ) {
            $config{$key} = $data->{$key};
        }
    }
    return \%config;
}
sub _get_config_files {
    my $self = shift; 
    my @files = ();
    my $base = $self->path_to('etc/config.pl');
    push @files ,$base;

    # additional config file.
    if ( my $env = $ENV{'TWH_ENV'} ) { 
        my $filename = sprintf 'etc/config_%s.pl', $env;
        die 'no config file found :' . $self->path_to($filename)  unless  -f $self->path_to($filename); 
        push @files, $self->path_to( $filename );
    }
    return \@files;
}

sub path_to {
    my ($self, @path ) = @_;
    return Twh::Home->get->file( @path );
}

1;
