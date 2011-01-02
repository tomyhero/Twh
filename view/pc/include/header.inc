<html>
<head>
<title>ほうふなう</title>
<link rel="stylesheet" type="text/css" href="/css/default.css"  />
<link rel="stylesheet" type="text/css" href="/wiki/css/cpan-like.css"  />
</head>
<body>
<div id="header">
<h1>ほうふなう</h1>
<div id="login-status">
[% IF c.member %]
    [% member.screen_name %]  <a href="/auth/logout/">logout</a>
[% ELSE %]
    <a href="/auth/login/">login</a>
[% END %]
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
<div id="main">
