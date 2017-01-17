$(document).ready(function(){
  // hide all item edit forms on load
  $(".article_edit").hide();
  $("#article_new").hide();

  // hide items that have class to_hide
  $('.to_hide').hide();

  // new_from_stockitems hide all article counters where number is 0
  $(".article_count[data=0]").hide();
  
})
