$(function() {
	var $allMsg = $('#toppage-logo');
	var $wordList = $('#toppage-logo').html().split("");
	$('#toppage-logo').html("");
	$.each($wordList, function(idx, elem) {
			var newEL = $("<span/>").text(elem).css({ opacity: 0 });
			newEL.appendTo($allMsg);
			newEL.delay(idx * 70);
			newEL.animate({ opacity: 1 }, 1100);
	});
});
