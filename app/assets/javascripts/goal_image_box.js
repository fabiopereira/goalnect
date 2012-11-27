

$(function(){
	
	$(".random_img_tag").each(function(){
		img_element = $(this);
		changeBoxGoalImage(img_element, 0);
	 });
	
	
	
	function changeBoxGoalImage(img_element, current_src) {
		// srcs = img_element.data("srcs");
		// 		img_srcs = srcs.split(",");
		// 		img_element.attr('src',img_srcs[current_src]);
		// 		
		// 		current_src = current_src + 1;
		// 		if (current_src >= img_srcs.length){
		// 			current_src = 0;
		// 		}
  	}

});