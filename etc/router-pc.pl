use warnings;
use strict;
use Router::Simple::Declare;

my $router = router {
    submapper ('/' , { controller => 'Root' } )
        ->connect('', {action => 'index' })
        ->connect('callback/twitter/', {action => 'callback_twitter' });

    submapper ('/auth/' , { controller => 'Auth' } )
        ->connect('logout/', {action => 'logout' })
        ->connect('login/', {action => 'login' });
};

$router;
