use warnings;
use strict;
use Router::Simple::Declare;

my $router = router {
    submapper ('/' , { controller => 'Root' } )
        ->connect('', {action => 'index' });
};

$router;
