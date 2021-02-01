<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 1/31/21
  Time: 2:21 PM
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
            <li class="active"><a href="/Customer/ServicePage" style="color: #1f1f1f;background-color: #48ddf1">Service
                Page</a>
            </li>
            <li><a href="/Customer/RequestPage" style="color: #1f1f1f">Request
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

</body>
</html>
<script>
    var customerId = 0;

    function getUserData() {
        $.ajax({
            type: "GET",
            url: "/getUserId",
            success: function (data2) {
                customerId = data2;
            }
        });
    }

    function getAllServices() {
        $.ajax({
            type: "GET",
            url: "/getAllServices",
            success: function (response) {
                createServiceDivs(response);
            }
        });
    }

    function createServiceDivs(response) {
        var divsNumber = response.length / 2;
        var content = "";
        for (var i = 0; i < divsNumber - 1; i++) {
            content = content + addDiv(response[2 * i], response[2 * i + 1]);
        }
        var remain = response.length % 2;
        if (!(remain === 0)) {
            content = content + addOneDive(response[2 * (divsNumber - 1) + 1]);
        } else {
            content = content + addDiv(response[2 * (divsNumber - 1)], response[2 * (divsNumber - 1) + 1])
        }
        $('body').append(content);
    }

    function addDiv(service1, service2) {
        return "<div style=\"display: flex; flex-direction: row; width: 90%; height: 30%; margin: 5%; background-color: #55d5d1\">\n" +
            "    <div style=\"display: flex; flex-direction: row;width: 45%; height: 90%; margin-top: 1%;margin-bottom: 1%; margin-right: 3%; margin-left: 3%; background-color: #4CAF50\">\n" +
            "        <div id='servicePicDiv " + service1.id + "' style=\"width: 50%;height: 100%; background-color: #f1d548\">\n" +
            "        </div>\n" +
            "        <a href='/Customer/SubServicePage/id=" + service1.id + "' id='serviceInfoDiv " + service1.id + "' style=\"width: 50%;height: 100%; background-color: #d1d2d2;\">\n" +
            "            <div style='text-align: center; padding: 70px 0;'><strong style='font-size: 20; color: #1f1f1f'>" + service1.name + "</strong></div>" +
            "        </a>\n" +
            "    </div>\n" +
            "    <div style=\"display: flex; flex-direction: row;width: 45%; height: 90%; margin-top: 1%;margin-bottom: 1%; margin-right: 3%; margin-left: 3%; background-color: #4CAF50\">\n" +
            "        <div id='servicePicDiv " + service2.id + "' style=\"width: 50%;height: 100%; background-color: #f1d548\">\n" +
            "        </div>\n" +
            "        <a href='/Customer/SubServicePage/id=" + service2.id + "' id='servicePicDiv " + service2.id + "' style=\"width: 50%;height: 100%; background-color: #d1d2d2\">\n" +
            "             <div style='text-align: center; padding: 70px 0;'><strong style='font-size: 20; color: #1f1f1f'>" + service2.name + "</strong></div>" +
            "        </a>\n" +
            "    </div>\n" +
            "</div>";
    }

    function addOneDive(service) {
        return "<div style=\"display: flex; flex-direction: row; width: 90%; height: 30%; margin: 5%; background-color: #55d5d1\">\n" +
            "    <div style=\"display: flex; flex-direction: row;width: 45%; height: 90%; margin-top: 1%;margin-bottom: 1%; margin-right: 3%; margin-left: 3%; background-color: #4CAF50\">\n" +
            "        <div id='servicePicDiv " + service.id + "' style=\"width: 50%;height: 100%; background-color: #f1d548\">\n" +
            "        </div>\n" +
            "        <a href='/Customer/SubServicePage/id=" + service.id + "' id='servicePicDiv " + service.id + "' style=\"width: 50%;height: 100%; background-color: #d1d2d2\">\n" +
            "             <div style='text-align: center; padding: 70px 0;'><strong style='font-size: 20; color: #1f1f1f'>" + service.name + "</strong></div>" +
            "        </a>\n" +
            "    </div>\n" +
            "</div>";
    }


</script>