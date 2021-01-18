<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 1/1/21
  Time: 7:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <meta charset="UTF-8">
</head>
<body>
<form id="form1" action="/loginProcess" method="POST">
    <label for="email">email</label>
    <input type="text" id="email" name="email"><br><br>
    <label for="password">password</label>
    <input type="text" id="password" name="password"><br><br>
    <button id="login">login</button>
</form>
<script>
    // $("#login").click(function(){
    //     var user = {};
    //     user["email"] = $("#email").val();
    //     user["password"] = $("#password").val();
    //
    //     $.ajax({
    //         type : "POST",
    //         contentType : "application/json",
    //         url : "loginProcess",
    //         data : JSON.stringify(user),
    //         dataType : 'json',
    //         success : function(data) {
    //             // Code to display the response.
    //         }
    //     });
    // });
</script>
</body>
</html>
