$( document ).ready(function() {
	//Hide static intro
	$("#intro-title-static").remove();

	//Have surrounding h1 take on content height so it takes up space in DOM and other elements push down.
	$("#intro-title-animated-background").show();
	$("h1.intro-title").height($("#intro-title-animated-background").height());

	if (document.getElementById('intro-title-animated'))
		siteTitleAnimate();
});

function siteTitleAnimate() {
	var preloadedStrings = ["Code .  ^500 Run .  ^500 Eat .  ^500 Sleep  ^1000 "];

	var typedJSOptions = {
		strings: preloadedStrings,
		contentType: 'html',
		showCursor: true,
		cursorChar: "&#9608;",
		startDelay: 5000,
		backDelay: 10000, //delay at end of start typing
		loop: true,
		loopCount: Infinity,
		typeSpeed: -100,
		fadeOut: true,
		fadeOutDelay: 3000, //delay after fade
		callback: function() {
			
		}
	}

	var typed = new Typed("#intro-title-animated", typedJSOptions);

	//$("#intro-title-animated").typed();
}