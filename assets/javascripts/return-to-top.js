// The button is injected here rather than authored into _includes/head.html.
// Injecting on ready also keeps it on layouts that come from the remote theme (home, collection, cv).
$( document ).ready(function() {
	var $button = $('<button>', {
		type: 'button',
		id: 'return-to-top',
		title: 'Scroll to top',
		'aria-label': 'Scroll to top',
		text: '▲'
	}).appendTo('body');

	$button.on('click', function() {        // When arrow is clicked
		$('body,html').animate({
			scrollTop : 0                   // Scroll to top of body
		}, 500);
	});

	$button.fadeIn(200);                    // Fade in the arrow
});
