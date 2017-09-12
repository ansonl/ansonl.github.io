var scrollTimeout;

$( window ).on( 'load', function() {
	var scrollTargetId = 'intro-title-animated-background';
	if (document.getElementById(scrollTargetId)) {
		scrollTimeout = setTimeout(function () { 
	    var title = document.getElementById(scrollTargetId);
	    zenscroll.to(title)
			//zenscroll.center(title);
		}, 2500);
	}
});

//If user scrolls themselves, don't scroll programmatically to title.
$( window ).on( 'scroll', function() {
	clearTimeout(scrollTimeout);
});
