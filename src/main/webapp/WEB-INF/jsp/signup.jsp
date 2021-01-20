<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 1/1/21
  Time: 4:57 PM
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
    <style type="text/css">
        body {
            background-image: url('a.jpg');
        }
    </style>
</head>
<body>
<div>
    <div style="display: none" id="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
<div class="container" style="width: 30%;margin: 5%;background-image: url('a.jpg')">
<h2>sign up</h2>
        <div class="mb-3">
        <label for="role" class="form-label">Role</label>
        <select name="role" id="role" class="form-select" aria-label="Default select example" style="color: black">
            <option value="EXPERT">EXPERT</option>
            <option value="CUSTOMER">CUSTOMER</option>
        </select>
        </div><br>
        <input style="display: none" type="text" id="id"></td>
        <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" id="name" placeholder="Name">
        </div><br>
<div class="mb-3">
    <label for="family" class="form-label">Family</label>
    <input type="text" class="form-control" id="family" placeholder="Family">
</div><br>
<div class="mb-3">
<label for="email" class="form-label">Email</label>
<input type="email" class="form-control" id="email" placeholder="Name@exmaple.com">
</div><br>
<div class="mb-3">
    <label for="Password" class="form-label">Password</label>
    <input type="Password" class="form-control" id="password" placeholder="Password">
</div><br>
<button type="button" id="submit" class="btn btn-primary">Sign Up</button><br>
</div>
<div class="upload-content container" id="imageDiv" style="display: none">
    <div class="single-upload">
        <h3>Upload Image</h3>
        <form id="singleUploadForm" name="singleUploadForm">
            <div class="form-group">
            <input id="singleFileUploadInput" type="file" name="file" class="file-input" required />
            </div><br>
            <button type="submit" class="primary submit-btn btn btn-primary" style="background-color: #c0c1c1; color: black">Submit</button>
        </form>
        <div class="upload-response">
            <div id="singleFileUploadError"></div>
            <div id="singleFileUploadSuccess"></div>
        </div>
    </div>
</div>
</div>
</body>
<script>

    $("#submit").click(function(){
        var userdata = {};
        userdata["role"] = $("#role").val();
        if(userdata["role"] === "EXPERT"){
            $("#imageDiv").show();
        }else {
            $("#imageDiv").hide();
        }
        userdata["name"] = $("#name").val();
        userdata["family"] = $("#family").val();
        userdata["email"] = $("#email").val();
        userdata["password"] = $("#password").val();
        $.ajax({
            type : "POST",
            contentType : "application/json",
            url : "addUser/" + userdata["role"],
            data : JSON.stringify(userdata),
            dataType : 'json',
            success : function(data) {
                $("#id").val(data.id);
                $("#alert").innerHTML = data.message;
                $("#alert").show();
            }
        });
    });
    var singleUploadForm = document.querySelector('#singleUploadForm');
    var singleFileUploadInput = document.querySelector('#singleFileUploadInput');
    var singleFileUploadError = document.querySelector('#singleFileUploadError');
    var singleFileUploadSuccess = document.querySelector('#singleFileUploadSuccess');

    function uploadSingleFile(file) {
        var formData = new FormData();
        formData.append("file", file);

        var xhr = new XMLHttpRequest();
        xhr.open("POST", "/uploadFile/" + $("#id").val());

        xhr.onload = function() {
            console.log(xhr.responseText);
            var response = JSON.parse(xhr.responseText);
            if(xhr.status == 200) {
                singleFileUploadError.style.display = "none";
                singleFileUploadSuccess.innerHTML = "<p>File Uploaded Successfully.</p><p>DownloadUrl : <a href='" + response.fileDownloadUri + "' target='_blank'>" + response.fileDownloadUri + "</a></p>";
                singleFileUploadSuccess.style.display = "block";
            } else {
                singleFileUploadSuccess.style.display = "none";
                singleFileUploadError.innerHTML = (response && response.message) || "Some Error Occurred";
            }
        }

        xhr.send(formData);
    }
    $('#singleUploadForm').submit(function(event) {
        var formElement = this;
        var formData = new FormData(formElement);
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/uploadFile/" + $("#id").val(),
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                console.log(response);
            },
            error: function (error) {
                console.log(error);
            }
        });

        event.preventDefault();
    });
</script>
</html>
