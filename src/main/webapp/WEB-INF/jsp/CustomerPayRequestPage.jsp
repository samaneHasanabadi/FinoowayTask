<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 2/1/21
  Time: 10:57 PM
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
<body onload="getUserData(); getRequestTableContent()">
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
        <a href="/Customer/RequestPage">Registered Requests</a>
        <a href="/Customer/ChooseExpertPage">Choose Expert For Requests</a>
        <a href="/Customer/PayRequestPage" class="active">Pay Cost of Finished Requests</a>
        <a href="/Customer/CommentPage">Comment Finished Requests</a>
    </div>
    <div style="width: 80%">
        <table class="table table-striped" id="requestTable">
            <thead class="thead-light" style="background-color: #dddede">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Title</th>
                <th scope="col">Sub Service</th>
                <th scope="col">Date</th>
                <th scope="col">Price</th>
                <th scope="col">Description</th>
                <th scope="col">Expert</th>
                <th scope="col">Payment</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>


</body>
</html>
<script>
    var customerId = 0;
    var requestId = 0;
    var expertId = 0;

    function getUserData() {
        $.ajax({
            type: "GET",
            url: "/getUserId",
            async: false,
            success: function (data2) {
                customerId = data2;
            }
        });
    }

    function getRequestTableContent() {
        getUserData();
        $.ajax({
            type: "GET",
            url: "/getFinishedRequestsOfCustomer/"+ customerId,
            success: function (data) {
                $(function () {
                    var row = "";
                    $.each(data, function (i, f) {
                        row = row + addRowToRequestTable(i, f);
                    });
                    $("#requestTable").append(row);
                });
            }
        });
    }

    function addRowToRequestTable(i, f) {
        var dateFormat = JSON.stringify(f.date);
        var res = dateFormat.split("-");
        var day = (res[2].split("\""))[0].split("T")[0];
        var month = res[1];
        var year = (res[0].split("\""))[1];
        var newDate = month + "/" + day + "/" + year;
        var row = "";
        row = row + "<tr id='tr " + f.id + "'><th scope=\"row\">" + (i + 1) + "</th><td class='title'>" + f.title + "</td>";
        row = row + "<td class='subService'>" + f.subService.name + "</td><td class='date'>" + newDate + "</td><td class='price'>" + f.price + "</td><td class='description'>" + f.description + "</td><td class='address'>" + f.expert.name + " "+ f.expert.family + "</td><td>" +
            "<div class='btn-toolbar'>" +
            "<a href='/Customer/OnlinePaymentPage/id="+f.id+"'><button type=\"button\" class=\"btn btn-warning\" id='onlineBtn " + f.id + "' style='background-color: #48ddf1;border-color: #48ddf1;color: #1f1f1f'>Online Payment</button></a>" +
            "<button type=\"button\" class=\"btn btn-danger\" id='creditBtn " + f.id + "' style='background-color: #48ddf1;border-color: #48ddf1;color: #1f1f1f'>Pay By Credit</button></div></td></tr>";
        return row;
    }

</script>

<style>
    .vertical-menu {
        width: 20%;
        background: url("/resources/image/878.png");
        background-repeat: no-repeat;
        background-position: bottom;
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