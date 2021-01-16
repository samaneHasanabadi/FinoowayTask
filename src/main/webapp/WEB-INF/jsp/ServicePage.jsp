<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 1/6/21
  Time: 11:29 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <meta charset="UTF-8">
</head>
<body>
<form id="Service">
    <label for="name">نام خدمت</label>
    <input name="name" id="serviceName"><br><br>
    <label for="type">نوع خدمت</label>
    <input name="type" id="serviceType"><br><br>
    <input type="submit" id="serviceSubmit" value="ثبت">
</form>

<form id="subService" method="post">
    <label for="name">نام زیر خدمت</label>
    <input name="name" id="name"><br><br>
    <label for="type">نوع زیر خدمت</label>
    <input name="type.name" id="type"><br><br>
    <label for="serviceSelector">نوع خدمت</label>
    <select id="ServiceSelector">
        <option></option>
    </select><br><br>
    <label for="price">قیمت</label>
    <input name="price" id="price"><br><br>
    <label for="description">توضیحات</label>
    <input name="description" id="description"><br><br>
    <input type="submit" id="submit" value="ثبت">
</form>

</body>
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
