var onUserUpdateSuccess = function(newtext, lat, lng) {
    $('#user_form').replaceWith(newtext);
    markers[0].setLatLng({lat: lat, lng: lng});
}

$(document).ready(function(){
})
