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


    submapper ('/houfu/' , { controller => 'Houfu' } )
        ->connect('{houfu_code:[0-9a-zA-Z_-]+}/add/', {action => 'add' });


    submapper ('/user/' , { controller => 'User' } )
        ->connect('{screen_name:[0-9a-zA-Z_]+}/', {action => 'view' })
        ->connect('{screen_name:[0-9a-zA-Z_]+}/{houfu_code:[0-9a-zA-Z_-]+}/', {action => 'houfu' });
};

$router;
