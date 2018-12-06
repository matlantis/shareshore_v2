$(document).ready(function() {
    $('body').on('input', '.filter_pattern',function(e) {
        var pattern = new RegExp(e.target.value, "i");
        var articles_count = 0;
        // hide/show all locations without visible articles
        $('.location-pane').each(function() {
            var loc_visible = false;
            // hide/show all articles matching the pattern
            $(this).children(".article-pane[article_title]").each( function() {
                art_visible = $(this).attr("article_title").search(pattern) >= 0;
                $(this).toggle(art_visible);
                loc_visible = loc_visible || art_visible;
                if (art_visible) articles_count++;
            });
            $(this).toggle(loc_visible);
        });
        // update the articles counter
        $(".articles-count").text(articles_count);
    });

    $('#search_use_location').on('click', function(e) {
        $('#search_location_id').closest('.form-group').toggle(e.target.checked);
        $('#search_address').closest('.form-group').toggle(!e.target.checked);
    });
});
