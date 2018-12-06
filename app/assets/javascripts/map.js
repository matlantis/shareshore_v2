$(document).ready(function() {
    // article hover event handler
    var onArticleMouseEnter = function(e) {
        // search the marker with the correct house id
        for (i = 0; i< window.markers.length; i++) {
            var house_id = $(this).parentsUntil("[data-house-id]").parent().attr("data-house-id");
            if ( window.markers[i].house_id == house_id ) {
                window.markers[i].openPopup();
                break;
            }
        }
    };

    // article hover event handler
    var onArticleMouseLeave = function(e) {
        // search the marker with the correct house id
        for (i = 0; i< window.markers.length; i++) {
            var house_id = $(this).parentsUntil("[data-house-id]").parent().attr("data-house-id");
            if ( window.markers[i].house_id == house_id ) {
                window.markers[i].closePopup();
                break;
            }
        }
    };

    // hover on location marker pops up the map popup
    $("#results").on('mouseenter', ".location_marker", onArticleMouseEnter);
    $("#results").on('mouseleave', ".location_marker", onArticleMouseLeave);

    $(".toggle-map").on('click', function(e) {
        $('.all-but-map').toggleClass('global-map-visible');

        // for the global map
        if ( $(".global-map-container").get(0).contains(e.target) )
        {
            // don't scroll when at top or at bottom
            if (((window.innerHeight + window.pageYOffset) < document.body.offsetHeight) && window.pageYOffset != 0 ) {
                // scroll the view by half of map height when map is opening or closing
                if ( $('.all-but-map').hasClass('global-map-visible') )
                    $('html, body').animate({
                        scrollTop: '+=' + $(window).height() * 0.2
                    }, 200);
                else
                    $('html, body').animate({
                        scrollTop: '-=' + $(window).height() * 0.2
                    }, 200);
            }
        }
    });
});

var defaultZoom = 17;

add_markers_to_map = function(marker_defs, map, markers_layer) {
    window.markers = [];
    markers = window.markers;
    for (i=0; i<marker_defs.length; i++) {
        var icon;
        if ( marker_defs[i].color == 'red' ) { icon = icon_red; }
        else { icon = icon_blue; }
        var marker = L.marker(marker_defs[i].coords, { icon: icon }).addTo(markers_layer);
        marker.bindPopup(marker_defs[i].html);
        marker.house_id = marker_defs[i].id;
        markers.push(marker);

        marker.on('click', function(e) {
            if ( e.target.house_id == -1 ) return;
            // check visible tab
            var tab = ( $('#tab-articles').is(":visible") )? "#tab-articles" : "#tab-users";
            $('html, body').animate({
                scrollTop: $(tab + ' .location[data-house-id=' + e.target.house_id + ']').first().offset().top
            }, 200);
        });
    }
};

drawmap_leaflet = function(mapid, marker_defs, marker_defs_center, bounds, onMapClick, onMapDblClick, zoom) {
    // parameter defaults
    onMapClick = onMapClick || null;
    onMapDblClick = onMapDblClick || null;
    zoom = zoom || defaultZoom;

    window.map = L.map(mapid);
    var map = window.map;

    if ( bounds.length == 1 )
        map.setView(bounds[0], zoom);
    else
        map.fitBounds(bounds);

    // create the tile layer with correct attribution
    var osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
    var osmAttrib='Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors';
    var osm = new L.TileLayer(osmUrl, { attribution: osmAttrib} );
    osm.addTo(map);

    // add scale
    L.control.scale().addTo(map);

    // center marker
    center_marker_layer = new L.FeatureGroup();
    map.addLayer(center_marker_layer);
    add_markers_to_map(marker_defs_center, map, center_marker_layer);

    // markers (but not center)
    window.markers_layer = new L.FeatureGroup();
    map.addLayer(markers_layer);
    add_markers_to_map(marker_defs, map, window.markers_layer);

    return map;
};
