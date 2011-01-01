create table member (
    screen_name varchar(255) PRIMARY KEY NOT NULL,
    access_token varchar(255) NOT NULL,
    access_token_secret varchar(255) NOT NULL,
    icon_url varchar(255) NOT NULL,
    updated_at DATETIME NOT NULL,
    created_at DATETIME NOT NULL
) ENGINE=InnoDB DEFAULT CHARACTER SET = 'utf8';
