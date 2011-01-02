<html>
<head>
<title>[% title || '抱負なう' %]</title>
<link rel="stylesheet" type="text/css" href="/wiki/css/cpan-like.css"  />
<link rel="stylesheet" type="text/css" href="/css/default.css"  />
</head>
<body>
<div id="header">
<div id="logo">
抱負なう <span style="font-size:12px;">- みんなの抱負で日本をもりあげよう - </span>
<div id="login-status">
[% IF c.member %]
    [% c.member.screen_name %]( <a href="/auth/logout/"><span style="font-size:12px">ログアウト</span></a> )
[% ELSE %]
    <a href="/auth/login/">ログイン</a>
[% END %]
</div>
</div>

<div>
    <ul id="breadcrumb">
        <li><a href="/" title="Home"><img src="/images/home.png" alt="Home" class="home" /></a></li>
        [% FOREACH bread IN breadcrumb %]
            [% IF bread.url %]
            <li><a href="[% bread.url %]" title="[% bread.label %]">[% bread.label %]</a></li>
            [% ELSE %]
            <li>[% bread.label %]</li>
            [% END %]
        [% END %]
    </ul>
</div>
</div>
<div id="wrap">
<div id="main">
