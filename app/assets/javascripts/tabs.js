$(function(){
	$(".tabs").each(function(){
		var tabs_group = $(this);
		tabs_group.find("a.tab").click(function(e){
			e.preventDefault(); 
			
			tabs_group.find("a.tab").removeClass('active')
			tabs_group.find("div.content").removeClass('active')
			
			active_tab = $(this);
			active_tab_content = $(active_tab.attr('href'))
			
			active_tab.addClass('active');
			active_tab_content.addClass('active');

		});
	});

});
