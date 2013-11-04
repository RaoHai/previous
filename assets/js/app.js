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
 		$('.feature-gallery').animate({'left':featured_index * -263 },500);
 	});

 	$('.arrow-right').click(function() {
 		if (featured_index === length -1) {
 			featured_index = 0;
 		} else {
 			featured_index += 1;
 		}
 		$('.feature-gallery').animate({'left':featured_index * -263 },500);
 	});
 	var nav_top = $('.navigation').position().top;
 	$(window).scroll(function() {
 		if ($(window).scrollTop() > nav_top){
 			$('.mini-logo').css({'width':'50px'});
 			$('.navigation').addClass('fixed-top');
 		} else {
 			$('.mini-logo').css({'width':'0'});
 			$('.navigation').removeClass('fixed-top');
 		}
 	});


 });