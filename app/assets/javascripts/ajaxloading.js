$(document).ajaxStart(function(event, request, settings) {
  $('#ajaxloader').show();
  
  if ($('#home-page').css('display') !== 'none') {
  	  var squery = $('input#query').val();	
	  $('#home-page').hide('fast', function() {
	  	$('#results-page').show();
	  	$('input#query').val(squery);
	  });
  }

});

$(document).ajaxComplete(function(event, request, settings) {
  $('#ajaxloader').hide();
});

$(document).on('click','.tabs-bar a', function(e) {
	$(document).ajaxComplete( function() {
		$('.tabs-bar a').removeClass('disabled');
		$('#' + e.currentTarget.id).addClass('disabled');
	});	
});