$(document).on('turbolinks:load', function() {
  $(".toggle-scroll").on('click', function(e) {
    e.preventDefault();
    console.log("toggle-scroll");
    $('#tab-articles').toggleClass('scrollable-results');
    $('#tab-locations').toggleClass('scrollable-results');
  })
                         
})
