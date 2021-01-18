<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 1/10/21
  Time: 6:02 PM
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
            <li class="active"><a href="ManagerServicePage">Service Page</a></li>
            <li><a href="ManagerExpertPage">Expert Page</a></li>
            <li><a href="ManagerSearchPage">Search Page</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Log out</a></li>
        </ul>
    </div>
</nav>
<div style="display: flex; flex-direction: row">
    <div class="vertical-menu">
        <a href="ManagerServicePage">Add Service</a>
        <a href="ManagerShowServicePage" class="active">Show Services</a>
    </div>
    <div style="background-color: blueviolet;width: 80%">
        <button type="button" class="btn btn-primary" id="showServiceBtn">Show Services</button>
        <h3>List Of Services</h3>
        <table class="table table-striped" id="serviceTable">
            <thead class="thead-light">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Service</th>
                <th scope="col">Service type</th>
                <th scope="col">Sub Service</th>
                <th scope="col">Type</th>
                <th scope="col">Price</th>
                <th scope="col">Description</th>
                <th scope="col">Edit/Delete</th>
                <th scope="col">Select</th>
                <th scope="col" style="display: none">Experts</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="editServices" tabindex="-1" aria-labelledby="edit" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exampleModalLabel">Add or Remove Sub Services</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="service-name" class="col-form-label">Service</label>
                        <input type="text" class="form-control" id="service-name">
                    </div>
                    <div class="form-group">
                        <label for="service-type" class="col-form-label">Service Type</label>
                        <input type="text" class="form-control" id="service-type">
                    </div>
                    <div class="form-group">
                        <label for="subService-name" class="col-form-label">Sub Service</label>
                        <input type="text" class="form-control" id="subService-name">
                    </div>
                    <div class="form-group">
                        <label for="subService-Type" class="col-form-label">Type</label>
                        <input type="text" class="form-control" id="subService-type">
                    </div>
                    <div class="form-group">
                        <label for="subService-price" class="col-form-label">Price</label>
                        <input type="text" class="form-control" id="subService-price">
                    </div>
                    <div class="form-group">
                        <label for="subService-description" class="col-form-label">Description</label>
                        <input type="text" class="form-control" id="subService-description">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveChanges" onclick="editService(); editSubService()" >Save changes</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="edit" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="deleteModalHeader">Add or Remove Sub Services</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="deleteModalBody">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="deleteModalBtn" onclick="deleteSubService()" >Delete</button>
            </div>
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
        background-color: #4CAF50; /* Add a green color to the "active/current" link */
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

    $("#showServiceBtn").on('click', function() {
        $.ajax({
            type: "GET",
            url: "/getAllServices",
            async: true,
            success: function (data) {
                $("#serviceTable tr:gt(0)").remove();
                $(function () {
                    $.each(data, function (i, f) {
                        $.ajax({
                            type: "GET",
                            url: "/getSubServicesOfService/" + f.id,
                            async: true,
                            success: function (data2) {
                                var row = "";
                                row = row + "<tr><th scope=\"row\" rowspan='"+data2.length+"'>"+(i+1)+"</th><td rowspan='"+data2.length+"' class='service-name'>"+f.name+"</td><td rowspan='"+data2.length+"' class='service-type'>"+f.type.name+"</td>";
                                $(function () {
                                    if(data2.length === 0){
                                        row = row + "<td class='subService-name'></td><td class='subService-type'></td><td class='subService-price'></td><td class='subService-description'></td>" +
                                            "<td><button id='editBtn "+f.id+" 0' type=\"button\" onclick='fillModal(id)' class=\"btn btn-warning\" data-toggle='modal' data-target='#editServices'>Edit</button>" +
                                            "<button id='deleteBtn "+f.id+" 0' type=\"button\" onclick='fillDeleteModal(id)' class=\"btn btn-danger\"  data-toggle='modal' data-target='#deleteModal'>Delete</button></td><td><div class=\"form-check\">" +
                                            "<input class=\"form-check-input\" type=\"checkbox\" value=\"\" id=\"checkBox "+f.id+" 0\" onclick='showExperts(id)'></div></td><td style=\"display: none\"></td></tr>";
                                    }
                                    $.each(data2, function (i2, f2) {
                                        if(i2 !== 0) {
                                            row = row + "<tr>";
                                        }
                                        row = row + "<td class='subService-name'>" + f2.name + "</td><td class='subService-type'>"+f2.type.name+"</td><td class='subService-price'>"+f2.price+"</td><td class='subService-description'>"+f2.description+"</td><td>" +
                                            "<button type=\"button\" class=\"btn btn-warning\" id='editBtn "+f.id+" "+f2.id+"' onclick='fillModal(id)' data-toggle='modal' data-target='#editServices'>Edit</button>" +
                                            "<button type=\"button\" class=\"btn btn-danger\" id='deleteBtn "+f.id+" "+f2.id+"' onclick='fillDeleteModal(id)' data-toggle='modal' data-target='#deleteModal'>Delete</button></td><td><div class=\"form-check\">" +
                                            "<input class=\"form-check-input\" type=\"checkbox\" value=\"\" id=\"checkBox "+f.id+" "+f2.id+"\" onclick='showExperts(id)'></div></td><td style=\"display: none\"></td></tr>";
                                    });
                                    $("#serviceTable").append(row);
                                });
                            }
                        });
                    });
                });
            }
        });
    });
    var serviceId;
    var subServiceId;
    function editSubService(){
        if(subServiceId !== "0") {
            var formData = {};
            var typeData = {};
            typeData["name"] = $("#subService-type").val();
            formData["id"] = subServiceId;
            formData["name"] = $("#subService-name").val();
            formData["type"] = typeData;
            formData["price"] = $("#subService-price").val();
            formData["description"] = $("#subService-description").val();
            var $row = document.getElementById("editBtn "+serviceId + " " + subServiceId).closest("tr"), tds = $row.cells;
            tds[3].innerHTML = $("#subService-name").val();
            tds[4].innerHTML = $("#subService-type").val();
            tds[5].innerHTML = $("#subService-price").val();
            tds[6].innerHTML = $("#subService-description").val();
            $.ajax({
                type: "PUT",
                dataType: 'json',
                contentType: 'application/json',
                data: JSON.stringify(formData),
                url: "/editService",
                success: function (response) {
                    console.log(response);
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }
    }
    function editService(){
        var formData = {};
        var typeData = {};
        typeData["name"] = $("#service-type").val();
        formData["id"] = serviceId;
        formData["name"] = $("#service-name").val();
        formData["type"] = typeData;
        var $row = document.getElementById("editBtn "+serviceId + " " + subServiceId).closest("tr"), tds = $row.cells;
        tds[1].innerHTML = $("#service-name").val();
        tds[2].innerHTML = $("#service-type").val();
        $.ajax({
            type: "PUT",
            dataType : 'json',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            url: "/editSubService",
            success: function (response) {
                console.log(response);
            },
            error: function (error) {
                console.log(error);
            }
        });
    }

    function deleteSubService(){
        var $row = document.getElementById("deleteBtn "+serviceId + " " + subServiceId).closest("tr");
        $row.remove();
        if(subServiceId === "0"){
            $.ajax({
                type: "DELETE",
                url: "/deleteService/" + serviceId,
                success: function (response) {
                    console.log(response);
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }else {
            $.ajax({
                type: "DELETE",
                url: "/deleteSubService/" + subServiceId,
                success: function (response) {
                    console.log(response);
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }
    }

    function fillModal($id) {
        var parts = $id.toString().split(" ");
        serviceId = parts[1];
        subServiceId = parts[2];
        var $row = document.getElementById($id).closest("tr"), tds = $row.cells;
        for (var i = 1; i < tds.length - 1; i++) {
            var input_name = tds[i].className;
            var input_val = tds[i].innerHTML;
            document.getElementById(input_name).value = input_val;
        }
    }

    function fillDeleteModal(id){
        var parts = id.toString().split(" ");
        serviceId = parts[1];
        subServiceId = parts[2];
        var $row = document.getElementById(id).closest("tr"), tds = $row.cells;
        var message = "Are you sure you want to delete ";
        document.getElementById("deleteModalBody").innerHTML = "";
        if(subServiceId === "0"){
            document.getElementById("deleteModalBody").append(message + "Service " + tds[1].innerHTML + "?");
        }else {
            document.getElementById("deleteModalBody").append(message + "Sub Service " + tds[3].innerHTML + "?");
        }
    }

    function showExperts(id) {
        var parts = id.toString().split(" ");
        serviceId = parts[1];
        subServiceId = parts[2];
        var checkBox = document.getElementById(id);
        var $row = document.getElementById(id).closest("tr"), tds = $row.cells;
        var td = tds[9];
        if (checkBox.checked == true) {
            $("#serviceTable tr > *:nth-child(10)").show();
            $.ajax({
                type: "GET",
                contentType: 'application/json',
                url: "/getExpertsOfSubService/" + subServiceId,
                success: function (response) {
                    $.each(response, function (i, f) {
                        var div = $(addExpertToTd(f.id, f.name, f.family));
                        div.appendTo(td);
                    });
                },
                error: function (error) {
                    console.log(error);
                }
            });
            var button = $("<button class=\"btn btn-primary\" id='addBtn "+serviceId+" "+subServiceId+"' onclick='addExpertSelector(id)'><i class=\"fa fa-plus\" aria-hidden=\"true\" style=\"color: white\"></i></button>");
            button.appendTo(td);
        }
    }

    function addExpertSelector(id){
        var $row = document.getElementById(id).closest("tr"), tds = $row.cells;
        var td = tds[9];
        var parts = id.toString().split(" ");
        serviceId = parts[1];
        subServiceId = parts[2];
        var plusButton = document.getElementById(id);
        plusButton.remove();
        var div = $("<div id=\"selectorDiv "+serviceId + " "+ subServiceId+"\">"+
            "<select id=\"expertSelector "+serviceId + " "+ subServiceId+"\" " +
            "onclick='getUnUsedExperts(id)' " +
            "class=\"form-select serviceSelector\">" +
            "</select> " +
            "<button id=\"saveBtn "+serviceId + " "+ subServiceId+"\" " +
            "onclick='saveExpertToSubService(id)' " +
            "class=\"btn btn-primary\">save" +
            "</button>"+
            "</div>");
        div.appendTo(td);
    }

    function saveExpertToSubService(id){
        var $row = document.getElementById(id).closest("tr"), tds = $row.cells;
        var td = tds[9];
        var parts = id.toString().split(" ");
        serviceId = parts[1];
        subServiceId = parts[2];
        var selectorId = "expertSelector " + parts[1] + " " + parts[2];
        var divSelector = document.getElementById("selectorDiv " + parts[1] + " " + parts[2]);
        var selector = document.getElementById(selectorId);
        var expertId = $('option:selected', selector).attr('id').toString().split(" ")[1];
        var expert = $('option:selected', selector).val().toString().split(" ");
        var name = expert[0];
        var family = expert[1];
        $.ajax({
            type: "GET",
            url: "/addExpertToSubService/" +expertId +"/"+ subServiceId,
            success: function () {
                $(function () {
                    divSelector.remove();
                    $(addExpertToTd(expertId, name, family)).appendTo(td);
                    var button = $("<button class=\"btn btn-primary\" id='"+id+"' onclick='addExpertSelector(id)'><i class=\"fa fa-plus\" aria-hidden=\"true\" style=\"color: white\"></i></button>");
                    button.appendTo(td);
                });
            }
        });
    }

    function getUnUsedExperts(id){
        var parts = id.toString().split(" ");
        serviceId = parts[1];
        subServiceId = parts[2];
        $.ajax({
            type: "GET",
            url: "/getUnUsedExpertsOfSubService/" + subServiceId,
            success: function (data) {
                $(function () {
                    var subServiceSelectorId = "#" + id;
                    $(subServiceSelectorId).empty();
                    var selector = document.getElementById(id);
                    $.each(data, function (i, f) {
                        $("<option id='option " + f.id + " " +subServiceId+"' value='"+
                            f.name+" " + f.family +"'>" + f.name +" "+ f.family + "</option>").appendTo(selector);
                    });
                });
            }
        });
    }

    function removeExpertOfSubService(id){
        var parts = id.toString().split(" ");
        var expertId = parts[1];
        subServiceId = parts[2];
        $.ajax({
            type: "GET",
            url: "/removeExpertOfSubService/" +expertId +"/"+ subServiceId,
            success: function () {
                $(function () {
                    var divId = "expertDiv "+expertId+" " +subServiceId;
                    var expertDiv = document.getElementById(divId);
                    expertDiv.remove();
                });
            }
        });
    }

    function addExpertToTd(id, name, family){
        return "<div id='expertDiv "+id+" " +subServiceId+"'><button id=\"minusButton "+id+" " +subServiceId+"\" " +
            "onclick='removeExpertOfSubService(id)' " +
            "class=\"btn btn-primary\"><i class=\"fa fa-minus\" style=\"color: white\"></i></button>" +
            "<div>"+ name + " " +family+"</div></div>";

    }

</script>
</html>
