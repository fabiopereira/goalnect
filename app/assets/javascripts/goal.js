$(function(){
	
  $('#goal_title_selected').autocomplete({
	 source: $('#goal_title_selected').data('autocomplete-source'),
	 change: function(event, ui)
	   {
	    $.ajax({
		  url: '/goal_template/goal_template_by_title.json',
		  data: { title: $('#goal_title_selected').val() },
		  success: function(data) {
			if (data) {
				$('#goal_description').data("wysihtml5").editor.setValue(data.description);
				$('#image_goal_template').html("<image src='"+ data.image.thumb.url +"'/>");
				$('goal_goal_template_id').setValue(data.id)	
			} else {
			    $('#image_goal_template').html("");	
				$('goal_goal_template_id').setValue("")	
			}
		  }
		});
	   }
  });

  $('#goal_template').change(function() {
    $.ajax({
	  url: '/goal_template/goal_template_by_title.json',
	  data: { title: $('#goal_template option:selected').text() },
	  success: function(data) {
		if (data) {
			$('#image_goal_template').html("<image src='"+ data.image.thumb.url +"'/>");
		} else {
		    $('#image_goal_template').html("");	
		}
	  }
	});
  })

});


