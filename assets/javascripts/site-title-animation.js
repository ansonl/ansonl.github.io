$( document ).ready(function() {
	
	//Have surrounding h1 take on content height so it takes up space in DOM and other elements push down.
	$("h1.intro-title").height($("#intro-title-animated-background").height());

	$("#intro-title-static").remove();
	siteTitleAnimate();
});

function siteTitleAnimate() {
	var preloadedStrings = ["Code .  ^500 Run .  ^500 Eat .  ^500 Sleep  ^1500 ↺  "];

	$("#intro-title-animated").typed({
		strings: preloadedStrings,
		contentType: 'html',
		showCursor: false,
		cursorChar: "&#9608;",
		startDelay: 3000,
		loop: true,
		loopCount: false,
		typeSpeed: -10,
		backSpeed: 200,
		backDelay: 10000,
		callback: function() {
			
		}
	});
}