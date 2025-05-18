var scrollTimeout;

$( window ).on( 'load', function() {
	//If window has been scrolled or no viewport, don't auto scroll
	if (window.scrollY || window.scrollX)
		return;

	var scrollTargetId = 'intro-title-animated-background';
	if (document.getElementById(scrollTargetId)) {
		scrollTimeout = setTimeout(function () { 
			if (window.scrollY || window.scrollX)
				return;
	    	var title = document.getElementById(scrollTargetId);
	    	zenscroll.to(title)
			//zenscroll.center(title);
		}, 10000);
	}
});

//If user clicks anywhere or scrolls themselves, don't scroll programmatically to title.
$( window ).on( 'scroll', function() {
	clearTimeout(scrollTimeout);
});
$( window ).on( 'click', function() {
	clearTimeout(scrollTimeout);
});
