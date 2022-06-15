$(document).ready(function(){
  $(document).on("change", ".delivery-address", function(){
    var address = $(this).val();
    $.ajax({
      url: '/orders/new?format=json',
      method: 'GET',
      data: {
        address: address
      },
      success: function(r) {
        if(r['address']){
        $(".name-address").val(r['address']['name']);
        $(".phone-address").val(r['address']['phone']);
        $(".current-address").val(r['address']['address']);
        } else {
          $(".name-address").val('');
          $(".phone-address").val('');
          $(".current-address").val('');
        }
      }
    });
  });

  $(document).on("change", ".payment-method", function(){
    var payment = $(this).val();
    if(payment == "card")
      $('#form-payment').removeClass("visually-hidden");
    else
      $('#form-payment').addClass("visually-hidden");
  });

  $('#card-number').keyup(function() {
    cc = $(this).val().split(" ").join("");
    cc = cc.match(new RegExp('.{1,4}$|.{1,4}', 'g')).join(" ");
    $(this).val(cc);
  });

  $('#expiration-date').keyup(function() {
    cc = $(this).val().split("/").join("");
    cc = cc.match(new RegExp('.{1,2}$|.{1,2}', 'g')).join("/");
    $(this).val(cc);
  });
});
