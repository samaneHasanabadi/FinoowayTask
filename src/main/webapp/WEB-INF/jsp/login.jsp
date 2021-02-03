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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <title>title</title>
    <style type="text/css">
        body {
            background-image: url('/resources/image/f.png');
        }
    </style>
</head>
<body>
<div class="container" style="width: 30%;margin: 5%; background-color: #dddede">
    <form id="form1" action="/loginProcess" method="POST">
        <br>
        <label for="Email" class="form-label">Email</label>
        <input type="text" class="form-control" name="email" id="email" placeholder="Email" required="true">
        <br>
        <label for="password" class="form-label">Password</label>
        <input type="password" class="form-control" name="password" id="password" placeholder="Password" required="true">
        <br>
        <button type="submit" id="login" class="primary btn submit-btn btn-primary"
                style="background-color: #6adbbb;border-color: #6adbbb; color: #1f1f1f">Login
        </button>
    </form>
</div>
<script>

</script>
</body>
</html>
