$(document).ready(function(){
});

var onArticlesCreateSuccessIndex = function(article_id, newText, formText) {
    // remove the empty-list div, if existend
    $(".empty-list").hide(200);

    // replace the form content (so no need to reset the form, right?)
    $("#new_article").replaceWith(formText);

    // place the new content
    $(".article_placeholder").before(newText);

    // hide the new div
    $("#article-new").hide(200);

    // hide the generated edit div
    var div_id = "#article-" + article_id + "-div .article-edit";
    $(div_id).hide(200);

};

var onArticlesCreateSuccessStockitems = function(stockitem_id, formText, nstockitems, narticles){
    // hide the edit div
    var edit_div_id = "#article-" + stockitem_id + "-div .article-edit";
    $(edit_div_id).hide(200);

    // reset the form
    if ( stockitem_id == "null" ) {
        $("#article-new div form").trigger("reset");

        // unhide the rate field of the new form (just in case)
        var thedivid = "#article-null-div .article_rate";
        $(thedivid).show(200);

        // replace the form content (so no need to reset the form, right?)
        $("#article-null-div" + "#new-article").replaceWith(formText);

    }
    else {
        // replace the form content (so no need to reset the form, right?)
        $("#article-" + stockitem_id + "-div #new-article").replaceWith(formText);

        // if it was the from the template free form
        // show the counter
        var count_div_id = "#article-" + stockitem_id + "-div .article-count";
        $(count_div_id).show(200);

        // edit counter value
        var count_span_id = count_div_id + " span";
        $(count_span_id).text(nstockitems);
    }

    // edit all article counter value
    $('#all-article-count span').text(narticles);
};

var onArticlesCreateErrorIndex = function(formText){
    // replace the form content (so no need to reset the form, right?)
    $("#new-article").replaceWith(formText);

};

var onArticlesCreateErrorStockitems = function(stockitem_id, formText){
    // replace the form content (so no need to reset the form, right?)
    if ( stockitem_id == "null" ) {
        $("#article-null-div #new-article").replaceWith(formText);
    } else {
        $("#article-" + stockitem_id + "-div #new-article").replaceWith(formText);
    }

};

var onArticlesDestroy = function(article_div_id, list_is_empty) {
    // remove the desired article div
    $('#' + article_div_id).remove();

    // show the empty-list div, if list is empty
    if ( list_is_empty == "true") {
        $(".empty-list").show(200);
    }
};

var onArticlesUpdateError = function(formtext, article_div_id) {
    $('#' + article_div_id + ' form').replaceWith(formtext);
};

var onArticlesUpdateSuccess = function(newtext, article_div_id) {
    $('#' + article_div_id + ' .article-edit').hide(200);
    $('#' + article_div_id).replaceWith(newtext);
};
