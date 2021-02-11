<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 2/5/21
  Time: 4:29 PM
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <title>title</title>
</head>
<body>
<nav class="navbar navbar-inverse" style="background-color: #dddede; border-color: #dddede ">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#" style="color: #1f1f1f">Manager Page</a>
        </div>
        <ul class="nav navbar-nav">
            <li><a href="ServicePage" style="color: #1f1f1f;">Service Page</a>
            </li>
            <li><a href="ExpertPage" style="color: #1f1f1f;">Expert Page</a></li>
            <li><a href="SearchPage" style="color: #1f1f1f;">Search Page</a>
            </li>
            <li><a href="/Manager/SearchRequestsPage" style="color: #1f1f1f;">Requests Search Page</a>
            </li>
            <li class="active"><a href="/Manager/SearchUsersPage" style="color: #1f1f1f; background-color: #6adbbb">Users
                Search Page</a>
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
<div class="well well-large" style="display: flex; flex-direction: row">
    <div style="width: 40%;margin: 3%">
        <form id="searchForm">
            <div class="mb-3">
                <label for="start" class="form-label">Start Date</label>
                <input name="start" type="date" id="start" class="form-control">
            </div>
            <br>
            <div class="mb-3">
                <label for="end" class="form-label">End Date</label>
                <input name="end" type="date" id="end" class="form-control">
            </div>
        </form>
        <button class="btn btn-success" id="searchBtn" onclick="getUserTableContent()"
                style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>search
        </button>
    </div>
</div>
<div>
    <table class="table table-striped" id="searchTable">
        <thead class="thead-light" style="background-color: #dddede">
        <tr>
            <th scope="col">#</th>
            <th scope="col">Name</th>
            <th scope="col">Family</th>
            <th scope="col">Email</th>
            <th scope="col">Role</th>
            <th scope="col">Number Of Requests</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
</body>
</html>
<script>

    function getFormData($form) {
        var unindexed_array = $form.serializeArray();
        var indexed_array = {};

        $.map(unindexed_array, function (n, i) {
            if (n['value'] === "") {
                indexed_array[n['name']] = null;
            } else {
                indexed_array[n['name']] = n['value'];
            }
        });

        return indexed_array;
    }

    function getUserTableContent() {
        var form1 = $("#searchForm");
        var formData1 = getFormData(form1);
        $.ajax({
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(formData1),
            dataType: 'json',
            url: "/findByCreationDateAndRequests",
            success: function (data) {
                $("#searchTable tr:gt(0)").remove();
                $(function () {
                    var row = "";
                    $.each(data, function (i, f) {
                        row = row + addRowToRequestTable(i, f);
                    });
                    $("#searchTable").append(row);
                });
            }
        });
    }

    function addRowToRequestTable(i, f) {
        var row = "";
        row = row + "<tr id='tr " + f.id + "'><th scope=\"row\">" + (i + 1) + "</th><td class='name'>" + f.user.name + "</td>";
        row = row + "<td class='family'>" + f.user.family + "</td><td>" + f.user.email + "</td><td class='role'>" + f.user.role + "</td><td class='number'>" + f.numberOfRequests + "</td></tr>";
        return row;
    }
</script>
