$(function() {

    var owner = $('#owner');
    var cardNumber = $('#cardNumber');
    var cardNumberField = $('#card-number-field');
    var CVV = $("#cvv");
    var mastercard = $("#mastercard");
    var confirmButton = $('#confirm-purchase');
    var visa = $("#visa");
    var amex = $("#amex");

    cardNumber.payform('formatCardNumber');
    CVV.payform('formatCardCVC');

    cardNumber.keyup(function() {

        amex.removeClass('transparent');
        visa.removeClass('transparent');
        mastercard.removeClass('transparent');

        if ($.payform.validateCardNumber(cardNumber.val()) == false) {
            cardNumberField.addClass('has-error');
        } else {
            cardNumberField.removeClass('has-error');
            cardNumberField.addClass('has-success');
        }
    });
    var requestId = 0;
    confirmButton.click(function(e) {

        e.preventDefault();

        var isCardValid = $.payform.validateCardNumber(cardNumber.val());
        var isCvvValid = $.payform.validateCardCVC(CVV.val());

        if(owner.val().length < 4 || owner.val().length>8){
            alert("Wrong password");
        } else if (!isCardValid) {
            alert("Wrong card number");
        } else if (!isCvvValid) {
            alert("Wrong CVV2");
        } else {
            gr();
        }
    });
    function gerRequestId(){
        let params = window.location.href;
        requestId = params.toString().split("=")[1];
    }
    function gr (){
        gerRequestId();
        if (grecaptcha.getResponse() == ""){
            alert("You can't proceed!");
        } else {
            var input = {};
            input["input"] =  grecaptcha.getResponse();
            input["inputName"] = "g-recaptcha-response";
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/onlinePayment/"+ requestId,
                data: JSON.stringify(input),
                dataType: 'json',
                success: function (response) {
                    alert(response);
                },
                error: function (response){
                    alert(response.responseText);
                }
            });
        }
    }
});
