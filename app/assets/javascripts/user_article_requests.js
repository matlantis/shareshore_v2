$(document).ready(function() {
  // ajax response for user article requests
  $('.new_user_article_request').on('ajax:success', function () {
    // find a parent element
    parent_div = $(this).parentsUntil('.request-panel').parent();
    // hide the form and show the send message
    parent_div.find('.waiting').hide(200)
    parent_div.find('.request-was-send').show(200)
    parent_div.find('.error-msg').text("").hide(200)
  });

  // ajax response for user article requests
  $('.new_user_article_request').on('ajax:beforeSend', function () {
    // find a parent element
    parent_div = $(this).parentsUntil('.request-panel').parent();
    // hide the form and show the send message
    parent_div.find('.send-request').hide(200)
    parent_div.find('.waiting').show(200)
    parent_div.find('.error-msg').text("").hide(200)
  });

  // ajax response for user article requests
  $('.new_user_article_request').on('ajax:error', function (e, xhr, status, error) {
    // find a parent element
    parent_div = $(this).parentsUntil('.request-panel').parent();
    // hide the form and show the send message
    parent_div.find('.waiting').hide(200)
    parent_div.find('.send-request').show(200)
    parent_div.find('.error-msg').text(xhr.responseText).show(200)
  });
})
