<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 2/1/21
  Time: 1:04 PM
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
        <a href="/Customer/ChooseExpertPage" class="active">Choose Expert For Requests</a>
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
                <th scope="col">Choose Expert</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="optionsModal" tabindex="-1" aria-labelledby="edit" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exampleModalLabel">Choose Experts Options</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table table-striped" id="optionTable">
                    <thead class="thead-light" style="background-color: #dddede">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Expert Name</th>
                        <th scope="col">Start Time</th>
                        <th scope="col">Duration</th>
                        <th scope="col">Price</th>
                        <th scope="col">Score</th>
                        <th scope="col">Select</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveChanges"
                        onclick="addExpertToRequest()"
                        style="background-color: #48ddf1;border-color: #48ddf1;color: #1f1f1f">Save changes
                </button>
            </div>
        </div>
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
            url: "/getRequestsWaitingForChoosingExpert",
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
        row = row + "<td class='subService'>" + f.subService.name + "</td><td class='date'>" + newDate + "</td><td class='proposedPrice'>" + f.proposedPrice + "</td><td class='address'>" + f.address + "</td><td class='description'>" + f.description + "</td><td>" +
            "<button type=\"button\" class=\"btn btn-danger\" id='selectOption " + f.id + "' onclick='getOptionTableContent(" + f.id + ")' data-toggle='modal' data-target='#optionsModal' style='background-color: #48ddf1;border-color: #48ddf1;color: #1f1f1f'>Choose Expert</button></td></tr>";
        return row;
    }

    function getOptionTableContent(id) {
        requestId = id;
        $.ajax({
            type: "GET",
            url: "/getOptionsByRequestId/" + requestId,
            success: function (data) {
                $(function () {
                    var row = "";
                    $.each(data, function (i, f) {
                        row = row + addRowToOptionTable(i, f);
                    });
                    $("#optionTable tr:gt(0)").remove();
                    $("#optionTable").append(row);
                });
            }
        });
    }

    function addRowToOptionTable(i, f) {
        var row = "";
        row = row + "<tr><th scope=\"row\">" + (i + 1) + "</th><td class='name'>"
            + f.expert.name + " " + f.expert.family + "</td>";
        row = row + "<td class='startTime'>" + f.option.startTime + "</td>" +
            "<td class='duration'>" + f.option.duration + "</td><td class='price'>" +
            f.option.price + "</td><td class='score'>" + f.expert.score + "</td>" +
            "<td><input class=\"form-check-input\" type=\"checkbox\" value=\"\" " +
            "id=\"checkBox " + (i + 1) + "\" onchange='setExpertId(" + f.expert.id + ", this)'></td></tr>";
        return row;
    }

    function setExpertId(id, checkBox) {
        var rowNumber = $("#optionTable tr").length;
        if (checkBox.checked) {
            $("#saveChanges").prop("disabled", false);
            expertId = id;
            var checked = parseInt(checkBox.id.toString().split(" ")[1]);
            for (var i = 1; i < rowNumber; i++) {
                if (i !== checked) {
                    var checkBoxId = "checkBox " + i;
                    document.getElementById(checkBoxId).disabled = true;
                }
            }
        } else {
            $("#saveChanges").prop("disabled", true);
            for (var i = 1; i < rowNumber; i++) {
                var checkBoxId = "checkBox " + i;
                document.getElementById(checkBoxId).disabled = false;
            }
        }
    }

    function addExpertToRequest() {
        $.ajax({
            type: "PUT",
            url: "/addExpertToRequest/" + requestId + "/" + expertId,
            success: function (response) {
                document.getElementById("tr "+requestId).remove();
                showSuccessMessage(response);
            }
        });
    }

    function showSuccessMessage(response) {
        $("#message").html("<span><h4>" + response + "</h4></span>");
        $("#message").css('display', 'flex');
        hideMessage();
    }

    function hideMessage() {
        setTimeout(function () {
            $('#message').fadeOut('fast');
        }, 7000);
    }

</script>

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
