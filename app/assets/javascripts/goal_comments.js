$(function(){
	
  $('#add_comment_btn').click(function(e) {
	e.preventDefault();
    $.ajax({
	  url: $('#new_goal_comment').attr('action'),
	  data: { goal_comment: { message: $('#goal_comment_message').val() , goal_id: $('#goal_comment_goal_id').val()}},
	  success: function(data) {
		if (data) {
			msg_element = $('#goal_comment_message');
			img_url = msg_element.data('user-img');
			username = msg_element.data('username');
			message = data.message;
			date_time = data.created_at;
			$('#all_comments').prepend("<article class='journey clearfix'><figure class='journey_achiever'><img src='"+ img_url +"'></figure><div class='journey_desc'><p><strong>"+ username +": </strong>" + message + "</p><p class='small-font'>" + date_time +"</p></div></article>");
			msg_element.val("");
		} 
	  }
	});
  })


  $('#show_more_id').click(function(e) {
	e.preventDefault();
	$('.journey_hidden').removeClass('journey_hidden').addClass('journey_show')
	$('#show_more_id').removeClass('show_left').addClass('hidden_left')
	$('#show_less_id').removeClass('hidden_left').addClass('show_left')
	
  });

  $('#show_less_id').click(function(e) {
	e.preventDefault();
	$('.journey_show').removeClass('journey_show').addClass('journey_hidden')
	$('#show_more_id').removeClass('hidden_left').addClass('show_left')
	$('#show_less_id').removeClass('show_left').addClass('hidden_left')
  });

});


