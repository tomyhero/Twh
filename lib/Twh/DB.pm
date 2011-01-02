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

sub add_houfu {
    my $self = shift;
    my $args = shift;
    my $sql = "INSERT INTO houfu ( screen_name, houfu_code,body,updated_at,created_at) VALUES (?,?,?,NOW(),NOW())";
    my $sth = $self->dbh->prepare($sql);
    $sth->execute($args->{screen_name},$args->{houfu_code}, $args->{body});
    $sth->finish;
}

sub edit_houfu_body {
    my $self = shift;
    my $args = shift;
    my $sql = "UPDATE houfu SET body = ?,updated_at = NOW() WHERE screen_name = ? AND houfu_code = ?";
    my $sth = $self->dbh->prepare($sql);
    $sth->execute($args->{body},$args->{screen_name},$args->{houfu_code});
    $sth->finish;
}

sub edit_houfu_wiki_body {
    my $self = shift;
    my $args = shift;
    my $sql = "UPDATE houfu SET wiki_body = ?,updated_at = NOW() WHERE screen_name = ? AND houfu_code = ?";
    my $sth = $self->dbh->prepare($sql);
    $sth->execute($args->{wiki_body},$args->{screen_name},$args->{houfu_code});
    $sth->finish;
}


sub houfu_recents {
    my $self = shift;
    my $sql = "SELECT * FROM houfu ORDER BY updated_at DESC LIMIT 10"; 
    my $sth = $self->dbh->prepare($sql);
    $sth->execute();
    my @recents = ();
    while(my $houfu_hash = $sth->fetchrow_hashref){
        my $user_hash = $self->lookup_member( $houfu_hash->{screen_name} );
        $houfu_hash->{user_hash} = $user_hash;
        push @recents, $houfu_hash;
    }
    $sth->finish;
    return \@recents;
}
sub lookup_houfu {
    my $self = shift;
    my $screen_name = shift;
    my $houfu_code = shift;
    my $sql = "SELECT * FROM houfu WHERE screen_name = ? AND houfu_code = ?";
    my $sth = $self->dbh->prepare($sql);
    $sth->execute($screen_name,$houfu_code);
    my $houfu_hash = $sth->fetchrow_hashref;
    $sth->finish;
    return $houfu_hash;
}

sub houfu_items {
    my $self = shift;
    my $screen_name = shift;
    my $sql = "SELECT * FROM houfu WHERE screen_name = ? ORDER BY updated_at DESC "; 
    my $sth = $self->dbh->prepare($sql);
    $sth->execute( $screen_name );
    my @items= ();
    while(my $houfu_hash = $sth->fetchrow_hashref){
        push @items, $houfu_hash;
    }
    $sth->finish;
    return \@items;
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
