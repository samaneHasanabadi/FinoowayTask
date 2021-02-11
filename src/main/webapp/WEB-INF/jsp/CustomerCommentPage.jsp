<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 2/3/21
  Time: 9:29 PM
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
            <li><a href="/Customer/RequestHistory" style="color: #1f1f1f;">Request
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
<div style="display: flex; flex-direction: row; height: 89%">
    <div class="vertical-menu">
        <a href="/Customer/RequestPage">Registered Requests</a>
        <a href="/Customer/ChooseExpertPage">Choose Expert For Requests</a>
        <a href="/Customer/PayRequestPage">Pay Cost of Finished Requests</a>
        <a href="/Customer/CommentPage" class="active">Comment Finished Requests</a>
    </div>
    <div style="width: 80%">
        <table class="table table-striped" id="requestTable">
            <thead class="thead-light" style="background-color: #dddede">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Title</th>
                <th scope="col">Sub Service</th>
                <th scope="col">Date</th>
                <th scope="col">Price</th>
                <th scope="col">Description</th>
                <th scope="col">Expert</th>
                <th scope="col">Comment</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="commentModal" tabindex="-1" aria-labelledby="edit" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Add/Edit Comment</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="commentForm" method="post">
                    <div class="mb-3" style="display: none">
                        <label for="id" class="form-label">id</label>
                        <input name="id" id="id" class="form-control">
                    </div>
                    <label for="inlineRadio1" class="form-label">Score</label>
                    <div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1"
                                   value="1" onclick="onClickSaveChangesBtn()">
                            <label class="form-check-label" for="inlineRadio1">1</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2"
                                   value="2" onclick="onClickSaveChangesBtn()">
                            <label class="form-check-label" for="inlineRadio2">2</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio3"
                                   value="3" onclick="onClickSaveChangesBtn()">
                            <label class="form-check-label" for="inlineRadio3">3</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio4"
                                   value="4" onclick="onClickSaveChangesBtn()">
                            <label class="form-check-label" for="inlineRadio3">4</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio5"
                                   value="5" onclick="onClickSaveChangesBtn()">
                            <label class="form-check-label" for="inlineRadio3">5</label>
                        </div>
                        <div id="scoreDiv" style="color: red"></div>
                    </div>
                    <br>
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" id="description" rows="2" oninput="descriptionClick()"></textarea>
                    </div>
                    <br>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveChanges" onclick="addComment()"
                        style="background-color: #48ddf1;border-color: #48ddf1;color: #1f1f1f" disabled>Save changes
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
            url: "/getPaidRequestsOfCustomer/" + customerId,
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
        row = row + "<td class='subService'>" + f.subService.name + "</td><td class='date'>" + newDate + "</td><td class='price'>" + f.price + "</td><td class='description'>" + f.description + "</td><td class='address'>" + f.expert.name + " " + f.expert.family + "</td><td>" +
            "<div class='btn-toolbar'>" +
            "<button type=\"button\" class=\"btn btn-warning\" id='commentBtn " + f.id + "' style='background-color: #48ddf1;border-color: #48ddf1;color: #1f1f1f' data-toggle='modal' data-target='#commentModal' onclick='getComment("+f.id+")'>Comment</button></a>" +
            "</div></td></tr>";
        return row;
    }

    function setRequestId(id){
        requestId = id;
    }

    function getComment (id1){
        setRequestId(id1);
        $.ajax({
            type: "GET",
            url: "/getCommentByRequestId/" + id1,
            success: function (data) {
                if(data != null){
                    var id= "inlineRadio" + data.score;
                    $("#id").val(data.id);
                    document.getElementById(id).checked = true;
                    $("#description").html(data.description);
                }
            }
        });
    }

    function addComment() {
        var formData = {};
        if ($("#id").val() > 0) {
            formData["id"] = $("#id").val();
        }
        for (var i = 1; i < 6; i++){
            if(document.getElementById("inlineRadio"+i).checked){
                formData["score"] = i;
            }
        }
        formData["description"] = $("#description").val();
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "/addCommentToRequest/" + requestId,
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


    function onClickSaveChangesBtn(){
        if(document.getElementById("inlineRadio1").checked || document.getElementById("inlineRadio2").checked || document.getElementById("inlineRadio3").checked || document.getElementById("inlineRadio4").checked || document.getElementById("inlineRadio5").checked ){
            $("#saveChanges").prop("disabled", false);
        }else {
            $("#saveChanges").prop("disabled", true);
        }
    }

    function descriptionClick(){
        $("#saveChanges").prop("disabled", true);
        onClickSaveChangesBtn();
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
        background-position: bottom;
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