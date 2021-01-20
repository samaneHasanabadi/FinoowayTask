
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
<%--    <link rel="stylesheet" href="MSPCSS">--%>
    <title>title</title>
</head>
<body>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">Manager Page</a>
        </div>
        <ul class="nav navbar-nav">
            <li class="active"><a href="ServicePage">Service Page</a></li>
            <li><a href="ExpertPage">Expert Page</a></li>
            <li><a href="SearchPage">Search Page</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Log out</a></li>
        </ul>
    </div>
</nav>
<div style="display: flex; flex-direction: row">
<div class="vertical-menu">
    <a href="ServicePage" class="active">Add Service</a>
    <a href="ShowServicePage">Show Services</a>
</div>
<div class="well well-large" style="background-color: #55d5d1; display: flex; flex-direction: row; width: 80%">
    <div style="width: 40%;margin: 3%">
        <h3>Add Service</h3>
        <form id="Service">
            <div class="mb-3">
            <label for="serviceName" class="form-label">Service Name</label>
            <input name="name" class="form-control" id="serviceName">
            </div><br>
            <div class="mb-3">
            <label for="serviceType" class="form-label">Service Type</label>
            <input name="type" class="form-control" id="serviceType">
            </div><br>
            <div>
            <button type="submit" class="btn btn-primary" id="serviceSubmit">Save</button>
            </div>
        </form>
    </div>
    <div style="width: 4%">
    </div>
    <div style="width: 40%; margin: 3%">
        <h3>Add Sub Service</h3>
        <form id="subService" method="post">
            <div class="mb-3">
            <label for="name" class="form-label">Sub Service Name</label>
            <input name="name" id="name" class="form-control">
            </div><br>
            <div class="mb-3">
            <label for="type" class="form-label">Sub Service Type</label>
            <input name="type.name" id="type" class="form-control">
            </div><br>
            <div class="mb-3">
            <label for="serviceSelector" class="form-label">Service</label>
            <select id="ServiceSelector" class="form-select" aria-label="Default select example">
                <option></option>
            </select>
            </div><br>

        <div class="mb-3">
            <label for="price" class="form-label">Price</label>
            <input name="price" id="price" class="form-control">
        </div><br>
        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" rows="3"></textarea>
        </div><br>
        <button type="submit" class="btn btn-primary" id="submit">Save</button>
    </form>
    </div>
</div>
</div>
</body>
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
<script>
    var flag = true;
    $('#Service').submit(function(event) {
        flag = true;
        var formData = {};
        var typeData = {};
        typeData["name"] = $("#serviceType").val();
        formData["name"] = $("#serviceName").val();
        formData["type"] = typeData;
        $.ajax({
            type: "POST",
            contentType : "application/json",
            url: "/addService",
            data : JSON.stringify(formData),
            dataType : 'json',
            success: function (response) {
                console.log(response);
            },
            error: function (error) {
                console.log(error);
            }
        });
        event.preventDefault();
    });

    function getById(id){
        var serviceData = {};
        $.ajax({
            type: "GET",
            url: "/getServiceById/" + id,
            contentType : "application/json",
            success: function (response) {
                //console.log(JSON.stringify(response).replaceAll("[","{").replaceAll("]","}"));
                serviceData = JSON.parse(JSON.stringify(response).replaceAll("[","{").replaceAll("]","}"));
                //console.log(serviceData);
            },
            error: function (error) {
                console.log(error);
            }
        });
        return serviceData;
    }
    $('#subService').submit(function(event) {
        var formData = {};
        var typeData = {};
        var id = $("#ServiceSelector").find('option:selected').attr('id');
        typeData["name"] = $("#type").val();
        formData["name"] = $("#name").val();
        formData["type"] = typeData;
        //console.log(getById(id));
        $.ajax({
            type: "GET",
            url: "/getServiceById/" + id,
            contentType : "application/json",
            async : false,
            success: function (response) {
                var data = JSON.parse(JSON.stringify(response).replaceAll("[","{").replaceAll("]","}"));
                //delete data["subServices"];
                formData["service"] = response;
                console.log(formData["service"]);
                //console.log(serviceData);
            },
            error: function (error) {
                console.log(error);
            }
        });
        formData["price"] = $("#price").val();
        formData["description"] = $("#description").val();
        $.ajax({
            type: "POST",
            contentType : "application/json",
            url: "/addSubService",
            data : JSON.stringify(formData),
            dataType : 'json',
            success: function (response) {
                console.log(response);
            },
            error: function (error) {
                console.log(error);
            }
        });
        event.preventDefault();
    });

    $("#ServiceSelector").on('click', function() {
        if(flag) {
            $.ajax({
                type: "GET",
                url: "/getAllServices",
                success: function (data) {
                    $("#ServiceSelector").empty();
                    $(function () {
                        $.each(data, function (i, f) {
                            $("#ServiceSelector").append("<option id='" + f.id + "'>" + f.name + "</option>");
                        });
                    });
                }
            });
            flag = false;
        }
    });
</script>
</html>
