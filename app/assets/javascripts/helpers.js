$(document).ready(function() {
    // class to toggle the visibility of some target
    $("body").on("click", ".mp-toggle-visibility", function(e) {
        e.preventDefault();
        target = $(this).attr("data-toggle-target");
        $(target).toggle(000);
    });

});