 $(document).foundation();

 $(function(){

 	var featured_index = 0;
 	var length =  $('.feature-gallery li').length;
 	
 	$('.arrow-left').click(function() {
 		if (featured_index === 0) {
 			featured_index = length -1;
 		} else {
 			featured_index -= 1;
 		}
 		$('.feature-gallery').animate({'left':featured_index * -360 });
 	});

 	$('.arrow-right').click(function() {
 		if (featured_index === length -1) {
 			featured_index = 0;
 		} else {
 			featured_index += 1;
 		}
 		$('.feature-gallery').animate({'left':featured_index * -360 });
 	});



 });