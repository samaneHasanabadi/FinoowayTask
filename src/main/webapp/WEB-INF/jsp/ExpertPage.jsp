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
<body>

<h3>Search And Add Sub Service</h3>
<div style="width: 40%;margin: 3%">
    <form id="SearchService">
        <div class="mb-3">
            <label for="serviceName" class="form-label">Service Name</label>
            <input name="name" class="form-control" id="serviceName">
        </div><br>
        <div class="mb-3">
            <label for="subServiceName" class="form-label">Sub Service Name</label>
            <input name="type" class="form-control" id="subServiceName">
        </div><br>
    </form>
    <div>
        <button class="btn btn-success" id="searchSubmit">Search</button>
    </div>
</div>
<div style="display: none" id="divTable">
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

<button type="button" class="btn btn-primary" id="showServiceBtn" onclick="showServices()">Show Services</button>
<h3>List Of Services</h3>
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
</body>
<script>
    $("#searchSubmit").on('click', function (){
        $("#divTable").show();
        $("#searchTable tr:gt(0)").remove();
        var searchData = {};
        searchData["serviceName"] = $("#serviceName").val();
        searchData["subServiceName"] = $("#subServiceName").val();
        var array = [];
        var len = 0;
        $.ajax({
            type : "POST",
            contentType : "application/json",
            url : "findByServiceNameAndSubServiceName",
            data : JSON.stringify(searchData),
            dataType : 'json',
            success: function (data2) {
                $.each(data2, function (i, f) {
                    var length = 0;
                    if (!array.includes(f.service.name)) {
                        array[len] = f.service.name;
                        len++;
                        var row = "";
                        var flag = true;
                        $.each(data2, function (i2, f2) {
                            if (f2.service.name === f.service.name) {
                                length++;
                                if (flag) {
                                    flag = false;
                                    row = row + "<td>" + f2.name + "</td><td><div class=\"form-check\">" +
                                        "<input class=\"form-check-input\" type=\"checkbox\" value=\"\" id='checkBox "+f2.service.id+" "+f2.id+"' onclick='addSubService(id)'></div></td></tr>";
                                } else {
                                    row = row + "<tr><td>" + f2.name + "</td><td><div class=\"form-check\">" +
                                        "<input class=\"form-check-input\" type=\"checkbox\" value=\"\" id='checkBox "+f2.service.id+" "+f2.id+"' onclick='addSubService(id)'></div></td></tr>";
                                }
                            }
                        });
                        row = "<tr><th scope=\"row\" rowspan='" + length + "'>" + len + "</th><td rowspan='" + length + "'>" + f.service.name + "</td>" + row;
                        $("#searchTable").append(row);
                    }
                });
            }
        });
    });

    var expertId = 1;
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
                        var length = 0;
                        if (!array.includes(f.service.name)) {
                            array[len] = f.service.name;
                            len++;
                            var row = "";
                            var flag = true;
                            $.each(data2, function (i2, f2) {
                                if (f2.service.name === f.service.name) {
                                    length++;
                                    if (flag) {
                                        flag = false;
                                        row = row + "<td>" + f2.name + "</td><td><div class=\"form-check\">" +
                                            "<input class=\"form-check-input\" type=\"checkbox\" value=\"\" id='checkBox " + f2.service.id + " " + f2.id + "' onclick='removeSubService(id)' checked></div></td></tr>";
                                    } else {
                                        row = row + "<tr><td>" + f2.name + "</td><td><div class=\"form-check\">" +
                                            "<input class=\"form-check-input\" type=\"checkbox\" value=\"\" id='checkBox " + f2.service.id + " " + f2.id + "' onclick='removeSubService(id)' checked></div></td></tr>";
                                    }
                                }
                            });
                            row = "<tr><th scope=\"row\" rowspan='" + length + "'>" + len + "</th><td rowspan='" + length + "'>" + f.service.name + "</td>" + row;
                            $("#serviceTable").append(row);
                        }
                    });
                }
            });
        });
    }
    function removeSubService(id){
        var parts = id.toString().split(" ");
        var subServiceId = parts[2];
        $.ajax({
            type: "GET",
            url: "/removeExpertOfSubService/" +expertId +"/"+ subServiceId,
            success: function () {
                $(function () {
                    var row = document.getElementById(id).closest("tr");
                    row.remove();
                });
            }
        });
    }

    function addSubService(id){
        var parts = id.toString().split(" ");
        var subServiceId = parts[2];
        $.ajax({
            type: "GET",
            url: "/addExpertToSubService/" +expertId +"/"+ subServiceId,
            success: function () {
                $(function () {
                    var row = document.getElementById(id).closest("tr");
                    row.remove();
                    showServices();
                });
            }
        });
    }

</script>
</html>
