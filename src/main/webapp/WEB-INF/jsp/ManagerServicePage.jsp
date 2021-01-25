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
<nav class="navbar navbar-inverse" style="background-color: #dddede; border-color: #dddede ">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#" style="color: #1f1f1f">Manager Page</a>
        </div>
        <ul class="nav navbar-nav">
            <li class="active"><a href="ServicePage" style="color: #1f1f1f; background-color: #6adbbb">Service Page</a>
            </li>
            <li><a href="ExpertPage" style="color: #1f1f1f">Expert Page</a></li>
            <li><a href="SearchPage" style="color: #1f1f1f">Search Page</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="#" style="color: #1f1f1f"><span class="glyphicon glyphicon-log-in"></span> Log out</a></li>
        </ul>
    </div>
</nav>
<div id="message"
     style="display: none;justify-content: center;align-items: center;background-color: #dddede;border-color: #868787;width: 85%;height:10%;margin-top: 1%;margin-left: 5%">
</div>
<div style="display: flex; flex-direction: row; height: 89%">
    <div class="vertical-menu">
        <a href="ServicePage" class="active">Add Service</a>
        <a href="ShowServicePage">Show Services</a>
    </div>
    <div class="well well-large" style=" display: flex; flex-direction: row; width: 80%">
        <div class="well well-large" style="width: 40%;margin-left: 3%;margin-right: 3%">
            <h4><strong>Add Service</strong></h4>
            <form id="Service">
                <div class="mb-3">
                    <label for="serviceName" class="form-label">Service Name</label>
                    <input name="name" class="form-control" id="serviceName" oninput="checkName()" required>
                    <div id="sNameMessageDiv" style="color: red"></div>
                </div>
                <br>
                <div class="mb-3">
                    <label for="serviceType" class="form-label">Service Type</label>
                    <input name="type" class="form-control" id="serviceType" oninput="checkServiceType()" required>
                    <div id="sTypeMessageDiv" style="color: red"></div>
                </div>
                <br>
                <div>
                    <button type="submit" class="btn btn-primary"
                            style="background-color: #6adbbb; color: #1f1f1f; border-color: #6adbbb" id="serviceSubmit">
                        Save
                    </button>
                </div>
            </form>
        </div>
        <div style="width: 4%">
        </div>
        <div class="well well-large" style="width: 40%; margin-left: 3%;margin-right: 3%">
            <h4><strong>Add Sub Service</strong></h4>
            <form id="subService" method="post">
                <div class="mb-3">
                    <label for="name" class="form-label">Sub Service Name</label>
                    <input name="name" id="name" class="form-control" oninput="checkSubName()" required>
                    <div id="sbNameMessageDiv" style="color: red"></div>
                </div>
                <br>
                <div class="mb-3">
                    <label for="type" class="form-label">Sub Service Type</label>
                    <input name="type.name" id="type" class="form-control" oninput="checkSubType()" required>
                    <div id="sbTypeMessageDiv" style="color: red"></div>
                </div>
                <br>
                <div class="mb-3">
                    <label for="serviceSelector" class="form-label">Service</label>
                    <select id="ServiceSelector" class="form-select" aria-label="Default select example" onchange="checkSubServiceService()" required>
                        <option value=""></option>
                    </select>
                </div>
                <br>
                <div class="mb-3">
                    <label for="price" class="form-label">Price</label>
                    <input name="price" type="number" id="price" class="form-control" oninput="checkSubPrice()"
                           required>
                    <div id="sbPriceMessageDiv" style="color: red"></div>
                </div>
                <br>
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea class="form-control" id="description" rows="3" required></textarea>
                    <div id="sbDescriptionMessageDiv" style="color: red"></div>
                </div>
                <br>
                <button type="submit" class="btn btn-primary"
                        style="background-color: #6adbbb; color: #1f1f1f; border-color: #6adbbb" id="submit">Save
                </button>
            </form>
        </div>
    </div>
</div>
</body>
<style>
    .vertical-menu {
        width: 20%;
        background-image: url("878.png");
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
        background-color: #6adbbb;
    }
