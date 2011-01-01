package Twh::Role::Config;
use Mouse::Role;
use Twh::Config;
sub config {
    Twh::Config->instance();
}


1;
