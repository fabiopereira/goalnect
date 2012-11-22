$(function(){

  $('.goal_donation_select_amount').click(function(){
     var selectedAmount = $(this).data("amount");
     $("#goal_donation_amount").val(selectedAmount);
  });

  $("#goal_donation_amount").change(function(){
     $('.goal_donation_select_amount').removeClass("active");
  });
});

