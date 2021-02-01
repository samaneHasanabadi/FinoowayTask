<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 1/31/21
  Time: 6:06 PM
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
<body onload="getUserData(); getSubService()">
<nav class="navbar navbar-inverse" style="background-color: #dddede; border-color: #dddede ">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#" style="color: #1f1f1f">Customer Page</a>
        </div>
        <ul class="nav navbar-nav">
            <li class="active"><a href="/Customer/ServicePage" style="color: #1f1f1f;background-color: #48ddf1">Service
                Page</a>
            </li>
            <li><a href="/Customer/RequestPage" style="color: #1f1f1f">Request
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

<div class="well well-large" style="display: flex; flex-direction: row">
    <div style="width: 40%;margin-left: 3%;margin-right: 3%">
        <div id="subServiceInfo" class="well well-large"
             style="text-align:center; background-color: #48ddf1;width: 85%;height:8%">
            <strong style='font-size: large; color: #1f1f1f'>Sub service Information</strong>
        </div>
        <form>
            <div class="mb-3">
                <label for="name" class="form-label">Name</label>
                <input name="name" class="form-control" id="name" readonly>
            </div>
            <br>
            <div class="mb-3">
                <label for="type" class="form-label">Type</label>
                <input name="family" class="form-control" id="type" readonly>
            </div>
            <br>
            <div class="mb-3">
                <label for="service" class="form-label">Service</label>
                <input name="family" class="form-control" id="service" readonly>
            </div>
            <br>
            <div class="mb-3">
                <label for="price" class="form-label">Price</label>
                <input name="service" id="price" class="form-control" readonly>
            </div>
            <br>
            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" id="description" rows="3" readonly></textarea>
            </div>
        </form>
    </div>
    <div style="width: 4%">
    </div>
    <div style="width: 40%; margin-left: 3%;margin-right: 3%">
        <div id="requestInfo" class="well well-large"
             style="text-align:center; background-color: #48ddf1;width: 85%;height:8%;">
            <strong style='font-size: large; color: #1f1f1f'>Add a request</strong>
        </div>
        <form id="requestForm">
            <div class="mb-3">
                <label for="title" class="form-label">Title</label>
                <input type="text" name="title" class="form-control" id="title" required oninput="checkTitle()">
                <div id="titleDiv" style="color: red"></div>
            </div>
            <br>
            <div class="mb-3">
                <label for="date" class="form-label">Date</label>
                <input type="date" name="date" class="form-control" id="date" required oninput="checkDate()">
                <div id="dateDiv" style="color: red"></div>
            </div>
            <br>
            <div class="mb-3">
                <label for="proposedPrice" class="form-label">Proposed Price</label>
                <input type="number" name="proposedPrice" id="proposedPrice" class="form-control" required oninput="checkPrice()">
                <div id="priceDiv" style="color: red"></div>
            </div>
            <br>
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <textarea class="form-control" id="address" rows="2" required></textarea>
            </div>
            <br>
            <div class="mb-3">
                <label for="requestDescription" class="form-label">Description</label>
                <textarea class="form-control" id="requestDescription" rows="3" required></textarea>
            </div>
        </form>
        <button class="btn btn-success" id="addRequestBtn" onclick="addRequest()"
                style='background-color: #48ddf1;border-color: #48ddf1;color: #1f1f1f'>Add Request
        </button>
    </div>
</div>
</body>
</html>
<script>
    var customerId = 0;
    var subServiceId = 0;

    function getUserData() {
        $.ajax({
            type: "GET",
            url: "/getUserId",
            success: function (data2) {
                customerId = data2;
            }
        });
    }

    function getSubServiceId() {
        let params = window.location.href;
        subServiceId = params.toString().split("=")[1];
    }

    function getSubService() {
        getSubServiceId();
        $.ajax({
            type: "GET",
            url: "/getSubServiceById/" + subServiceId,
            success: function (response) {
                $("#name").val(response.name);
                $("#type").val(response.type.name)
                $("#service").val(response.service.name);
                $("#price").val(response.price);
                $("#description").val(response.description);
            }
        });
    }

    var boolTitle = false;
    var boolDate = false;
    var boolPrice = false;


    var temp = false;

    function checkTitle() {
        $("#titleDiv").hide();
        var name = {};
        name["input"] = $("#title").val();
        name["inputName"] = "title";
        ajaxCall("/checkTitleLength", name, "#title", "#titleDiv");
        boolTitle = temp;
    }

    function checkDate() {
        $("#dateDiv").hide();
        var name = {};
        name["date"] = $("#date").val();
        ajaxCall("/checkDate", name, "#date", "#dateDiv");
        boolDate = temp;
    }

    function checkPrice() {
        $("#priceDiv").hide();
        var name = {};
        name["input"] = $("#proposedPrice").val();
        name["inputName"] = $("#price").val();
        ajaxCall("/checkPrice", name, "#price", "#priceDiv");
        boolPrice = temp;
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

    function addRequest(){
        if(boolPrice && boolDate && boolTitle) {
            var formData = {};

            formData["title"] = $("#title").val();
            formData["proposedPrice"] = $("#proposedPrice").val();
            formData["address"] = $("#address").val();
            formData["date"] = $("#date").val();
            formData["description"] = $("#requestDescription").val();
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/addRequest/"+customerId +"/" + subServiceId,
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
    }

    function showSuccessMessage(response) {
        if (response.toString().includes("added")) {
            document.getElementById("requestForm").reset();
        }
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