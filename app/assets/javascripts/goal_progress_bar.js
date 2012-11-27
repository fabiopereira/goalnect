$(function(){
	
   function countUpProgressBar(section) {
	var percentageRaisedProgressElement = section.find('.percentage-raised-progress');
	var percentageRaisedProgress = percentageRaisedProgressElement.data("percentage-raised");
	countUpFromZeroTo(
		percentageRaisedProgress, 
		function(perc) {
			percentageRaisedProgressElement.attr("style", "width: " + perc + "%");
		}
	);
   }

   function countUpPercentage(section) {
	var percentageRaisedElement = section.find('.percentage-raised');
	var percentageRaised = percentageRaisedElement.data("percentage-raised");
	countUpFromZeroTo(
		percentageRaised, 
		function(perc) {
			percentageRaisedElement.text(perc);
		}
	);
   }

   $('.goal-target-amount-progress').each(function(){
	var section = $(this);
	countUpProgressBar(section);
	countUpPercentage(section);
   });

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

