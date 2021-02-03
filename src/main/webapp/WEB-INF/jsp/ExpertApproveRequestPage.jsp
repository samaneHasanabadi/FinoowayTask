<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 2/1/21
  Time: 7:07 PM
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
        <a href="/Expert/RequestPage">Choose Requests</a>
        <a href="/Expert/ApproveRequestPage" class="active">Approved Requests</a>
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
                <th scope="col">Price</th>
                <th scope="col">Address</th>
                <th scope="col">Description</th>
                <th scope="col">Start Service</th>
                <th scope="col">Finish Service</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>
!-- Modal -->
<div class="modal fade" id="startModal" tabindex="-1" aria-labelledby="edit" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Start Service</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are You Sure You Want To Start The Service?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveChanges"
                        onclick="startService()"
                        style="background-color: #f1d548;border-color: #f1d548;color: #1f1f1f" >Save changes
                </button>
            </div>
        </div>
    </div>
</div>

!-- Modal -->
<div class="modal fade" id="finishModal" tabindex="-1" aria-labelledby="edit" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Finish Service</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are You Sure You Want To Finish The Service?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal"
                        onclick="finishService()"
                        style="background-color: #f1d548;border-color: #f1d548;color: #1f1f1f">Save changes
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
            url: "/getApprovedRequestsOfExpert/" + expertId,
            success: function (data) {
                $(function () {
                    $.each(data, function (i, f) {
                        var row = "";
                        row = row + addRowToRequestTable(i, f);
                        $("#requestTable").append(row);
                        setButtonStatus(f.requestStatus, f.id);
                    });
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
        row = row + "<tr><th scope=\"row\">" + (i + 1) + "</th><td class='title'>" +
            f.title + "</td><td class='customer'>" + f.customer.name + " " +
            f.customer.family + "</td>";
        row = row + "<td class='subService'>" + f.subService.name +
            "</td><td class='date'>" + newDate + "</td><td class='proposedPrice'>"
            + f.price + "</td><td class='address'>" + f.address +
            "</td><td class='description'>" + f.description + "</td>" +
            "<td><button class=\"btn btn-success\" id='startBtn "+ f.id +
            "' data-toggle='modal' data-target='#startModal'"+
            " onclick='setRequestId("+f.id+")' style=\"background-color: #f1d548; border-color: #f1d548; color: #1f1f1f\">Start</button></td>" +
            "<td><button class=\"btn btn-success\" id='finishBtn "+ f.id +
            "' data-toggle='modal' data-target='#finishModal'"+
            " onclick='setRequestId("+f.id+")' style=\"background-color: #f1d548; border-color: #f1d548; color: #1f1f1f\">Finish</button></td></tr>";
        return row;
    }

    function setButtonStatus(status , requestId){
        if(status === "FINISHED"){
            var id = "startBtn " + requestId;
           document.getElementById(id).disabled = true;
            id = "finishBtn " + requestId;
            document.getElementById(id).disabled = true;

        }else if(status === "IN_PROCESS"){
            var id = "#startBtn " + requestId;
            document.getElementById(id).disabled = true;
        }
    }

    function setRequestId(id){
        requestId = id;
    }

    function startService() {
        $.ajax({
            type: "PUT",
            url: "/startRequest/" + requestId,
            success: function (response) {
                var id = "startBtn " + requestId;
                document.getElementById(id).disabled = true;
                showSuccessMessage(response);
            }
        });
    }

    function finishService() {
        $.ajax({
            type: "PUT",
            url: "/finishRequest/" + requestId,
            success: function (response) {
                var id = "finishBtn " + requestId;
                document.getElementById(id).disabled = true;
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