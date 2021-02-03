<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 1/31/21
  Time: 9:18 PM
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
<body onload="getRequestTableContent()">
<nav class="navbar navbar-inverse" style="background-color: #dddede; border-color: #dddede ">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#" style="color: #1f1f1f">Expert Page</a>
        </div>
        <ul class="nav navbar-nav">
            <li><a href="/Expert/ProfilePage" style="color: #1f1f1f;">Sub Service
                Page</a>
            </li>
            <li class="active"><a href="/Expert/RequestPage" style="color: #1f1f1f;background-color: #f1d548">Request
                Page</a></li>
            <li><a href="#" style="color: #1f1f1f">Search Page</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="/logout" style="color: #1f1f1f"><span class="glyphicon glyphicon-log-in"></span> Log out</a>
            </li>
        </ul>
    </div>
</nav>
<div id="message" class="well well-large"
     style="display: none;justify-content: center;align-items: center;background-color: #6adbbb;width: 85%;height:5%;margin-top: 1%;margin-left: 5%">
</div>
<div style="display: flex; flex-direction: row; height: 89%">
    <div class="vertical-menu">
        <a href="/Expert/RequestPage" class="active">Choose Requests</a>
        <a href="/Expert/ApproveRequestPage">Approved Requests</a>
    </div>
    <div style="width: 80%">
        <table class="table table-striped" id="requestTable">
            <thead class="thead-light" style="background-color: #dddede">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Title</th>
                <th scope="col">Customer Name</th>
                <th scope="col">Sub Service</th>
                <th scope="col">Date</th>
                <th scope="col">Proposed Price</th>
                <th scope="col">Address</th>
                <th scope="col">Description</th>
                <th scope="col">Add Option</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="optionModal" tabindex="-1" aria-labelledby="edit" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Add/Edit Option</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="optionForm" method="post">
                    <div class="mb-3" style="display: none">
                        <label for="id" class="form-label">id</label>
                        <input name="id" id="id" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="price" class="form-label">Price</label>
                        <input type="number" name="price" id="price" class="form-control" required
                               oninput="checkPrice()">
                        <div id="priceDiv" style="color: red"></div>
                    </div>
                    <br>
                    <div class="mb-3">
                        <label for="duration" class="form-label">Duration</label>
                        <input type="number" name="duration" id="duration" class="form-control" required
                               oninput="checkDuration()">
                        <div id="durationDiv" style="color: red"></div>
                    </div>
                    <br>
                    <div class="mb-3">
                        <label for="startTime" class="form-label">Start Time</label>
                        <input type="number" name="startTime" id="startTime" class="form-control" required
                               oninput="checkStartTime()">
                        <div id="startTimeDiv" style="color: red"></div>
                    </div>
                    <br>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveChanges"
                        onclick="addOption()"
                        style="background-color: #f1d548;border-color: #f1d548;color: #1f1f1f" disabled>Save changes
                </button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
    var expertId = 0;
    var requestId = 0;

    function getUserData() {
        $.ajax({
            type: "GET",
            url: "/getUserId",
            async: false,
            success: function (data2) {
                expertId = data2;
            }
        });
    }

    function getRequestTableContent() {
        getUserData();
        $.ajax({
            type: "GET",
            url: "/getRequestsWithoutExpert/" + expertId,
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
        row = row + "<tr><th scope=\"row\">" + (i + 1) + "</th><td class='title'>" + f.title + "</td><td class='customer'>" + f.customer.name + " " + f.customer.family + "</td>";
        row = row + "<td class='subService'>" + f.subService.name + "</td><td class='date'>" + newDate + "</td><td class='proposedPrice'>" + f.proposedPrice + "</td><td class='address'>" + f.address + "</td><td class='description'>" + f.description + "</td><td><div class=\"form-check\">" +
            "<input class=\"form-check-input\" type=\"checkbox\" value=\"\" id=\"checkBox " + f.id + "\" onchange='showModal(this, " + f.id + ")'></div></td></tr>";
        return row;
    }

    function showModal(checkBox, id) {
        requestId = id;
        if (checkBox.checked) {
            $("#optionModal").modal("show");
            getOption();
        }
    }

    var boolDuration = false;
    var boolStartTime = false;
    var boolPrice = false;


    var temp = false;

    function checkDuration() {
        $("#durationDiv").hide();
        var name = {};
        name["input"] = $("#duration").val();
        name["inputName"] = "duration";
        ajaxCall("/checkPositivity", name, "#duration", "#durationDiv");
        boolDuration = temp;
        enableSaveChanges();
    }

    function checkStartTime() {
        $("#startTimeDiv").hide();
        var name = {};
        name["input"] = $("#startTime").val();
        name["inputName"] = "startTime";
        ajaxCall("/checkStartTime", name, "#startTime", "#startTimeDiv");
        boolStartTime = temp;
        enableSaveChanges();
    }

    function checkPrice() {
        $("#priceDiv").hide();
        var name = {};
        name["input"] = $("#price").val();
        name["inputName"] = "price";
        ajaxCall("/checkPositivity", name, "#price", "#priceDiv");
        if (temp) {
            ajaxCall("/checkOptionPrice/" + requestId, name, "#price", "#priceDiv");
        }
        boolPrice = temp;
        enableSaveChanges();
    }

    function ajaxCall(url, input, id, divId) {
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: url,
            data: JSON.stringify(input),
            dataType: 'json',
            async: false,
            success: function (response) {
                if (response.toString().includes("good")) {
                    $(id).css("border-color", '#dddede');
                    temp = true;
                } else {
                    temp = false;
                    $(id).css("border-color", "red");
                    $("sNameMessageDiv").html(response);
                }
            },
            error: function (error) {
                if (error.responseText.includes("good")) {
                    $(id).css("border-color", "#dddede");
                    temp = true;
                } else {
                    temp = false;
                    $(id).css("border-color", "red");
                    $(divId).show();
                    $(divId).html(error.responseText);
                }
            }
        });
    }

    function enableSaveChanges() {
        if (boolDuration && boolPrice && boolStartTime) {
            $("#saveChanges").prop("disabled", false);
        } else {
            $("#saveChanges").prop("disabled", true);
        }
    }

    function addOption() {
        var formData = {};
        if ($("#id").val() > 0) {
            formData["id"] = $("#id").val();
        }
        formData["startTime"] = $("#startTime").val();
        formData["duration"] = $("#duration").val();
        formData["price"] = $("#price").val();
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "/addOption/" + requestId + "/" + expertId,
            data: JSON.stringify(formData),
            dataType: 'json',
            success: function (response) {
                showSuccessMessage(response);
            },
            error: function (error) {
                showSuccessMessage(error.responseText)
            }
        });
    }

    function getOption() {
        $.ajax({
            type: "GET",
            url: "/getOptionByExpertAndRequest/" + expertId + "/" + requestId,
            success: function (response) {
                fillOptionModal(response);
            }
        });
    }

    function fillOptionModal(response) {
        $("#id").val(response.id);
        $("#startTime").val(response.startTime);
        $("#duration").val(response.duration);
        $("#price").val(response.price);
        boolStartTime = true;
        boolPrice = true;
        boolDuration = true;
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
        background: url("/resources/image/878.png");
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
        background-color: #f1d548;
    }
</style>
