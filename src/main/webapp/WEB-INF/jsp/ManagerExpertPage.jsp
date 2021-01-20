
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <!-- Bootstrap CSS -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <!--link rel="stylesheet" href="CssConfig.css"-->
    <title>title</title>
</head>
<body>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">Manager Page</a>
        </div>
        <ul class="nav navbar-nav">
            <li><a href="ServicePage">Service Page</a></li>
            <li class="active"><a href="ExpertPage">Expert Page</a></li>
            <li><a href="SearchPage">Search Page</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Log out</a></li>
        </ul>
    </div>
</nav>
<div style="display: flex; flex-direction: row">
    <div class="vertical-menu">
        <a href="ExpertPage" class="active">Add Service</a>
        <a href="ShowExpertPage">Show Services</a>
    </div>
<div style="width: 40%; margin: 5%">
    <h3>Add Expert</h3>
    <div>
<form id="addExpert" method="post">
    <div style="display: none">
    <label for="id">id</label>
    <input type="text" name="id" id="id">
    </div>
    <div class="mb-3">
    <label for="name" class="form-label">name</label>
    <input type="text" name="name" id="name" class="form-control">
    </div>
    <div class="mb-3">
    <label for="family" class="form-label">family</label>
    <input type="text" name="family" id="family" class="form-control">
    </div>
    <div class="mb-3">
    <label for="email" class="form-label">email</label>
    <input type="email" name="email" id="email" class="form-control">
    </div>
    <div class="mb-3">
    <label for="password" class="form-label">password</label>
    <input type="password" name="password" id="password" class="form-control">
    </div>
    <input type="submit" class="btn btn-primary" id="submit" value="Add Expert">
</form>
    </div>
<div class="upload-content" id="imageDiv">
    <div class="single-upload">
        <h3>Upload Image</h3>
        <form id="singleUploadForm" name="singleUploadForm">
            <input id="singleFileUploadInput" type="file" name="file" class="file-input" required />
            <button type="submit" class="primary submit-btn">Submit</button>
        </form>
        <div class="upload-response">
            <div id="singleFileUploadError"></div>
            <div id="singleFileUploadSuccess"></div>
        </div>
    </div>
</div>
</div>
</div>
</body>
<script>
    $('#addExpert').submit(function(event) {
        var userdata = {};
        userdata["role"] = "EXPERT";
        userdata["name"] = $("#name").val();
        userdata["family"] = $("#family").val();
        userdata["email"] = $("#email").val();
        userdata["password"] = $("#password").val();
        $.ajax({
            type : "POST",
            contentType : "application/json",
            url : "/addExpert",
            data : JSON.stringify(userdata),
            dataType : 'json',
            success : function(data) {
                $("#id").val(data);
            }
        });
        event.preventDefault();
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
<style>
    .vertical-menu {
        width: 20%; /* Set a width if you like */
    }

    .vertical-menu a {
        background-color: #eee; /* Grey background color */
        color: black; /* Black text color */
        display: block; /* Make the links appear below each other */
        padding: 12px; /* Add some padding */
        text-decoration: none; /* Remove underline from links */
    }

    .vertical-menu a:hover {
        background-color: #ccc; /* Dark grey background on mouse-over */
    }

    .vertical-menu a.active {
        background-color: #163bc1; /* Add a green color to the "active/current" link */
        color: white;
    }
</style>
</html>
