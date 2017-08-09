$( document ).ready(function() {
	BackgroundCheck.init({
		targets: '.toggle-inner'
	});
	BackgroundCheck.refresh();
});

$(window).scroll(function() {
	BackgroundCheck.refresh();
});