$(function(){
	$('#fake_file_btn').click(function(e){
		e.preventDefault();
		$('#real_file_btn').click();
	});
});