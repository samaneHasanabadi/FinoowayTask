<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 1/7/21
  Time: 12:05 PM
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <!--link rel="stylesheet" href="CssConfig.css"-->
    <title>title</title>
</head>
<body>
<div>
    <h3>Add Expert</h3>
<form id="addExpert" method="post">
    <div style="display: none">
    <label for="id">id</label>
    <input type="text" name="id" id="id">
    </div>
    <label for="name">name</label>
    <input type="text" name="name" id="name">
    <label for="family">family</label>
    <input type="text" name="family" id="family">
    <label for="email">email</label>
    <input type="email" name="email" id="email">
    <label for="password">password</label>
    <input type="password" name="password" id="password">
    <input type="submit" id="submit" value="Add Expert">
</form>
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
<div>
    <h3>List of Experts</h3>
    <button id="showAll">Show All Experts</button>
    <button id="approveAll">Approve All Experts</button>
    <table id="expertTable">
        <tr>
            <th style="display: none">Id</th>
            <th>Name</th>
            <th>Family</th>
            <th>Email</th>
            <th>Status</th>
            <th>Sub Services</th>
            <th>Edit</th>
        </tr>
    </table>
</div>
<!-- Modal -->
<div class="modal fade" id="editSubService" tabindex="-1" aria-labelledby="edit" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exampleModalLabel">Add or Remove Sub Services</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div>
                    <input type="text" id="expertId" style="display: none">
                    <table id="subServicesTable">
                        <tr>
                            <th colspan="2">Remove</th>
                            <th colspan="4">Service</th>
                            <th colspan="6">SubService</th>
                        </tr>
                    </table>
                </div>
                <button class="btn btn-primary" id="addRowButton"><i class="fa fa-plus" aria-hidden="true" style="color: white"></i></button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveChanges" >Save changes</button>
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
    $("#showAll").on('click', function() {
        $.ajax({
            type: "GET",
            url: "/getAllExperts",
            success: function (data) {
                $("#expertTable tr:gt(0)").remove();
                $(function () {
                    $.each(data, function (i, f) {
                        $("#expertTable").append("<tr id='tr"+f.id+"'><td style='display: none' class='id'>"+f.id+"</td><td class='name'>" + f.name +
                            "</td><td class='family'>"+f.family+"</td><td class='username'>"+f.username+"</td><td class='status'>"+
                            f.status +"</td><td id='tdSubService"+f.id+"' class='subServices' >"+getOfArrays(f.subServices)+"</td><td><button id='AddBtn"+f.id+"' onclick='getSubServices("+f.id+")' data-toggle='modal' data-target='#editSubService'>Add Sub Service" +
                            "</button><button class='approve' onclick='approveExpert("+f.id+", this)' id='ApproveBtn"+f.id+"'>Approve</button></td></tr>");
                        if(!(f.status === "WAITING")){
                            var id1 = "#ApproveBtn" + f.id;
                            $(id1).prop("disabled",true);
                        }
                    });
                });
            }
        });
    });
    function getOfArrays(array){
        var text = "";
        for(var i = 0; i < array.length; i++){
            text = text + array[i].name + "-";
        }
        return text;
    }
    function approveExpert (ExpertId, button){
       var tds = button.closest("tr").cells;
       var expert = {};
       expert["id"] = ExpertId;
       for(var i = 0; i < tds.length - 2; i++){
           expert[tds[i].className] = tds[i].innerHTML;
       }
       $.ajax({
            url: '/approveExpert/' + ExpertId,
            type : "PUT",
            dataType : 'json',
            contentType: 'application/json',
            data: JSON.stringify(expert),
            success : function(result) {
                console.log(result);
            },
            error: function(xhr, resp, text) {
                console.log(xhr, resp, text);
            }
       });
        tds[4].innerHTML = "";
        tds[4].innerHTML = "APPROVED";
    };

    var ExpertId;

    $("#approveAll").click(function (){
        $.ajax({
            type: "GET",
            url: "/approveAllWaitingExperts",
            success: function () {
                $(function () {
                    var rows = $('#expertTable > tbody > tr');
                    for(var i =1; i <rows.length; i++){
                        var tds = rows[i].cells;
                        if(tds[4].innerHTML === "WAITING"){
                            tds[4].innerHTML = "";
                            tds[4].innerHTML = "APPROVED";
                        }
                    }
                });
            }
        });
    });

    function getSubServices(expertId){
        $("#expertId").val(expertId);
        ExpertId = expertId;
        $.ajax({
            type: "GET",
            url: "/getSubServicesOfExpert/"+ expertId,
            success: function (data) {
                $(function () {
                    $("#subServicesTable tr:gt(0)").remove();
                    $.each(data, function (i, f) {
                        addRow();
                        var selectorId = "serviceSelector"+count;
                        getServiceSelectorBySelectedOption(selectorId, f.service.name);
                        getSubServicesOfServiceBySelectedOption(selectorId,f.service.id, f.name);
                    });
                });
            }
        });
    }
    function addRow (){
        count = count + 1;
        $("#subServicesTable").append("<tr>" +
            "<td colspan='2'>" +
            "<button id=\"minusButton"+count+"\" " +
            "onclick='removeSubService(\"minusButton"+count+"\")' " +
            "class=\"btn btn-primary\"><i class=\"fa fa-minus\" style=\"color: white\"></i>" +
            "</button>" +
            "</td>" +
            "<td colspan='4'>" +
            "<div id=\"div"+count+"\">"+
            "<select id=\"serviceSelector"+count+"\" " +
            "onclick='getServiceSelector(id)' " +
            "onchange='getSubServicesOfService(id)' " +
            "class=\"form-select serviceSelector\">" +
            "</select>" +
            "</div>"+
            "</td>" +
            "<td colspan='6'>" +
            "<div id=\"divSub"+count+"\">"+
            "<select id=\"subServiceSelector"+count+"\" class=\"form-select\">" +
            "</select>" +
            "</div>"+
            "</td></tr>");
    }
    var count = 0;
    $("#addRowButton").click(function (){
        addRow();
    });
    function getServiceSelectorBySelectedOption (id, selected) {
        $.ajax({
            type: "GET",
            url: "/getAllServices",
            success: function (data) {
                var newId = "#" + id;
                $(newId).empty();
                $(function () {
                    $.each(data, function (i, f) {
                        if(f.name === selected) {
                            $(newId).append("<option id='" + f.id + "' value='" + f.name + "' selected>" +
                                f.name + "</option>");
                        }else {
                            $(newId).append("<option id='" + f.id + "' value='" + f.name + "'>" +
                                f.name + "</option>");
                        }
                    });
                });
            }
        });
    };
    function getServiceSelector (id) {
        $.ajax({
            type: "GET",
            url: "/getAllServices",
            success: function (data) {
                var newId = "#" + id;
                $(newId).empty();
                $(function () {
                    $.each(data, function (i, f) {
                        $(newId).append("<option id='" + f.id + "' value='" + f.name + "'>" +
                            f.name + "</option>");
                    });
                });
            }
        });
    };

    function getSubServicesOfServiceBySelectedOption(selectorId, serviceId ,selected){
        var parts = selectorId.toString().split("serviceSelector");
        var subServiceSelectorId = "#subServiceSelector" + parts[1];
        $.ajax({
            type: "GET",
            url: "/getSubServicesOfService/" + serviceId,
            success: function (data) {
                $(function () {
                    $(subServiceSelectorId).empty();
                    $.each(data, function (i, f) {
                        if(f.name === selected){
                            $(subServiceSelectorId).append("<option id='" + f.id + "' value='" +
                                f.name + "' selected>" + f.name + "</option>");
                        }else {
                            $(subServiceSelectorId).append("<option id='" + f.id + "' value='" +
                                f.name + "'>" + f.name + "</option>");
                        }
                    });
                });
            }
        });
    }

    function getSubServicesOfService(selectorId){
        var parts = selectorId.toString().split("serviceSelector");
        var subServiceSelectorId = "#subServiceSelector" + parts[1];
        selectorId = "#" + selectorId;
        var serviceId = $('option:selected', $(selectorId).options).attr('id');
        $.ajax({
            type: "GET",
            url: "/getSubServicesOfService/" + serviceId,
            success: function (data) {
                $(function () {
                    $(subServiceSelectorId).empty();
                    $.each(data, function (i, f) {
                        $(subServiceSelectorId).append("<option id='" + f.id + "' value='"+
                            f.name+"'>" + f.name + "</option>");
                    });
                });
            }
        });
    }

    function removeSubService(btnId){
        var expertId = $("#expertId").val();
        var parts = btnId.toString().split("minusButton");
        var selectorId = "#subServiceSelector" + parts[1];
        var subServiceId = $('option:selected', $(selectorId).options).attr('id');
        $.ajax({
            type: "GET",
            url: "/removeExpertOfSubService/" +expertId +"/"+ subServiceId,
            success: function () {
                $(function () {
                    $(selectorId).closest("tr").remove();
                });
            }
        });
        var rows = $('#subServicesTable > tbody > tr');
        var expertId = $("#expertId").val();
        var text = "";
        for(var i =1; i <rows.length; i++){
            var tds = rows[i].cells;
            var child2 = tds[tds.length - 1].children;
            text = text + $('option:selected', child2).val() + " - ";
        }
        var cellId = "#tdSubService" + expertId;
        var td = $(cellId);
        td.html("");
        td.html(text);
    }
    $("#saveChanges").click(function (){
        var rows = $('#subServicesTable > tbody > tr');
        var expertId = $("#expertId").val();
        var text = "";
        $.ajax({
            type: "GET",
            url: "/clearSubServiceListOfExpert/" +expertId,
            success: function () {
                $(function () {
                });
            }
        });
        for(var i =1; i <rows.length; i++){
            var tds = rows[i].cells;
            var child2 = tds[tds.length - 1].children;
            text = text + $('option:selected', child2).val() + " - ";
            var subServiceId = $('option:selected', child2).attr('id');
            $.ajax({
                type: "GET",
                url: "/addExpertToSubService/" +expertId +"/"+ subServiceId,
                success: function () {
                    $(function () {
                    });
                }
            });
        }
        var cellId = "#tdSubService" + expertId;
        var td = $(cellId);
        td.html("");
        td.html(text);
    });
</script>

</html>
