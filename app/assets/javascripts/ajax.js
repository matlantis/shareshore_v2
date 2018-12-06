$(document).ready(function() {
  // global ajax responses
  $('body').on("ajax:success", function(e, data, status, xhr) {
  });

  $('body').on("ajax:error", function(e, xhr, status, error) {
    $("#modal-error").modal("show");
  });
});
