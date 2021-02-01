<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 2/1/21
  Time: 12:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <!-- Bootstrap CSS -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <!--link rel="stylesheet" href="CssConfig.css"-->
    <title>title</title>
</head>
<body onload="getUserData(); getAllServices()">
<nav class="navbar navbar-inverse" style="background-color: #dddede; border-color: #dddede ">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#" style="color: #1f1f1f">Customer Page</a>
        </div>
        <ul class="nav navbar-nav">
            <li><a href="/Customer/ServicePage" style="color: #1f1f1f;">Service
                Page</a>
            </li>
            <li class="active"><a href="/Customer/RequestPage" style="color: #1f1f1f; background-color: #48ddf1">Request
                Page</a>
            </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="/logout" style="color: #1f1f1f"><span class="glyphicon glyphicon-log-in"></span> Log out</a>
            </li>
        </ul>
    </div>
</nav>
<div id="message" class="well well-large"
     style="display: none;justify-content: center;align-items: center;background-color: #f1d548;width: 85%;height:5%;margin-top: 1%;margin-left: 5%">
</div>
<div style="display: flex; flex-direction: row; height: 89%">
    <div class="vertical-menu">
        <a href="/Customer/RequestPage" class="active">Registered Requests</a>
        <a href="/Customer/ChooseExpertPage">Choose Expert For Requests</a>
        <a href="#">Pay Cost of Finished Requests</a>
    </div>
    <div style="width: 80%">
        <table class="table table-striped" id="requestTable">
            <thead class="thead-light" style="background-color: #dddede">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Title</th>
                <th scope="col">Sub Service</th>
                <th scope="col">Date</th>
                <th scope="col">Proposed Price</th>
                <th scope="col">Address</th>
                <th scope="col">Description</th>
                <th scope="col">Edit/Delete</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>


<style>
    .vertical-menu {
        width: 20%;
        background: url("/878.png");
        background-repeat: no-repeat;
        background-position: center;
    }

    .vertical-menu a {
        background-color: #eee;
        color: black;
        display: block;
        padding: 12px;
        text-decoration: none;
    }

    .vertical-menu a:hover {
        background-color: #dddede;
    }

    .vertical-menu a.active {
        background-color: #48ddf1;
    }
</style>