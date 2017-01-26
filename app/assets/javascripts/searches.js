$(document).on('turbolinks:load', function() {
  $(".toggle-scroll").on('click', function(e) {
    e.preventDefault();
    console.log("toggle-scroll");
    $('#tab-articles').toggleClass('scrollable-results');
    $('#tab-locations').toggleClass('scrollable-results');
  })

  $('#search_use_location').on('click', function(e) {
    $('#search_location_id').closest('.form-group').toggle(e.target.checked);
    $('#search_address').closest('.form-group').toggle(!e.target.checked);
  });

  $(".toggle-map").on('click', function(e) {
    $('.main-content').toggleClass('map_visible')
    $('.all_but_map').toggleClass('map_visible')

    // scroll the view down by map height when map is opening
    if ( $('.all_but_map').hasClass('map_visible') )
      $('html, body').animate({
        scrollTop: '+=' + $(window).height() * 0.4
      }, 200);
  })
})
