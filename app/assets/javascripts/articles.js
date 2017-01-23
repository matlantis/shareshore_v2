$(document).ready(function(){
  // hide all item edit forms on load
  $(".article_edit").hide();
  $("#article_new").hide();

  // hide items that have class to_hide
  $('.to_hide').hide();

  // new_from_stockitems hide all article counters where number is 0
  $(".article_count[data=0]").hide();
  
})

var onArticlesCreateSuccessIndex = function(article_id, newText, formText) {
  // remove the empty-list div, if existend
  $(".empty-list").hide(200)

  console.log("within onArticlesCreateSuccess")
  // replace the form content (so no need to reset the form, right?)
  $("#new_article").replaceWith(formText)

  // place the new content
  $(".article_placeholder").before(newText);

  // hide the rate field of the article form (just in case)
  // $('.article_rate_gratis').hide()

  // hide the new div
  $("#article_new").hide(200);

  // hide the generated edit div
  var div_id = "#article_" + article_id + "_div .article_edit"
  console.log(div_id);
  $(div_id).hide(200);

};

var onArticlesCreateSuccessStockitems = function(stockitem_id, formText, nstockitems, narticles){
  console.log("within on create")
  // hide the edit div
  var edit_div_id = "#article_" + stockitem_id + "_div .article_edit"
  $(edit_div_id).hide(200);

  // reset the form 
  if ( stockitem_id == "null" ) {
    $("#article_new div form").trigger("reset");
    
    // unhide the rate field of the new form (just in case)
    var thedivid = "#article_null_div .article_rate";
    console.log(thedivid);
    $(thedivid).show(200);
    
    // replace the form content (so no need to reset the form, right?)
    $("#article_null_div" + "#new_article").replaceWith(formText)

  }
  else {
    // replace the form content (so no need to reset the form, right?)
    $("#article_" + stockitem_id + "_div #new_article").replaceWith(formText)

    // if it was the from the template free form
    // show the counter
    var count_div_id = "#article_" + stockitem_id + "_div .article_count";
    $(count_div_id).show(200);
    
    // edit counter value
    var count_span_id = count_div_id + " span"
    console.log(count_span_id)
    $(count_span_id).text(nstockitems);
  }
  
  // edit all article counter value
  $('#all_article_count span').text(narticles);
};

var onArticlesCreateErrorIndex = function(formText){
    console.log("within onArticlesCreateError")

    // replace the form content (so no need to reset the form, right?)
    $("#new_article").replaceWith(formText)
    
  };

var onArticlesCreateErrorStockitems = function(stockitem_id, formText){
  console.log("within onCreateError")

  // replace the form content (so no need to reset the form, right?)
  if ( stockitem_id == "null" ) {
    $("#article_null_div #new_article").replaceWith(formText)
  } else {
    $("#article_" + stockitem_id + "_div #new_article").replaceWith(formText)
  }
  
};

var onArticlesDestroy = function(article_div_id, list_is_empty) {
  // remove the desired article div
  $('#' + article_div_id).remove();

  // show the empty-list div, if list is empty
  if ( list_is_empty ) {
    $(".empty-list").show(200);
  }
}

var onArticlesUpdateError = function(formtext) {
  $('#' + article_div_id + ' form').replaceWith(formtext);
}

var onArticlesUpdateSuccess = function(newtext) {
  $('#' + article_div_id).replaceWith(newtext);

  $('#' + article_div_id + ' .article_edit').hide(200)
}
