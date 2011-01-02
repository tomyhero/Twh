create table member (
    screen_name varchar(255) PRIMARY KEY NOT NULL,
    access_token varchar(255) NOT NULL,
    access_token_secret varchar(255) NOT NULL,
    icon_url varchar(255) NOT NULL,
    num_of_houfu int unsigned NOT NULL DEFAULT 0,
    updated_at DATETIME NOT NULL,
    created_at DATETIME NOT NULL
) ENGINE=InnoDB DEFAULT CHARACTER SET = 'utf8';

create table houfu (
    screen_name varchar(255) NOT NULL,
    houfu_code varchar(20) NOT NULL,
    body varchar(140) NOT NULL,
    wiki_body text ,
    updated_at DATETIME NOT NULL,
    created_at DATETIME NOT NULL,
    PRIMARY KEY(screen_name,houfu_code)
) ENGINE=InnoDB DEFAULT CHARACTER SET = 'utf8';
