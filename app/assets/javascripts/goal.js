$(function(){
 
  on_change_goal_title();
	
  $('#goal_title_selected').autocomplete({
	 source: $('#goal_title_selected').data('autocomplete-source'),
	 change: function(event, ui)
	   {
	    on_change_goal_title();
	   }
  });

  $('#goal_template').change(function() {
    $.ajax({
	  url: '/goal_template/goal_template_by_title.json',
	  data: { title: $('#goal_template option:selected').text() },
	  success: function(data) {
		if (data) {
			$('#image_goal_template').attr("src", data.image.thumb.url);
		} else {
		    default_src = $('#image_goal_template').data("default-src");
			$('#image_goal_template').attr("src", default_src);
		}
	  }
	});
  })

});

on_change_goal_title = function(){
	$.ajax({
	  url: '/goal_template/goal_template_by_title.json',
	  data: { title: $('#goal_title_selected').val() },
	  success: function(data) {
		if (data) {
			$('#goal_description').data("wysihtml5").editor.setValue(data.description);
			$('#image_goal_template').attr("src", data.image.thumb.url);	
		} else { 
			default_src = $('#image_goal_template').data("default-src");
			$('#image_goal_template').attr("src", default_src);
		}
	  }
	});
}
