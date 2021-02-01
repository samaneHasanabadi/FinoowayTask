<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 1/10/21
  Time: 2:48 PM
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
<body onload="getUserData()">
<nav class="navbar navbar-inverse" style="background-color: #dddede; border-color: #dddede ">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#" style="color: #1f1f1f">Expert Page</a>
        </div>
        <ul class="nav navbar-nav">
            <li class="active"><a href="/Expert/ProfilePage" style="color: #1f1f1f; background-color: #f1d548">Sub Service
                Page</a>
            </li>
            <li><a href="/Expert/RequestPage" style="color: #1f1f1f;">Request Page</a></li>
            <li><a href="#" style="color: #1f1f1f">Search Page</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="/logout" style="color: #1f1f1f"><span class="glyphicon glyphicon-log-in"></span> Log out</a></li>
        </ul>
    </div>
</nav>
<div id="message" class="well well-large"
     style="display: none;justify-content: center;align-items: center;background-color: #6adbbb;width: 85%;height:5%;margin-top: 1%;margin-left: 5%">
</div>
<div style="margin: 2%">
    <div class="well well-large" style="width: 40%;margin: 3%">
        <div style="justify-content: center"><h4><strong>Search And Add Sub Service</strong></h4></div>
        <div>
            <form id="SearchService">
                <div class="mb-3">
                    <label for="serviceName" class="form-label">Service Name</label>
                    <input name="name" class="form-control" id="serviceName">
                </div>
                <br>
                <div class="mb-3">
                    <label for="subServiceName" class="form-label">Sub Service Name</label>
                    <input name="type" class="form-control" id="subServiceName">
                </div>
                <br>
            </form>
            <div>
                <button class="btn btn-success" id="searchSubmit"
                        style="background-color: #f1d548; border-color: #f1d548; color: #1f1f1f">Search
                </button>
            </div>
        </div>
    </div>
    <div style="display: none" id="divTable" class="well well-large">
        <h3>Result Of Search</h3>
        <table class="table table-striped" id="searchTable">
            <thead class="thead-light">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Service</th>
                <th scope="col">Sub Service</th>
                <th scope="col">Add Sub Service</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div class="well well-large">
        <button type="button" class="btn btn-primary" id="showServiceBtn" onclick="showServices()"
                style="background-color: #f1d548; border-color: #f1d548; color: #1f1f1f">Show Services
        </button>
        <div style="justify-content: center"><h4><strong>List Of Services</strong></h4></div>
        <table class="table table-striped" id="serviceTable">
            <thead class="thead-light">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Service</th>
                <th scope="col">Sub Service</th>
                <th scope="col">Remove Sub Service</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>
</body>
<script>
    var expertId = 0;
    function getUserData() {
        $.ajax({
            type: "GET",
            url: "/getUserId",
            success: function (data2) {
                expertId = data2;
            }
        });
    }

    $("#searchSubmit").on('click', function () {
        $("#divTable").show();
        $("#searchTable tr:gt(0)").remove();
        var searchData = {};
        searchData["serviceName"] = $("#serviceName").val();
        searchData["subServiceName"] = $("#subServiceName").val();
        var array = [];
        var len = 0;
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "/findByServiceNameAndSubServiceName",
            data: JSON.stringify(searchData),
            dataType: 'json',
            success: function (data2) {
                $.each(data2, function (i, f) {
                    if (!array.includes(f.service.name)) {
                        array[len] = f.service.name;
                        len++;
                        var row = "";
                        $.each(data2, function (i2, f2) {
                            row = row + "<tr><th scope=\"row\">" + (i2 + 1) + "</th><td>" + f.service.name + "</td>";
                            row = row + "<td>" + f2.name + "</td><td><div class=\"form-check\">" +
                                "<input class=\"form-check-input\" type=\"checkbox\" value=\"\" id='checkBox " + f2.service.id + " " + f2.id + "' onclick='addSubService(id)'></div></td></tr>";
                        });
                        $("#searchTable").append(row);
                    }
                });
            }
        });
    });

    function showServices() {
        $("#serviceTable tr:gt(0)").remove();
        var array = [];
        var len = 0;
        $(function () {
            $.ajax({
                type: "GET",
                url: "/getSubServicesOfExpert/" + expertId,
                success: function (data2) {
                    $.each(data2, function (i, f) {
                        if (!array.includes(f.service.name)) {
                            array[len] = f.service.name;
                            len++;
                            var row = "";
                            $.each(data2, function (i2, f2) {
                                row = row + "<tr><th scope=\"row\">" + (i2 + 1) + "</th><td>" + f.service.name + "</td>";
                                row = row + "<td>" + f2.name + "</td><td><div class=\"form-check\">" +
                                    "<input class=\"form-check-input\" type=\"checkbox\" value=\"\" id='checkBox " + f2.service.id + " " + f2.id + "' onclick='removeSubService(id)' checked></div></td></tr>";
                            });
                            $("#serviceTable").append(row);
                        }
                    });
                }
            });
        });
    }

    function removeSubService(id) {
        var parts = id.toString().split(" ");
        var subServiceId = parts[2];
        $.ajax({
            type: "GET",
            url: "/removeExpertOfSubService/" + expertId + "/" + subServiceId,
            success: function () {
                $(function () {
                    var row = document.getElementById(id).closest("tr");
                    row.remove();
                    resetNumbersServiceTable();
                });
            }
        });
    }

    function resetNumbers() {
        $("#searchTable > tbody > tr").each(function (i) {
            var tds = this.cells;
            tds[0].innerHTML = (i + 1);
        });
    }
    function resetNumbersServiceTable() {
        $("#serviceTable > tbody > tr").each(function (i) {
            var tds = this.cells;
            tds[0].innerHTML = (i + 1);
        });
    }

    function addSubService(id) {
        var parts = id.toString().split(" ");
        var subServiceId = parts[2];
        $.ajax({
            type: "GET",
            url: "/addExpertToSubService/" + expertId + "/" + subServiceId,
            success: function () {
                $(function () {
                    var row = document.getElementById(id).closest("tr");
                    row.remove();
                    showServices();
                    resetNumbers();
                });
            }
        });
    }

</script>
</html>
