use warnings;
use strict;
use Router::Simple::Declare;

my $router = router {
    submapper ('/' , { controller => 'Root' } )
        ->connect('', {action => 'index' });

    submapper ('/auth/' , { controller => 'Auth' } )
        ->connect('logout/', {action => 'logout' })
        ->connect('login/', {action => 'login' })
        ->connect('callback/', {action => 'callback' });
};

$router;
