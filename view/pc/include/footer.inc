</div>
<div id="side">
<div class="box">
<h3>ユーザ検索(twitter名)</h3>
<div style="padding:5px;">
<input type="text" name="screen_name" id="screen_name" ><input type="button" value="さがす" onClick="navToUser();"/>
<form method="get" id="search_form"></form>
</div>
</div>
<div class="box">
<div id="houfu-timeline"></div>
<script src="http://widgets.twimg.com/j/2/widget.js"></script>
<script>

function navToUser(){
    var screen_name = document.getElementById('screen_name').value;
    if(screen_name.length){
        var form = document.getElementById('search_form'); 
        form.action = '/user/' + screen_name + '/';
        form.submit();
    }
}

new TWTR.Widget({
version: 2,
id: 'houfu-timeline',
type: 'search',
search: '#houfu',
interval: 2000,
subject: '抱負つぶやき',
width: 300,
height: 400,

  theme: {
    shell: {
      background: '#fff',
      color: '#000'
    },
    tweets: {
      background: '#ffffff',
      color: '#444444',
      links: '#1985b5'
    }
  }

}).render().start();
</script>
</div>
<div class="box">
<h3>lazy-people.org</h3>
<a href="http://lazy-people.org/"><img src="http://lazy-people.org/htdocs/images/lazysan.png"></a>
</div>
</div>
<div style="clear: both;"></div>
<div id="footer">
<ul class="support">
<li class="template"><a href="http://github.com/tomyhero/Twh">Twh version 0.01</a></li>
</ul>
<address>Copyright &copy; <a href="http://lazy-people.org/">lazy-people.org</a> All Rights Reserved.</address>
</div><!-- END OF footer -->
<div><!-- END OF wrap -->
</body>
</html>
