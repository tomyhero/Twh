
<div id="houfu-timeline"></div>
<script src="http://widgets.twimg.com/j/2/widget.js"></script>
<script>
new TWTR.Widget({
version: 2,
id: 'houfu-timeline',
type: 'search',
search: '#houfu',
interval: 1000,
subject: '最近の抱負',
width: 500,
height: 240,

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
</body>
</html>
