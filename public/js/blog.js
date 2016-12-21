document.addEventListener("DOMContentLoaded", function() {
    hljs.initHighlightingOnLoad()
});

(function() {
	var d = document, s = d.createElement('script');
	var shortname = document.getElementById("disqus_thread").dataset.shortname
	s.src = '//' + shortname + '.disqus.com/embed.js';
	s.setAttribute('data-timestamp', +new Date());
	(d.head || d.body).appendChild(s);
})();