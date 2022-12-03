<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 1/6/21
  Time: 11:29 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Customer</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <meta charset="UTF-8">
</head>
<body>
<form id="CustomerWithdraw">
    <label for="customerId">شناسه مشتری</label>
    <input name="id" id="customerId"><br><br>
    <label for="amount">مبلغ</label>
    <input name="amount" id="amount"><br><br>
    <input type="submit" id="withdraw" value="برداشت">
</form>
<form id="CustomerDeposit">
    <label for="customerIdd">شناسه مشتری</label>
    <input name="id" id="customerIdd"><br><br>
    <label for="amountd">مبلغ</label>
    <input name="amount" id="amountd"><br><br>
    <input type="submit" id="deposit" value="واریز">
</form>
</body>
<script>
    var flag = true;
    $('#CustomerWithdraw').submit(function(event) {
        flag = true;
        var formData = {};
        formData["customerId"] = $("#customerId").val();
        formData["amount"] = $("#amount").val();

        $.ajax({
            type: "POST",
            contentType : "application/json",
            url: "/api/wallet/withdraw",
            data : JSON.stringify(formData),
            dataType : 'json',
            success: function (response) {
                console.log(response);
                showSuccessMessage(response);
            },
            error: function (error) {
                console.log(error);
            }
        });
        event.preventDefault();
    });

    $('#CustomerDeposit').submit(function(event) {
        flag = true;
        var formData = {};
        formData["customerId"] = $("#customerIdd").val();
        formData["amount"] = $("#amountd").val();

        $.ajax({
            type: "POST",
            contentType : "application/json",
            url: "/api/wallet/deposit",
            data : JSON.stringify(formData),
            dataType : 'json',
            success: function (response) {
                console.log(response);
                showSuccessMessage(response);
            },
            error: function (error) {
                console.log(error);
            }
        });
        event.preventDefault();
    });

    function showSuccessMessage(response){
        $("#message").html("<span><h4>"+ response.message + "</h4></span>");
        $("#message").css('display', 'flex');
        hideMessage();
    }
</script>
</html>
