$(function(){
	
  function setPercentageRaisedBar(perc) {
	$('#percentage-raised-progress').attr("style", "width: " + perc + "%")
  } 

  function setPercentageRaised(perc) {
	$('#percentage-raised').text(perc);
  } 

  if ($('#percentage-raised-progress')) {
	countUpFromZeroTo(
		$('#percentage-raised-progress').data("percentage-raised"), 
		setPercentageRaisedBar
	);
	countUpFromZeroTo( 
		$('#percentage-raised').data("percentage-raised"), 
		setPercentageRaised
	);
  }

  function countUpFromZeroTo(top, updateFunction) {
    var i = 0;
    function setAndSleep() {
      updateFunction(i);
      if (i < top) {
      	i++;
      	setTimeout(setAndSleep, 10);
      }
    }
    setTimeout(setAndSleep, 10);
  }

});

