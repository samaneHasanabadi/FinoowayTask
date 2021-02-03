<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 1/1/21
  Time: 7:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <!-- Bootstrap CSS -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <!--link rel="stylesheet" href="CssConfig.css"-->
    <title>title</title>
    <style type="text/css">
        .photo {
            background-image: url('/resources/image/c.png');
            background-repeat: no-repeat;
            background-position: center;
            width: 100%;
            height: 100%;
            object-fit: contain;
        }
    </style>
</head>
<body>
<div style="height: 20%; width: 100%; background-color: #6adbbb;display: table">
<h2 style="display:table-cell;vertical-align:middle;text-align:center;color: #2a2929">Welcome to Home Services Site</h2>
</div>
<div style="height: 80%; display: flex; flex-direction: row" class="photo">
    <div style="width: 26%; display: flex; flex-direction: column">
        <div style="height: 30%"></div>
        <button type="button" class="btn btn-primary btn-lg btn-block" style="background-color: #6adbbb; border-color: #6adbbb;"><a style="color: #1f1f1f" href="/signup">
            Sign Up
        </a></button>
        <div style="height: 20%"></div>
        <button type="button" class="btn btn-secondary btn-lg btn-block" style="background-color: #d1d2d2"><a style="color: #1f1f1f" href="/login">
            Login
        </a></button>
    </div>
    <div style="width: 48%"></div>
    <div style="width: 26%">
        <div style="height: 30%"></div>
        <button type="button" class="btn btn-primary btn-lg btn-block" style="background-color: #6adbbb; border-color: #6adbbb; color: #1f1f1f">Services</button>
        <div style="height: 20%"></div>
        <button type="button" class="btn btn-secondary btn-lg btn-block" style="background-color: #d1d2d2">Contact Us</button>
    </div>
</div>
</body>
</html>
