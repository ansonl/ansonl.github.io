$( document ).ready(function() {
	BackgroundCheck.init({
		targets: '.toggle-inner'
	});
	BackgroundCheck.refresh();
});

$( window ).on( 'scroll', function() {
	BackgroundCheck.refresh();
});