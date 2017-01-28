$(document).ready(function() {
  $('body').on('input', '.filter_pattern',function(e) {
    console.log("got input");

    var pattern = new RegExp(e.target.value, "i")
    var articles_count = 0;
    // hide/show all locations without visible articles
    $('.location-pane').each(function() {
      var loc_visible = false;
      // hide/show all articles matching the pattern
      $(this).children(".article-pane[article_title]").each( function() {
        art_visible = $(this).attr("article_title").search(pattern) >= 0
        $(this).toggle(art_visible);
        loc_visible = loc_visible || art_visible;
        if (art_visible) articles_count++;
      });
      $(this).toggle(loc_visible);
    });
    // update the articles counter
    $(".articles_count").text(articles_count);
  });

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

    // don't scroll when at top or at bottom
    if (((window.innerHeight + window.pageYOffset) < document.body.offsetHeight) && window.pageYOffset != 0 ) {
      // scroll the view by half of map height when map is opening or closing
      if ( $('.all_but_map').hasClass('map_visible') )
        $('html, body').animate({
          scrollTop: '+=' + $(window).height() * 0.2
        }, 200);
      else
        $('html, body').animate({
          scrollTop: '-=' + $(window).height() * 0.2
        }, 200);
    }
  });

})
