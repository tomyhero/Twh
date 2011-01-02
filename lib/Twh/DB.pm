package Twh::DB;
use Mouse;
use DBI;
with 'Twh::Role::Config';

has dbh => ( is => 'rw' );


sub authorize {
    my $self = shift;
    my $args = shift;

    my $member_hash = $self->lookup_member($args->{screen_name});

    if($member_hash){
        # 更新
        {
            my $sql = "UPDATE member SET access_token = ?, access_token_secret = ?, icon_url = ?, updated_at = NOW() WHERE screen_name = ?";
            my $sth = $self->dbh->prepare($sql);
            $sth->execute($args->{access_token},$args->{access_token_secret},$args->{icon_url},$args->{screen_name});
            $sth->finish;
        }
    }
    else {
        # 追加
        {
            my $sql = "INSERT INTO member (screen_name,access_token,access_token_secret,icon_url,num_of_houfu,updated_at,created_at) VALUES (?,?,?,?,0,NOW(),NOW())";
            my $sth = $self->dbh->prepare($sql);
            $sth->execute($args->{screen_name},$args->{access_token},$args->{access_token_secret},$args->{icon_url});
            $sth->finish;
        }
    }
    return $self->lookup_member($args->{screen_name});
}


sub lookup_member {
    my $self = shift;
    my $screen_name = shift;
    my $sql = "SELECT * FROM member WHERE screen_name = ?";
    my $sth = $self->dbh->prepare($sql);
    $sth->execute($screen_name);
    my $member_hash = $sth->fetchrow_hashref;
    $sth->finish;
    return $member_hash;
}








sub connect {
    my $self = shift;
    my $config = $self->config->get('db');
    my $dbh = DBI->connect($config->{dsn}, $config->{user},$config->{password}, {
        RaiseError => 1,
        AutoCommit => 1,
    });
    $self->dbh($dbh);
}
sub disconnect {
    my $self= shift;
    $self->dbh->disconnect();

}




__PACKAGE__->meta->make_immutable();
no Mouse;

1;
