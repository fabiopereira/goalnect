$(function(){

	$(".random_img_tag").data("current_src", 0);	
	
	$('.random_img_tag').bind('mouseenter', function() {
    	var img_element = $(this);
    	this.iid = setInterval(function() {
				img_srcs = imgSrcs(img_element);
				changeToNextImage(img_element, img_srcs);
    		}, 1000);
	}).bind('mouseleave', function(){
		img_element = $(this);
		img_srcs = imgSrcs(img_element);
		changeImage(img_element, img_srcs, 0);
    	this.iid && clearInterval(this.iid);
	});
	
	function changeToNextImage(img_element, img_srcs){
		current_src = $(".random_img_tag").data("current_src");
		current_src = current_src + 1;
		if (current_src == img_srcs.length){
			current_src = 0;
		}
		changeImage(img_element, img_srcs, current_src);
	}
	
	function changeImage(img_element, img_srcs, current_src) {
		$(".random_img_tag").data("current_src", current_src);
		img_element.attr('src',img_srcs[current_src]);
	}
	
	function imgSrcs(img_element){
		srcs = img_element.data("srcs");
		img_srcs = srcs.split(",");
		return img_srcs;
	}

});




