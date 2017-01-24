$(document).ready(function() {
  // ajax response for user messages
  $('.message_form').on('ajax:success', function () {
    // find a parent element
    parent_div = $(this).parentsUntil('.message-panel').parent();
    // hide the form and show the send message
    parent_div.find('.waiting').hide(200)
    parent_div.find('.message-was-send').show(200)
    parent_div.find('.error-msg').text("").hide(200)
  });

  // ajax response for user messages
  $('.message_form').on('ajax:beforeSend', function () {
    // find a parent element
    parent_div = $(this).parentsUntil('.message-panel').parent();
    // hide the form and show the send message
    parent_div.find('.send-message').hide(200)
    parent_div.find('.waiting').show(200)
    parent_div.find('.error-msg').text("").hide(200)
  });

  // ajax response for user messages
  $('.message_form').on('ajax:error', function (e, xhr, status, error) {
    // find a parent element
    parent_div = $(this).parentsUntil('.message-panel').parent();
    // hide the form and show the send message
    parent_div.find('.waiting').hide(200)
    parent_div.find('.send-message').show(200)
    parent_div.find('.error-msg').text(xhr.responseText).show(200)
  });
})
