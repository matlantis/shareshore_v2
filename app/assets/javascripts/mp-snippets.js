$(document).ready(function() {
  // class to toggle the visibility of some target
  $("body").on("click", ".mp-toggle-visibility", function(e) {
    e.preventDefault();
    target = $(this).attr("data-toggle-target");
    console.log("target: " + target)
    $(target).toggle(200);
  });

  // hide items that have class to_hide
  $('.to_hide').hide();
})
