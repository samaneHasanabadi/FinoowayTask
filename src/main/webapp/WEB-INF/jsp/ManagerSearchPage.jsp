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
            <li class="active"><a href="SearchPage" style="color: #1f1f1f; background-color: #6adbbb">Search Page</a>
            </li>
            <li><a href="/Manager/SearchRequestsPage" style="color: #1f1f1f;">Requests Search Page</a>
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
                <label for="name" class="form-label">Name</label>
                <input name="name" class="form-control" id="name">
            </div>
            <br>
            <div class="mb-3">
                <label for="family" class="form-label">Family</label>
                <input name="family" class="form-control" id="family">
            </div>
            <br>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input name="email" class="form-control" id="email">
            </div>
            <br>
            <div class="mb-3">
                <label for="status" class="form-label">Status</label>
                <select name="status" id="status" class="form-select" aria-label="Default select example">
                    <option></option>
                    <option value="REGISTERED">REGISTERED</option>
                    <option value="WAITING">WAITING</option>
                    <option value="APPROVED">APPROVED</option>
                </select>
            </div>
            <br>
        </form>
        <button class="btn btn-success" id="searchBtn"
                style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>search
        </button>
    </div>
    <div style="width: 4%">
    </div>
    <div style="width: 40%; margin: 3%">
        <form id="conSearchForm">
            <div class="mb-3">
                <label for="service" class="form-label">Service Name</label>
                <input name="service" id="service" class="form-control">
            </div>
            <br>
            <div class="mb-3">
                <label for="subService" class="form-label">Sub Service Name</label>
                <input name="subService" id="subService" class="form-control">
            </div>
            <br>
            <div class="mb-3">
                <label for="role" class="form-label">Role</label>
                <select name="role" id="role" class="form-select" aria-label="Default select example">
                    <option></option>
                    <option value="EXPERT">EXPERT</option>
                    <option value="CUSTOMER">CUSTOMER</option>
                </select>
            </div>
            <br>
            <div class="mb-3">
                <label for="score" class="form-label">Score</label>
                <input name="score" type="number" id="score" class="form-control">
            </div>
            <br>
        </form>
    </div>
</div>
<div style="display: none" id="divTable">
    <div style="justify-content: center"></div>
    <h4><strong>Result Of Search</strong></h4></div>
<table class="table table-striped" id="searchTable">
    <thead class="thead-light" style="background-color: #dddede">
    <tr>
        <th scope="col">#</th>
        <th scope="col">Name</th>
        <th scope="col">Family</th>
        <th scope="col">Email</th>
        <th scope="col">Role</th>
        <th scope="col">Status</th>
        <th scope="col">Service</th>
        <th scope="col">Sub Service</th>
        <th scope="col">Score</th>
        <th scope="col">See Requests</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
</div>
<!-- Modal -->
<div class="modal fade" id="editSubService" tabindex="-1" aria-labelledby="edit" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exampleModalLabel">Requests</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div>
                    <table class="table table-striped" id="requestTable">
                        <thead class="thead-light" style="background-color: #dddede">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Title</th>
                            <th></th>
                            <th scope="col">Sub Service</th>
                            <th></th>
                            <th scope="col">Date</th>
                            <th></th>
                            <th scope="col">Price</th>
                            <th></th>
                            <th scope="col">Status</th>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    function getFormData($form) {
        var unindexed_array = $form.serializeArray();
        var indexed_array = {};

        $.map(unindexed_array, function (n, i) {
            if (n['name'] === "role" && n['value'] === "") {
                indexed_array[n['name']] = null;
            } else if (n['name'] === "status" && n['value'] === "") {
                indexed_array[n['name']] = null;
            } else {
                indexed_array[n['name']] = n['value'];
            }
        });

        return indexed_array;
    }

    $("#searchBtn").on('click', function () {
        $("#divTable").show();
        $("#searchTable tr:gt(0)").remove();
        var form1 = $("#searchForm");
        var form2 = $("#conSearchForm");
        var formData1 = getFormData(form1);
        var formData2 = getFormData(form2);
        var searchData = $.extend(formData1, formData2);
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "/findByCriteria",
            data: JSON.stringify(searchData),
            dataType: 'json',
            success: function (data2) {
                $.each(data2, function (i, f) {
                    $("#searchTable").append("<tr id='tr" + f.id + "'><td>" + (i + 1) + "</td><td class='name'>" + f.name +
                        "</td><td class='family'>" + f.family + "</td><td class='username'>" + f.email + "</td><td class='id'>" + f.role + "</td>" +
                        "<td class='status'>" + f.status + "</td><td id='tdSubService" + f.id + "' class='subServices' >" + getServiceArrays(f.subServices, f.role) + "</td>" +
                        "<td id='tdSubService" + f.id + "' class='subServices' >" + getOfArrays(f.subServices, f.role) + "</td>" +
                        "<td class='id'>" + getScore(f.role, f.score) + "</td>" +
                        "<td><button id='seeRequestsBtn " + f.id + "' onclick='getRequests("+ f.id +",\""+ f.role+"\")' data-toggle='modal' data-target='#editSubService' class=\"btn btn-warning\" style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>Requests</button></td></tr>");
                });
            }
        });
    });

    function getOfArrays(array, role) {
        var text = "";
        if (role === "EXPERT") {
            for (var i = 0; i < array.length; i++) {
                text = text + array[i].name + "-";
            }
        }
        return text;
    }

    function getServiceArrays(array, role) {
        var text = "";
        if (role === "EXPERT") {
            for (var i = 0; i < array.length; i++) {
                text = text + array[i].service.name + "-";
            }
        }
        return text;
    }

    function getScore(role, score) {
        var text = "";
        if (role === "EXPERT") {
            if (score === undefined) {
                text = "0";
            } else {
                text = score;
            }
        }
        return text;
    }

    function getRequests(id, role) {
        if (role === "CUSTOMER") {
            var status = "null";
            $.ajax({
                type: "GET",
                url: "/getCustomerRequests/" + id + "/" + status,
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
        if(role === "EXPERT"){
            var status = "null";
            $.ajax({
                type: "GET",
                url: "/getExpertRequests/" + id + "/" + status,
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
    }

    function addRowToRequestTable(i, f) {
        var dateFormat = JSON.stringify(f.date);
        var res = dateFormat.split("-");
        var day = (res[2].split("\""))[0].split("T")[0];
        var month = res[1];
        var year = (res[0].split("\""))[1];
        var newDate = month + "/" + day + "/" + year;
        var row = "";
        row = row + "<tr id='tr " + f.id + "'><th scope=\"row\">" + (i + 1) + "</th><td class='title'>" + f.title + "</td><td></td>";
        row = row + "<td class='subService'>" + f.subService.name + "</td><td></td><td class='date'>" + newDate + "</td><td></td><td class='proposedPrice'>" + f.price + "</td><td></td><td class='status'>" + f.requestStatus + "</td><td></tr>";
        return row;
    }

</script>
</html>
