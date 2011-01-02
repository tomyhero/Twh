<html>
<head>
<title>ほうふなう</title>
<link rel="stylesheet" type="text/css" href="/css/default.css"  />
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
</div>
<div id="main">
