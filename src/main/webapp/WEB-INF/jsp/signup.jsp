<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <title>title</title>
    <style type="text/css">
        body {
            background: url('/resources/image/d.png');
        }
    </style>
</head>
<body>
<div id="message" style="display: none;justify-content: center;background-color: #f1d548;align-items: center;border-color: #868787;width: 85%;height:5%;margin-top: 1%;margin-left: 5%">
</div>
<div>
    <div class="container" style="width: 30%;margin: 5%; background-color: #dddede">
        <h2>Sign Up</h2>
        <form id="signupForm" onsubmit="return validate()">
            <input style="display: none" type="text" id="id">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" id="name" oninput="checkName()" placeholder="Name" required="true">
            <div id="nameMessageDiv" style="color: red"></div>
            <br>
            <label for="family" class="form-label">Family</label>
            <input type="text" class="form-control" id="family" oninput="checkFamily()" placeholder="Family" required>
            <div id="familyMessageDiv" style="color: red"></div>
            <br>
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" oninput="checkEmail()"
                   placeholder="Name@exmaple.com" required>
            <div id="emailMessageDiv" style="color: red"></div>
            <br>
            <label for="Password" class="form-label">Password</label>
            <input type="Password" class="form-control" id="password" oninput="checkPassword()"
                   placeholder="Password" required>
            <div id="passwordMessageDiv" style="color: red"></div>
            <br>
            <label for="role" class="form-label">Role</label>
            <select name="role" id="role" class="form-select" onchange="showImageDiv(); checkRole()"
                    aria-label="Default select example" style="color: black" required>
                <option value="" selected></option>
                <option value="EXPERT">EXPERT</option>
                <option value="CUSTOMER">CUSTOMER</option>
            </select><br><br>
            <div id="formImageDiv"></div>
            <button type="submit" id="submit" class="primary btn submit-btn btn-primary"
                    style="background-color: #6adbbb;border-color: #6adbbb; color: #1f1f1f">Sign Up
            </button>
            <br>
        </form>
        <div class="upload-content container" id="imageDiv" style="display: none">
            <div class="single-upload" id="imageDiv2">
                <form id="singleUploadForm" name="singleUploadForm" onsubmit="return validate()" method="POST">
                    <div class="form-group">
                        <label for="singleFileUploadInput" class="form-label">Upload Image</label>
                        <input id="singleFileUploadInput" type="file" name="file"
                               class="file-input" required/>
                    </div>
                    <div class="upload-response">
                        <div id="singleFileUploadError" style="color: red"></div>
                    </div>
                    <button type="submit" class="primary btn submit-btn btn-primary" id="submit2"
                            style="background-color: #6adbbb;border-color: #6adbbb; color: #1f1f1f">Sign Up
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    var flag = true;
    var expertStatus = false;
    var boolName = false;
    var boolFamily = false;
    var boolEmail = false;
    var boolPassword = false;
    var boolRole = false;
    var temp = false;
    function showImageDiv() {
        var role = $("#role").val();
        if (role === "EXPERT" && flag) {
            $("#imageDiv2").appendTo($("#formImageDiv"));
            $("#submit").hide();
            flag = false;
        }else if(role === "EXPERT" && !flag){
            $("#imageDiv2").show();
            $("#submit").hide();
        }
        else {
            $("#imageDiv2").hide();
            $("#submit").show();
        }
    }

    $(document).ready(function () {
        $("#password").keyup(checkPassword);
    });

    function checkPassword(){
        $("#passwordMessageDiv").hide();
        var password = {};
        password["input"] = $("#password").val();
        ajaxCall("/passwordCheck", password, "#password");
        boolPassword = temp;
    }

    function checkName(){
        $("#nameMessageDiv").hide();
        var name = {};
        name["input"] = $("#name").val();
        ajaxCall("/nameCheck", name, "#name");
        boolName = temp;
    }

    function checkFamily(){
        $("#familyMessageDiv").hide();
        var family = {};
        family["input"] = $("#family").val();
        ajaxCall("/nameCheck", family, "#family");
        boolFamily = temp;
    }

    function checkEmail(){
        var email = {};
        email["input"] = $("#email").val();
        ajaxCall("/emailCheck", email, "#email");
        if(temp){
            emailAjaxCall("/emailCheckUniqueness", email)
        }else {
            $("#emailMessageDiv").style.display = "none";
        }
        boolEmail = temp;
    }

    function emailAjaxCall(url, input){
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: url,
            data: JSON.stringify(input),
            dataType: 'json',
            async: false,
            success: function (data) {
                $("#emailMessageDiv").hide();
                temp = true;
            },
            error: function (error) {
                if(error.responseText.includes("not")){
                    $("#emailMessageDiv").hide();
                    temp = true;
                }else {
                    temp = false;
                    $("#emailMessageDiv").show();
                    $("#emailMessageDiv").html((error.responseText) ||
                        "Some Error Occurred");
                }

            }
        });
    }

    function checkRole(){
        if($("#role").val() === ""){
            boolRole = false;
        }else {
            boolRole = true;
        }
    }

    function ajaxCall(url, input, id){
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: url,
            data: JSON.stringify(input),
            dataType: 'json',
            async: false,
            success: function (data) {
                if(!data){
                    temp = false;
                    $(id).css("border-color", "red");
                }else{
                    $(id).css("border-color", '#dddede');
                    temp = true;
                }
            }
        });
    }

    $("#signupForm").submit(function (event) {
        if(boolRole && boolEmail && boolFamily && boolName && boolPassword) {
            var userdata = {};
            userdata["role"] = $("#role").val();
            userdata["name"] = $("#name").val();
            userdata["family"] = $("#family").val();
            userdata["email"] = $("#email").val();
            userdata["password"] = $("#password").val();
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "addUser/" + userdata["role"],
                data: JSON.stringify(userdata),
                dataType: 'json',
                success: function (data) {
                    $("#id").val(data.id);
                    showSuccessMessage(data);
                }
            });
            event.preventDefault();
        }
    });

    var singleFileUploadError = document.querySelector('#singleFileUploadError');

    $('#singleUploadForm').submit(function(event) {
        if(boolRole && boolEmail && boolFamily && boolName && boolPassword) {
            var formElement = this;
            var formData = new FormData(formElement);
            var userdata = {};
            userdata["role"] = $("#role").val();
            userdata["name"] = $("#name").val();
            userdata["family"] = $("#family").val();
            userdata["email"] = $("#email").val();
            userdata["password"] = $("#password").val();
            if (!expertStatus) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "addUser/" + userdata["role"],
                    data: JSON.stringify(userdata),
                    dataType: 'json',
                    success: function (data) {
                        expertStatus = true;
                        $("#id").val(data.id);
                        imageAjaxCall(formData);
                    }
                });
            } else {
                imageAjaxCall(formData);
            }
            event.preventDefault();
        }
    });

    function imageAjaxCall(formData){
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/uploadFile/" + $("#id").val(),
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                console.log(response);
                showSuccessMessage(response);
                expertStatus = false;
                singleFileUploadError.style.display = "none";
            },
            error: function (error) {
                console.log(error);
                singleFileUploadError.style.display = "block";
                singleFileUploadError.innerHTML = (error.responseText) ||
                    "Some Error Occurred";
            }
        });
    }

    function showSuccessMessage(response){
        if(response.id !== 0) {
            $("#message").html("<span><h4><strong>Welcome!</strong> Your information is registered successfully, please check your email and click the\n" +
                "        the link to complete your registration!</h4></span>");
        }else {
            $("#message").html("<span><h4>"+ response.message + "</h4></span>");
        }
        $("#message").css('display', 'flex');
        hideMessage();
    }

    function hideMessage() {
        setTimeout(function () {
            $('#message').fadeOut('fast');
        }, 10000);
    }

    function validate(){
        if(boolRole && boolEmail && boolFamily && boolName && boolPassword){
            return true;
        }
        if(!boolName){
            //$("#name").focus();
            $("#nameMessageDiv").show();
            $("#nameMessageDiv").html("Length must be 2-16 characters");
            return false;
        }else if(!boolFamily){
            $("#family").focus();
            $("#familyMessageDiv").show();
            $("#familyMessageDiv").html("Length must be 2-16 characters");
        }else if(!boolEmail){
            $("#email").focus();
        }else if(!boolPassword){
            $("#password").focus();
            $("#passwordMessageDiv").show();
            $("#passwordMessageDiv").html("Password must contains words and numbers");
        }else if(!boolRole){
            $("#role").focus();
        }
        return false;
    }

</script>
</html>
