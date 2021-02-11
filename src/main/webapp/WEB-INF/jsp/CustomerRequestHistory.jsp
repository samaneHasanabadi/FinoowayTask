<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 2/4/21
  Time: 3:12 PM
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
            <li><a href="/Customer/RequestPage" style="color: #1f1f1f;">Request
                Page</a>
            </li>
            <li class="active"><a href="/Customer/RequestHistory" style="color: #1f1f1f; background-color: #48ddf1">Request
                History</a>
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
<div class="container">
    <label for="StatusSelector" class="form-label">Request Status</label>
    <select id="StatusSelector" class="form-select" aria-label="Default select example"
            onchange="checkSubServiceService()" required>
        <option value=""></option>
        <option value="WAITING_FOR_EXPERTS_OPTIONS">WAITING_FOR_EXPERTS_OPTIONS</option>
        <option value="WAITING_FOR_CHOOSING_EXPERT">WAITING_FOR_CHOOSING_EXPERT</option>
        <option value="WAITING_FOR_COMING_EXPERT">WAITING_FOR_COMING_EXPERT</option>
        <option value="IN_PROCESS">IN_PROCESS</option>
        <option value="FINISHED">FINISHED</option>
        <option value="PAID">PAID</option>
    </select>
    <button type="submit" class="btn btn-primary"
            style="background-color: #48ddf1; color: #1f1f1f; border-color: #48ddf1" id="submit">Search
    </button>
    <br><br>
    <table class="table table-striped" id="requestTable">
        <thead class="thead-light" style="background-color: #dddede">
        <tr>
            <th scope="col">#</th>
            <th scope="col">Title</th>
            <th scope="col">Sub Service</th>
            <th scope="col">Date</th>
            <th scope="col">Price</th>
            <th scope="col">Expert</th>
            <th scope="col">Status</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
</body>
</html>
<script>
    var customerId = 0;
    var requestId = 0;

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
        var status = $("#StatusSelector").val();
        if(status === "")
            status = "null";
        $.ajax({
            type: "GET",
            url: "/getCustomerRequests/" + customerId + "/" + status,
            success: function (data) {
                $("#requestTable tr:gt(0)").remove();
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
        if(f.expert != null) {
            row = row + "<td class='subService'>" + f.subService.name + "</td><td class='date'>" + newDate + "</td><td class='proposedPrice'>" + f.price + "</td><td class='expert'>" + f.expert.name + " " + f.expert.family + "</td><td class='status'>" + f.requestStatus + "</td><td></tr>";
        }else {
            row = row + "<td class='subService'>" + f.subService.name + "</td><td class='date'>" + newDate + "</td><td class='proposedPrice'>" + f.price + "</td><td class='expert'></td><td class='status'>" + f.requestStatus + "</td><td></tr>";
        }
        return row;
    }
</script>