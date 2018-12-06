var onUserUpdate = function(newtext, lat, lng) {
    $('#user_form').replaceWith(newtext);
    drawmap_leaflet("mapid", marker_defs, marker_defs_center, bounds);
    markers[0].setLatLng({lat: lat, lng: lng});
    map.setView(markers[0].getLatLng(), defaultZoom);
};
