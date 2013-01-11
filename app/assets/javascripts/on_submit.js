$(function(){
	$("form").submit(function() { 
		var btn = $('input[type=submit]');
		if (btn.hasClass('btn')) {
		  btn.removeClass("btn-success btn-primary");
		  btn.addClass("btn-submitted");
		  btn.attr('disabled', true);
	    }
	});
});
