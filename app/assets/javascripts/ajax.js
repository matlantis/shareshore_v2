$(document).ready(function() {
  // global ajax responses
  $('body').on("ajax:success", function(e, data, status, xhr) {
    console.log("Success");
  });
  
  $('body').on("ajax:error", function(e, xhr, status, error) {
    console.log("Error");
    $("#modal-error").modal("show");
  });
})
