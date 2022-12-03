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
<form id="Customer">
    <label for="customerName">نام</label>
    <input name="name" id="customerName"><br><br>
    <input type="submit" id="customerSubmit" value="ثبت">
</form>

</body>
<script>
    var flag = true;
    $('#Service').submit(function(event) {
        flag = true;
        var formData = {};
        formData["name"] = $("#customerName").val();
        $.ajax({
            type: "POST",
            contentType : "application/json",
            url: "/api/customer/create",
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
        if(response.id !== 0) {
            $("#message").html("<span><h4><strong>Welcome!</strong> Your information is registered successfully!</h4></span>");
        }else {
            $("#message").html("<span><h4>"+ response.message + "</h4></span>");
        }
        $("#message").css('display', 'flex');
        hideMessage();
    }
</script>
</html>
