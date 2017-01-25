$(document).on('turbolinks:load', function(){
  // hide all item edit forms on load
  $(".location_edit").hide();
  $("#location_new").hide();
});

var onLocationsCreateError = function (formtext) {
  $("#new_location").replaceWith(formtext)
}

var onLocationsCreateSuccess = function(newtext, formtext, location_div_id) {
  // remove the empty-list div, if existend
  $(".empty-list").hide(200)

  console.log("create success")
  // generate the new content
  $(".location_placeholder").before(newtext);

  // replace the form content (so no need to reset the form, right?)
  $("#new_location").replaceWith(formtext)

  // hide the new div
  $("#location_new").hide(200);

  // hide the generated edit div
  $("#" + location_div_id + " .location_edit").hide(200);
  
}

var onLocationsUpdateSuccess = function(location_div_id, newtext) {
  console.log('update success');
  $('#' + location_div_id).replaceWith(newtext);

  $('#' + location_div_id + ' .location_edit').hide(200)
}

var onLocationsUpdateError = function(location_div_id, formtext) {
  $('#' + location_div_id + ' form').replaceWith(formtext)
}

var onLocationsDestroy = function(location_div_id, list_is_empty) {
  // remove the desired location div
  $('#' + location_div_id).remove();

  // show the empty-list div, if list is empty
  if (list_is_empty == "true") {
    $(".empty-list").show(200);
  }
}
