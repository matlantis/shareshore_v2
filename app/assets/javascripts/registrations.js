$(document).ready(function(){
  // hide the password confirmation field
  $("#user_password_confirmation").closest(".form-group").hide();
  $("#user_current_password").closest(".form-group").hide();

  $('body').on('input', '#user_password',function(e) {
    console.log("got input");
    if ( e.target.value == "" ) {
      $("#user_password_confirmation").closest(".form-group").hide(200);
      $("#user_current_password").closest(".form-group").hide(200);
    }
    else {
      $("#user_password_confirmation").closest(".form-group").show(200);
      $("#user_current_password").closest(".form-group").show(200);
    }      
  });
})
