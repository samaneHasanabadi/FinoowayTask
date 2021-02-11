<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 2/5/21
  Time: 2:05 PM
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
            <li class="active"><a href="/Manager/SearchRequestsPage" style="color: #1f1f1f; background-color: #6adbbb">Requests Search Page</a>
            </li>
            <li><a href="/Manager/SearchUsersPage" style="color: #1f1f1f;">Users Search Page</a>
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
                <label for="subService" class="form-label">Sub Service Name</label>
                <input name="subService" class="form-control" id="subService">
            </div>
            <br>
            <div class="mb-3">
                <label for="proposedPrice" class="form-label">Proposed Price</label>
                <input name="proposedPrice" type="number" class="form-control" id="proposedPrice">
            </div>
            <br>
            <div class="mb-3">
                <label for="price" class="form-label">Price</label>
                <input name="price" type="number" class="form-control" id="price">
            </div>
        </form>
        <button class="btn btn-success" id="searchBtn" onclick="getRequestTableContent()"
                style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>search
        </button>
    </div>
    <div style="width: 4%">
    </div>
    <div style="width: 40%; margin: 3%">
        <form id="conSearchForm">
            <div class="mb-3">
                <label for="startDate" class="form-label">Start Date</label>
                <input name="startDate" type="date" id="startDate" class="form-control">
            </div>
            <br>
            <div class="mb-3">
                <label for="endDate" class="form-label">End Date</label>
                <input name="endDate" type="date" id="endDate" class="form-control">
            </div>
            <br>
            <div class="mb-3">
                <label for="requestStatus" class="form-label">Status</label>
                <select name="requestStatus" id="requestStatus" class="form-select" aria-label="Default select example">
                    <option></option>
                    <option value="WAITING_FOR_EXPERTS_OPTIONS">WAITING_FOR_EXPERTS_OPTIONS</option>
                    <option value="WAITING_FOR_CHOOSING_EXPERT">WAITING_FOR_CHOOSING_EXPERT</option>
                    <option value="WAITING_FOR_COMING_EXPERT">WAITING_FOR_COMING_EXPERT</option>
                    <option value="IN_PROCESS">IN_PROCESS</option>
                    <option value="FINISHED">FINISHED</option>
                    <option value="PAID">PAID</option>
                </select>
            </div>
            <br>
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <input name="address" id="address" class="form-control">
            </div>
        </form>
    </div>
</div>
<div>
    <table class="table table-striped" id="requestTable">
        <thead class="thead-light" style="background-color: #dddede">
        <tr>
            <th scope="col">#</th>
            <th scope="col">Title</th>
            <th scope="col">Sub Service</th>
            <th scope="col">Customer</th>
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

    function getRequestTableContent() {
        var form1 = $("#searchForm");
        var form2 = $("#conSearchForm");
        var formData1 = getFormData(form1);
        var formData2 = getFormData(form2);
        var searchData = $.extend(formData1, formData2);
        $.ajax({
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(searchData),
            dataType: 'json',
            url: "/findByCriteriaRequests",
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
            row = row + "<td class='subService'>" + f.subService.name + "</td><td>"+f.customer.name+ " "+f.customer.family+"</td><td class='date'>" + newDate + "</td><td class='proposedPrice'>" + f.price + "</td><td class='expert'>" + f.expert.name + " " + f.expert.family + "</td><td class='status'>" + f.requestStatus + "</td><td></tr>";
        }else {
            row = row + "<td class='subService'>" + f.subService.name + "</td><td>"+f.customer.name+ " "+f.customer.family+"</td><td class='date'>" + newDate + "</td><td class='proposedPrice'>" + f.price + "</td><td class='expert'></td><td class='status'>" + f.requestStatus + "</td><td></tr>";
        }
        return row;
    }
</script>
