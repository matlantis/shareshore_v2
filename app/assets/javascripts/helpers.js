$(document).ready(function() {

    // class to toggle the visibility of some target
    $("body").on("click", ".mp-toggle-visibility", function(e) {
        e.preventDefault();
        target = $(this).attr("data-toggle-target");
        $(target).toggle();
        // disable hidden elements (like checkboxes)
        $(target).each(function() {
            $(this).attr("disabled", ! $(this).attr("disabled"));
        });
    });

    // disable all hidden elements
    $(".to-hide").attr("disabled", "disabled");
});
