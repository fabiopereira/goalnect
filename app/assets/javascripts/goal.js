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
			fill_goal_with_template_values(data);
		} else { 
			fill_goal_with_default_values();
		}
	  }
	});
}

fill_goal_with_template_values = function (data) {
		$('#goal_description').data("wysihtml5").editor.setValue(data.description);
		$('#image_goal_template').attr("src", data.image.thumb.url);
		if (data.due_on){
			process_goal_due_date(data.due_on);
		}
}

process_goal_due_date = function (due_on) {
	splited_date = due_on.split('-');
	$('#goal_due_on_3i').attr("value", parseInt(splited_date[2])).prop('disabled', true);
	$('#goal_due_on_2i').attr("value", parseInt(splited_date[1])).prop('disabled', true);
	$('#goal_due_on_1i').attr("value", parseInt(splited_date[0])).prop('disabled', true);
}

fill_goal_with_default_values = function () {
	default_src = $('#image_goal_template').data("default-src");
	$('#image_goal_template').attr("src", default_src);
	$('#goal_due_on_3i').prop('disabled', false);
	$('#goal_due_on_2i').prop('disabled', false);
	$('#goal_due_on_1i').prop('disabled', false);
}