</style>
<script>
    var flag = true;
    var boolServiceName = false;
    var boolServiceType = false;
    var boolSubServiceName = false;
    var boolSubServiceType = false;
    var boolSubServiceService = false;
    var boolSubServicePrice = false;

    var temp = false;

    function checkSubName() {
        $("#sbNameMessageDiv").hide();
        var name = {};
        name["input"] = $("#name").val();
        name["inputName"] = "name";
        ajaxCall("/checkSubServiceFiledLength", name, "#name", "#sbNameMessageDiv");
        boolSubServiceName = temp;
    }

    function checkSubType() {
        $("#sbTypeMessageDiv").hide();
        var name = {};
        name["input"] = $("#type").val();
        name["inputName"] = "type";
        ajaxCall("/checkSubServiceFiledLength", name, "#type", "#sbTypeMessageDiv");
        boolSubServiceType = temp;
    }

    function checkSubPrice() {
        $("#sbPriceMessageDiv").hide();
        var name = {};
        name["input"] = $("#price").val();
        name["inputName"] = "price";
        ajaxCall("/checkSubServicePrice", name, "#price", "#sbPriceMessageDiv");
        boolSubServicePrice = temp;
    }

    function checkSubServiceService() {
        if ($("#ServiceSelector").val() === "") {
            boolSubServiceService = false;
        } else {
            boolSubServiceService = true;
        }
    }

    function checkSubServiceNameUniqueness() {
        $("#sbNameMessageDiv").hide();
        var name = {};
        name["input"] = $("#name").val();
        ajaxCall("/checkSubServiceNameUniqueness", name, "#name", "#sbNameMessageDiv");
        boolSubServiceName = temp;
    }

    function checkName() {
        $("#sNameMessageDiv").hide();
        var name = {};
        name["input"] = $("#serviceName").val();
        name["inputName"] = "name";
        ajaxCall("/checkServiceFiledLength", name, "#serviceName", "#sNameMessageDiv");
        boolServiceName = temp;
    }

    function checkServiceNameUniqueness() {
        $("#sNameMessageDiv").hide();
        var name = {};
        name["input"] = $("#serviceName").val();
        ajaxCall("/checkServiceNameUniqueness", name, "#serviceName", "#sNameMessageDiv");
        boolServiceName = temp;
    }

    function checkServiceType() {
        $("#sTypeMessageDiv").hide();
        var name = {};
        name["input"] = $("#serviceType").val();
        name["inputName"] = "type";
        ajaxCall("/checkServiceFiledLength", name, "#serviceType", "#sTypeMessageDiv");
        boolServiceType = temp;
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

    $('#Service').submit(function (event) {
        if (boolServiceName && boolServiceType) {
            checkServiceNameUniqueness();
            if (boolServiceName) {
                flag = true;
                var formData = {};
                var typeData = {};
                typeData["name"] = $("#serviceType").val();
                formData["name"] = $("#serviceName").val();
                formData["type"] = typeData;
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "/addService",
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
        event.preventDefault();
    });

    function showSuccessMessage(response) {
        if (response.toString().includes("added")) {
            document.getElementById("Service").reset();
        }
        $("#message").html("<span><h4>" + response + "</h4></span>");
        $("#message").css('display', 'flex');
        hideMessage();
    }

    function showSubSuccessMessage(response) {
        if (response.toString().includes("added")) {
            document.getElementById("subService").reset();
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

    function getById(id) {
        var serviceData = {};
        $.ajax({
            type: "GET",
            url: "/getServiceById/" + id,
            contentType: "application/json",
            success: function (response) {
                //console.log(JSON.stringify(response).replaceAll("[","{").replaceAll("]","}"));
                serviceData = JSON.parse(JSON.stringify(response).replaceAll("[", "{").replaceAll("]", "}"));
                //console.log(serviceData);
            },
            error: function (error) {
                console.log(error);
            }
        });
        return serviceData;
    }

    $('#subService').submit(function (event) {
        if (boolSubServiceName && boolSubServiceType && boolSubServicePrice && boolSubServiceService) {
            checkSubServiceNameUniqueness();
            if (boolSubServiceName) {
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
                    contentType: "application/json",
                    async: false,
                    success: function (response) {
                        var data = JSON.parse(JSON.stringify(response).replaceAll("[", "{").replaceAll("]", "}"));
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
                    contentType: "application/json",
                    url: "/addSubService",
                    data: JSON.stringify(formData),
                    dataType: 'json',
                    success: function (response) {
                        showSubSuccessMessage(response);
                    },
                    error: function (error) {
                        showSubSuccessMessage(error.responseText)
                    }
                });
            }
        }
        event.preventDefault();
    });

    $("#ServiceSelector").on('click', function () {
        if (flag) {
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
