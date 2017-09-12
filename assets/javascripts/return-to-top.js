$( document ).ready(function() {
	 $('#return-to-top').fadeIn(200);    // Fade in the arrow
});
$('#return-to-top').click(function() {      // When arrow is clicked
    $('body,html').animate({
        scrollTop : 0                       // Scroll to top of body
    }, 500);
});