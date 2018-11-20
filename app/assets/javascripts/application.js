// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require turbolinks
//= require bootstrap-sprockets
//= require cocoon
//= require_tree .

$(document).ready(function() {
    $(".toggle-map").on('click', function(e) {
        $('.main-content').toggleClass('map_visible');
        $('.all_but_map').toggleClass('map_visible');

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
});
