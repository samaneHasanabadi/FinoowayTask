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
<div id="message" class="well well-large"
     style="display: none;justify-content: center;align-items: center;background-color: #f1d548;width: 85%;height:10%;margin-top: 1%;margin-left: 5%">
</div>
<div style="display: flex; flex-direction: row; height: 89%">
    <div class="vertical-menu">
        <a href="ServicePage">Add Service</a>
        <a href="ShowServicePage" class="active">Show Services</a>
    </div>
    <div style="width: 80%">
        <button type="button" class="btn btn-primary" id="showServiceBtn"
                style="background-color: #6adbbb; border-color: #6adbbb; color: #1f1f1f">Show List Of Services
        </button>
        <br><br>
        <table class="table table-striped" id="serviceTable">
            <thead class="thead-light" style="background-color: #dddede">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Service</th>
                <th scope="col">Service type</th>
                <th scope="col">Sub Service</th>
                <th scope="col">Type</th>
                <th scope="col">Price</th>
                <th scope="col">Description</th>
                <th scope="col">Edit/Delete</th>
                <th scope="col">See Experts</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <li class="page-item">
                    <a class="page-link" href="#" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                        <span class="sr-only">Previous</span>
                    </a>
                </li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                        <span class="sr-only">Next</span>
                    </a>
                </li>
            </ul>
        </nav>
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
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveChanges"
                        onclick="editService(); editSubService()"
                        style="background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f">Save changes
                </button>
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
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="deleteModalBtn"
                        onclick="deleteSubService()"
                        style="background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f">Delete
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="expertModal" tabindex="-1" aria-labelledby="edit" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="expertModalHeader">Experts of Sub Service</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="expertModalBody">
                <div>
                    <table class="table table-striped" id="expertTable">
                        <thead class="thead-light" style="background-color: #dddede">
                        <tr>
                            <th scope="col">#</th>
                            <th style="display: none">id</th>
                            <th scope="col">Delete</th>
                            <th scope="col">Name</th>
                            <th scope="col">Family</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <div id="BtnPlusDiv">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveExpertModal"
                        style="background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f">Close
                </button>
            </div>
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
    var rowCount = 0;
    $("#showServiceBtn").on('click', function () {
        $.ajax({
            type: "GET",
            url: "/getAllServices",
            async: false,
            success: function (data) {
                $("#serviceTable tr:gt(0)").remove();
                $(function () {
                    var rowcount = 1;
                    $.each(data, function (i, f) {
                        $.ajax({
                            type: "GET",
                            url: "/getSubServicesOfService/" + f.id,
                            async: false,
                            success: function (data2) {
                                var row = "";
                                $(function () {
                                    if (data2.length === 0) {
                                        row = row + "<tr><th scope=\"row\">" + rowcount + "</th><td class='service-name'>" + f.name + "</td><td class='service-type'>" + f.type.name + "</td>";
                                        row = row + "<td class='subService-name'></td><td class='subService-type'></td><td class='subService-price'></td><td class='subService-description'></td>" +
                                            "<td><div class='btn-toolbar'><button id='editBtn " + f.id + " 0' type=\"button\" onclick='fillModal(id)' class=\"btn btn-warning\" data-toggle='modal' data-target='#editServices' style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>Edit</button>" +
                                            "<button id='deleteBtn " + f.id + " 0' type=\"button\" onclick='fillDeleteModal(id)' class=\"btn btn-danger\"  data-toggle='modal' data-target='#deleteModal' style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>Delete</button></div></td><td><div class=\"form-check\"></div></td><td style=\"display: none\"></td></tr>";
                                        rowcount = rowcount + 1;
                                    }
                                    $.each(data2, function (i2, f2) {
                                        row = row + "<tr><th scope=\"row\">" + rowcount + "</th><td class='service-name'>" + f.name + "</td><td class='service-type'>" + f.type.name + "</td>";
                                        row = row + "<td class='subService-name'>" + f2.name + "</td><td class='subService-type'>" + f2.type.name + "</td><td class='subService-price'>" + f2.price + "</td><td class='subService-description'>" + f2.description + "</td><td><div class='btn-toolbar'>" +
                                            "<button type=\"button\" class=\"btn btn-warning\" id='editBtn " + f.id + " " + f2.id + "' onclick='fillModal(id)' data-toggle='modal' data-target='#editServices' style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>Edit</button>" +
                                            "<button type=\"button\" class=\"btn btn-danger\" id='deleteBtn " + f.id + " " + f2.id + "' onclick='fillDeleteModal(id)' data-toggle='modal' data-target='#deleteModal' style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>Delete</button></div></td><td><div class=\"form-check\">" +
                                            "<input class=\"form-check-input\" type=\"checkbox\" value=\"\" id=\"checkBox " + f.id + " " + f2.id + "\" onclick='showExperts(id)' onchange='showModal(this)'></div></td></tr>";
                                        rowcount = rowcount + 1;
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

    function showModal(checkBox){
        if(checkBox.checked){
            $("#expertModal").modal("show");
        }
    }

    function editSubService() {
        if (subServiceId !== "0") {
            var formData = {};
            var typeData = {};
            typeData["name"] = $("#subService-type").val();
            formData["id"] = subServiceId;
            formData["name"] = $("#subService-name").val();
            formData["type"] = typeData;
            formData["price"] = $("#subService-price").val();
            formData["description"] = $("#subService-description").val();
            var $row = document.getElementById("editBtn " + serviceId + " " + subServiceId).closest("tr"),
                tds = $row.cells;
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

    function editService() {
        var formData = {};
        var typeData = {};
        typeData["name"] = $("#service-type").val();
        formData["id"] = serviceId;
        formData["name"] = $("#service-name").val();
        formData["type"] = typeData;
        var $row = document.getElementById("editBtn " + serviceId + " " + subServiceId).closest("tr"), tds = $row.cells;
        tds[1].innerHTML = $("#service-name").val();
        tds[2].innerHTML = $("#service-type").val();
        $.ajax({
            type: "PUT",
            dataType: 'json',
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

    function deleteSubService() {
        if (subServiceId === "0") {
            $.ajax({
                type: "DELETE",
                url: "/deleteService/" + serviceId,
                success: function (response) {
                },
                error: function (error) {
                }
            });
            var $row = document.getElementById("deleteBtn " + serviceId + " " + subServiceId).closest("tr");
            $row.remove();
            resetNumbers();
        } else {
            $.ajax({
                type: "DELETE",
                url: "/deleteSubService/" + subServiceId,
                success: function (response) {
                    if(!response.toString().includes("expert")){
                        var $row = document.getElementById("deleteBtn " + serviceId + " " + subServiceId).closest("tr");
                        $row.remove();
                        resetNumbers();
                    }else {
                        showDeleteMessage(response);
                    }
                },
                error: function (error) {
                    if(!error.responseText.includes("expert")){
                        var $row = document.getElementById("deleteBtn " + serviceId + " " + subServiceId).closest("tr");
                        $row.remove();
                        resetNumbers();
                    }else{
                        showDeleteMessage(error.responseText);
                    }
                }
            });
        }
    }

    function showDeleteMessage(response) {
        $("#message").html("<span><h4>" + response + "</h4></span>");
        $("#message").css('display', 'flex');
        hideMessage();
    }

    function hideMessage() {
        setTimeout(function () {
            $('#message').fadeOut('fast');
        }, 7000);
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

    function fillDeleteModal(id) {
        var parts = id.toString().split(" ");
        serviceId = parts[1];
        subServiceId = parts[2];
        var $row = document.getElementById(id).closest("tr"), tds = $row.cells;
        var message = "Are you sure you want to delete ";
        document.getElementById("deleteModalBody").innerHTML = "";
        if (subServiceId === "0") {
            document.getElementById("deleteModalBody").append(message + "Service " + tds[1].innerHTML + "?");
        } else {
            document.getElementById("deleteModalBody").append(message + "Sub Service " + tds[3].innerHTML + "?");
        }
    }

    function showExperts(id) {
        var parts = id.toString().split(" ");
        serviceId = parts[1];
        subServiceId = parts[2];
        var checkBox = document.getElementById(id);
        $("#expertTable tr:gt(0)").remove();
        if (checkBox.checked == true) {
            $("#serviceTable tr > *:nth-child(10)").show();
            $.ajax({
                type: "GET",
                contentType: 'application/json',
                url: "/getExpertsOfSubService/" + subServiceId,
                success: function (response) {
                    var row = "";
                    $.each(response, function (i, f) {
                        rowCount = rowCount + 1;
                        row = row + "<tr id='tr " + f.id + "'><td>" + (i + 1) + "</td><td style='display: none'>" + f.id + "</td><td><button id=\"minusButton " + f.id + " " + subServiceId + "\" onclick='removeExpertOfSubService(id)' " +
                            "class=\"btn btn-primary\" style='background-color: #6adbbb; border-color: #6adbbb'><i class=\"fa fa-minus\" style=\"color: #1f1f1f\"></i></button></td><td>" + f.name + "</td><td>" + f.family + "</td></tr>";
                    });
                    $("#expertTable").append(row);
                },
                error: function (error) {
                    console.log(error);
                }
            });
            var button = $("<button class=\"btn btn-primary\" id='addBtn " + serviceId + " " + subServiceId + "' onclick='addExpertSelector(id)' style='background-color: #6adbbb;border-color: #6adbbb'><i class=\"fa fa-plus\" aria-hidden=\"true\" style=\"color: #1f1f1f\"></i></button>");
            $("#BtnPlusDiv").html(button);
        }
    }

    function addExpertSelector(id) {
        var parts = id.toString().split(" ");
        serviceId = parts[1];
        subServiceId = parts[2];
        var plusButton = document.getElementById(id);
        plusButton.remove();
        var div = $("<div id=\"selectorDiv " + serviceId + " " + subServiceId + "\">" +
            "<select id=\"expertSelector " + serviceId + " " + subServiceId + "\" " +
            "onclick='getUnUsedExperts(id)' " +
            "class=\"form-select serviceSelector\">" +
            "</select> " +
            "<button id=\"saveBtn " + serviceId + " " + subServiceId + "\" " +
            "onclick='saveExpertToSubService(id)' " +
            "class=\"btn btn-primary\" style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>save" +
            "</button>" +
            "</div><br>" +
            "<button class=\"btn btn-primary\" id='addBtn " + serviceId + " " + subServiceId + "' onclick='addExpertSelector(id)' style='background-color: #6adbbb;border-color: #6adbbb'><i class=\"fa fa-plus\" aria-hidden=\"true\" style=\"color: #1f1f1f\"></i></button>");
        div.appendTo($("#BtnPlusDiv"));
    }

    function saveExpertToSubService(id) {
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
            url: "/addExpertToSubService/" + expertId + "/" + subServiceId,
            success: function () {
                $(function () {
                    divSelector.remove();
                    $(addExpertToTd(expertId, name, family)).appendTo($("#expertTable"));
                });
            }
        });
    }

    function getUnUsedExperts(id) {
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
                        $("<option id='option " + f.id + " " + subServiceId + "' value='" +
                            f.name + " " + f.family + "'>" + f.name + " " + f.family + "</option>").appendTo(selector);
                    });
                });
            }
        });
    }

    function removeExpertOfSubService(id) {
        rowCount = rowCount - 1;
        var parts = id.toString().split(" ");
        var expertId = parts[1];
        subServiceId = parts[2];
        $.ajax({
            type: "GET",
            url: "/removeExpertOfSubService/" + expertId + "/" + subServiceId,
            success: function () {
                $(function () {
                    var tr = document.getElementById(id).closest('tr');
                    tr.remove();
                    resetExpertsNumbers();
                });
            }
        });
    }

    function addExpertToTd(id, name, family) {
        rowCount = rowCount + 1;
        return "<tr id='tr " + id + "'><td>" + (rowCount) + "</td><td style='display: none'>" + id + "</td><td><button id=\"minusButton " + id + " " + subServiceId + "\" onclick='removeExpertOfSubService(id)' " +
            "class=\"btn btn-primary\" style='background-color: #6adbbb; border-color: #6adbbb'><i class=\"fa fa-minus\" style=\"color: #1f1f1f\"></i></button></td><td>" + name + "</td><td>" + family + "</td></tr>";

    }

    function resetNumbers(){
        $("table > tbody > tr").each(function (i) {
            var tds = this.cells;
            tds[0].innerHTML = (i+1);
        });
    }

    function resetExpertsNumbers(){
        $("#expertTable > tbody > tr").each(function (i) {
            var tds = this.cells;
            tds[0].innerHTML = (i+1);
        });
    }

</script>
</html>
