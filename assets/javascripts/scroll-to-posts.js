var scrollTimeout;

$( window ).on( 'load', function() {
	scrollTimeout = setTimeout(function () { 
    var title = document.getElementById('intro-title-animated-background');
    zenscroll.to(title)
		//zenscroll.center(title);
	}, 2500);
});

//If user scrolls themselves, don't scroll programmatically to title.
$( window ).on( 'scroll', function() {
	clearTimeout(scrollTimeout);
});
