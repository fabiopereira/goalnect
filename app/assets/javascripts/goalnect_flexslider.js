$(function(){
  $('.flexslider').flexslider();

  $('.cycle').cycle({ 
	    fx:     'scrollHorz', 
	    speed:  'fast', 
    	timeout: 3000, 
	    pager:  '#nav-cycle' 
	});
});
