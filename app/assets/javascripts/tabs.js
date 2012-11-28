$(function(){
	
	
 	$(".tabs").each(function(){
		var tabs_group = $(this);
		tabs_group.find("ul li a").click(function(){
			tabs_group.find("ul li a").removeClass('active')
			tabs_group.find("div.content").removeClass('active')
			
			active_tab = $(this);
			active_tab_content = $(active_tab.attr('href'))
			
			active_tab.addClass('active');
			active_tab_content.addClass('active');

		});
	});

});

// function setTabsGroupHeight(tabs_group){
// 	height = 0;
// 	tabs_group.find("div.content").each(function(){
// 		content_div = $(this);
// 		if (height < content_div.height()){
// 			height = content_div.height();
// 		}
// 	});
// 	tabs_group.attr("style","height:"+(height+100)+"px;");
// }