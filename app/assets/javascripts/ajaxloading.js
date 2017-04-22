$(document).ajaxStart(function(event, request, settings) {
  $('#ajaxloader').show();
});

$(document).ajaxComplete(function(event, request, settings) {
  $('#ajaxloader').hide();
});