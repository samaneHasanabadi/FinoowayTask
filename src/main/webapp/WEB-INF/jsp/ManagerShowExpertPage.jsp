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
<nav class="navbar navbar-inverse" style="background-color: #dddede; border-color: #dddede ">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#" style="color: #1f1f1f">Manager Page</a>
        </div>
        <ul class="nav navbar-nav">
            <li><a href="ServicePage" style="color: #1f1f1f;">Service Page</a>
            </li>
            <li class="active"><a href="ExpertPage" style="color: #1f1f1f; background-color: #6adbbb">Expert Page</a>
            </li>
            <li><a href="SearchPage" style="color: #1f1f1f">Search Page</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="/logout" style="color: #1f1f1f"><span class="glyphicon glyphicon-log-in"></span> Log out</a></li>
        </ul>
    </div>
</nav>
<div id="message" class="well well-large"
     style="display: none;justify-content: center;align-items: center;background-color: #f1d548;width: 85%;height:5%;margin-top: 1%;margin-left: 5%">
</div>
<div style="display: flex; flex-direction: row">
    <div class="vertical-menu">
        <a href="ExpertPage">Add Expert</a>
        <a href="ShowExpertPage" class="active">Show Experts</a>
    </div>
    <div style="width: 80%">
        <h4><strong>List of Experts</strong></h4>
        <button id="showAll" class="btn btn-warning"
                style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>Show All Experts
        </button>
        <button id="approveAll" class="btn btn-success"
                style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>Approve All Experts
        </button>
        <br><br>
        <table class="table table-striped" id="expertTable">
            <thead class="thead-light" style="background-color: #dddede">
            <tr>
                <th scope="col" style="display: none">Id</th>
                <th scope="col">Name</th>
                <th scope="col">Family</th>
                <th scope="col">Email</th>
                <th scope="col">Status</th>
                <th scope="col">Edit/Delete</th>
                <th scope="col">Approve</th>
                <th scope="col">See/Edit Sub Services</th>
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
                <h4 class="modal-title">Edit Expert</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form onsubmit="return validate()">
                    <div class="form-group" style="display: none">
                        <label for="id" class="col-form-label">id</label>
                        <input type="text" class="form-control" id="id">
                    </div>
                    <label for="name" class="form-label">Name</label>
                    <input type="text" class="form-control" id="name" oninput="checkName()" placeholder="Name"
                           required="true">
                    <div id="nameMessageDiv" style="color: red"></div>
                    <br>
                    <label for="family" class="form-label">Family</label>
                    <input type="text" class="form-control" id="family" oninput="checkFamily()" placeholder="Family"
                           required>
                    <div id="familyMessageDiv" style="color: red"></div>
                    <br>
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" oninput="checkEmail()"
                           placeholder="Name@exmaple.com" required>
                    <div id="emailMessageDiv" style="color: red"></div>
                    <br>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveChangesEditBtn"
                        onclick="editExpert()"
                        style="background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f" disabled>Save changes
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
                <h4 class="modal-title" id="deleteModalHeader">Delete Expert</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="deleteModalBody">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="deleteModalBtn"
                        onclick="deleteExpert()"
                        style="background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f">Delete
                </button>
            </div>
        </div>
    </div>
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
                <button class="btn btn-primary" id="addRowButton"
                        style="background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f"><i class="fa fa-plus"
                                                                                                  aria-hidden="true"
                                                                                                  style="color: #1f1f1f"></i>
                </button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveChanges"
                        style="background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f">Save changes
                </button>
            </div>
        </div>
    </div>
</div>

</body>
<script>
    $("#showAll").on('click', function () {
        $.ajax({
            type: "GET",
            url: "/getAllExperts",
            success: function (data) {
                $("#expertTable tr:gt(0)").remove();
                $(function () {
                    $.each(data, function (i, f) {
                        $("#expertTable").append("<tr id='tr" + f.id + "'><td style='display: none' class='id'>" + f.id + "</td><td class='name'>" + f.name +
                            "</td><td class='family'>" + f.family + "</td><td class='email'>" + f.email + "</td><td class='status'>" +
                            f.status + "</td><td><div class='btn-toolbar'>" +
                            "<button type=\"button\" class=\"btn btn-warning\" id='editBtn " + f.id + "' onclick='fillModal(id)' data-toggle='modal' data-target='#editServices' style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>Edit</button>" +
                            "<button type=\"button\" class=\"btn btn-danger\" id='deleteBtn " + f.id + "' onclick='fillDeleteModal(id)' data-toggle='modal' data-target='#deleteModal' style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>Delete</button></div></td>" +
                            "<td><button onclick='approveExpert(" + f.id + ", this)' id='ApproveBtn" + f.id + "' class=\"btn btn-warning\" style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>Approve</button></td>" +
                            "<td><button id='AddBtn" + f.id + "' onclick='getSubServices(" + f.id + ")' data-toggle='modal' data-target='#editSubService' class=\"btn btn-warning\" style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>Sub Services</button></td>" +
                            "</tr>");
                        if (!(f.status === "WAITING")) {
                            var id1 = "#ApproveBtn" + f.id;
                            $(id1).prop("disabled", true);
                        }
                        if (!(f.status === "APPROVED")) {
                            var id1 = "#AddBtn" + f.id;
                            $(id1).prop("disabled", true);
                        }
                    });
                });
            }
        });
    });

    var expertId;

    function fillModal($id) {
        var parts = $id.toString().split(" ");
        expertId = parts[1];
        var $row = document.getElementById($id).closest("tr"), tds = $row.cells;
        for (var i = 0; i < 4; i++) {
            var input_name = tds[i].className;
            var input_val = tds[i].innerHTML;
            $("#" + input_name).val(input_val);
        }
    }

    function fillDeleteModal(id) {
        var parts = id.toString().split(" ");
        expertId = parts[1];
        var $row = document.getElementById(id).closest("tr"), tds = $row.cells;
        var message = "Are you sure you want to delete ";
        document.getElementById("deleteModalBody").innerHTML = "";
        document.getElementById("deleteModalBody").append(message + "Expert " + tds[1].innerHTML + " " + tds[2].innerHTML + "?");
    }

    function deleteExpert() {
        $.ajax({
            type: "DELETE",
            url: "/deleteUserBydId/" + expertId,
            success: function (response) {
                showMessage(response);
            },
            error: function (error) {
                showMessage(error.responseText);
            }
        });
        var $row = document.getElementById("deleteBtn " + expertId).closest("tr");
        $row.remove();
    }

    var boolName = true;
    var boolFamily = true;
    var boolEmail = true;
    var temp = false;

    function editExpert() {
        if (validate()) {
            var formData = {};
            formData["id"] = $("#id").val();
            formData["name"] = $("#name").val();
            formData["family"] = $("#family").val();
            formData["email"] = $("#email").val();
            var $row = document.getElementById("editBtn " + $("#id").val()).closest("tr"), tds = $row.cells;
            $.ajax({
                type: "PUT",
                dataType: 'json',
                contentType: 'application/json',
                data: JSON.stringify(formData),
                url: "/editExpert/" + tds[3].innerHTML,
                success: function (response) {
                    console.log(response);
                    showMessage(response);
                    tds[1].innerHTML = $("#name").val();
                    tds[2].innerHTML = $("#family").val();
                    tds[3].innerHTML = $("#email").val();
                },
                error: function (error) {
                    console.log(error);
                    showMessage(error.responseText)
                    if (error.responseText.includes("edited")) {
                        tds[1].innerHTML = $("#name").val();
                        tds[2].innerHTML = $("#family").val();
                        tds[3].innerHTML = $("#email").val();
                    }
                }
            });
        }
    }

    function checkName() {
        $("#nameMessageDiv").hide();
        var name = {};
        name["input"] = $("#name").val();
        ajaxCall("/nameCheck", name, "#name");
        boolName = temp;
        if (!boolName) {
            $("#nameMessageDiv").show();
            $("#nameMessageDiv").html("Length must be 2-16 characters");
        }
        if (validate()) {
            $("#saveChangesEditBtn").prop("disabled", false);
        } else {
            $("#saveChangesEditBtn").prop("disabled", true);
        }
    }

    function checkFamily() {
        $("#familyMessageDiv").hide();
        var family = {};
        family["input"] = $("#family").val();
        ajaxCall("/nameCheck", family, "#family");
        boolFamily = temp;
        if (!boolFamily) {
            $("#family").focus();
            $("#familyMessageDiv").show();
            $("#familyMessageDiv").html("Length must be 2-16 characters");
        }
        if (validate()) {
            $("#saveChangesEditBtn").prop("disabled", false);
        } else {
            $("#saveChangesEditBtn").prop("disabled", true);
        }
    }

    function checkEmail() {
        var email = {};
        email["input"] = $("#email").val();
        ajaxCall("/emailCheck", email, "#email");
        var $row = document.getElementById("editBtn " + $("#id").val()).closest("tr"), tds = $row.cells;
        var oldEmail = tds[3].innerHTML;
        if (temp) {
            emailAjaxCall("/checkEditEmailUniqueness/" + oldEmail, email)
        } else {
            $("#emailMessageDiv").html("email format is wrong!");
        }
        boolEmail = temp;
        if (validate()) {
            $("#saveChangesEditBtn").prop("disabled", false);
        } else {
            $("#saveChangesEditBtn").prop("disabled", true);
        }
    }

    function ajaxCall(url, input, id) {
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: url,
            data: JSON.stringify(input),
            dataType: 'json',
            async: false,
            success: function (data) {
                if (!data) {
                    temp = false;
                    $(id).css("border-color", "red");
                } else {
                    $(id).css("border-color", '#dddede');
                    temp = true;
                }
            }
        });
    }

    function emailAjaxCall(url, input) {
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: url,
            data: JSON.stringify(input),
            dataType: 'json',
            async: false,
            success: function () {
                $("#emailMessageDiv").hide();
                temp = true;
            },
            error: function (error) {
                if (error.responseText.includes("not")) {
                    $("#emailMessageDiv").hide();
                    temp = true;
                } else {
                    temp = false;
                    $("#email").focus();
                    $("#emailMessageDiv").show();
                    if (!error.responseText.includes("good")) {
                        $("#emailMessageDiv").html((error.responseText) ||
                            "Some Error Occurred");
                    } else {
                        $("#emailMessageDiv").hide();
                        temp = true;
                    }
                }

            }
        });
    }

    function showMessage(response) {
        $("#message").html("<span><h4>" + response + "</h4></span>");
        $("#message").css('display', 'flex');
        hideMessage();
    }

    function hideMessage() {
        setTimeout(function () {
            $('#message').fadeOut('fast');
        }, 7000);
    }

    function validate() {
        if (boolEmail && boolFamily && boolName) {
            return true;
        }
        if (!boolName) {
            //$("#name").focus();
            return false;
        } else if (!boolFamily) {
            return false;
        } else if (!boolEmail) {
            return false;
        }
        return false;
    }

    function approveExpert(ExpertId, button) {
        var tds = button.closest("tr").cells;
        var expert = {};
        expert["id"] = ExpertId;
        for (var i = 0; i < tds.length - 2; i++) {
            expert[tds[i].className] = tds[i].innerHTML;
        }
        $.ajax({
            url: '/approveExpert/' + ExpertId,
            type: "PUT",
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(expert),
            success: function (result) {
                console.log(result);
                var id1 = "#AddBtn" + ExpertId;
                $(id1).prop("disabled", false);
            },
            error: function (xhr, resp, text) {
                console.log(xhr, resp, text);
            }
        });
        tds[4].innerHTML = "";
        tds[4].innerHTML = "APPROVED";
    };

    var ExpertId;

    $("#approveAll").click(function () {
        $.ajax({
            type: "GET",
            url: "/approveAllWaitingExperts",
            success: function () {
                $(function () {
                    var rows = $('#expertTable > tbody > tr');
                    for (var i = 1; i < rows.length; i++) {
                        var tds = rows[i].cells;
                        if (tds[4].innerHTML === "WAITING") {
                            tds[4].innerHTML = "";
                            tds[4].innerHTML = "APPROVED";
                            var id1 = "#AddBtn" + tds[0].innerHTML;
                            $(id1).prop("disabled", false);
                        }
                    }
                });
            }
        });
    });

    function getSubServices(expertId) {
        $("#expertId").val(expertId);
        ExpertId = expertId;
        $.ajax({
            type: "GET",
            url: "/getSubServicesOfExpert/" + expertId,
            success: function (data) {
                $(function () {
                    $("#subServicesTable tr:gt(0)").remove();
                    $.each(data, function (i, f) {
                        addRow();
                        var selectorId = "serviceSelector" + count;
                        getServiceSelectorBySelectedOption(selectorId, f.service.name);
                        getSubServicesOfServiceBySelectedOption(selectorId, f.service.id, f.name);
                    });
                });
            }
        });
    }

    function addRow() {
        count = count + 1;
        $("#subServicesTable").append("<tr>" +
            "<td colspan='2'>" +
            "<button id=\"minusButton" + count + "\" " +
            "onclick='removeSubService(\"minusButton" + count + "\")' " +
            "class=\"btn btn-primary\" style=\"background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f\"><i class=\"fa fa-minus\" style=\"color: #1f1f1f\"></i>" +
            "</button>" +
            "</td>" +
            "<td colspan='4'>" +
            "<div id=\"div" + count + "\">" +
            "<select id=\"serviceSelector" + count + "\" " +
            "onclick='getServiceSelector(id)' " +
            "onchange='getSubServicesOfService(id)' " +
            "class=\"form-select serviceSelector\">" +
            "</select>" +
            "</div>" +
            "</td>" +
            "<td colspan='6'>" +
            "<div id=\"divSub" + count + "\">" +
            "<select id=\"subServiceSelector" + count + "\" class=\"form-select\">" +
            "</select>" +
            "</div>" +
            "</td></tr>");
    }

    var count = 0;
    $("#addRowButton").click(function () {
        addRow();
    });

    function getServiceSelectorBySelectedOption(id, selected) {
        $.ajax({
            type: "GET",
            url: "/getAllServices",
            success: function (data) {
                var newId = "#" + id;
                $(newId).empty();
                $(function () {
                    $.each(data, function (i, f) {
                        if (f.name === selected) {
                            $(newId).append("<option id='" + f.id + "' value='" + f.name + "' selected>" +
                                f.name + "</option>");
                        } else {
                            $(newId).append("<option id='" + f.id + "' value='" + f.name + "'>" +
                                f.name + "</option>");
                        }
                    });
                });
            }
        });
    };

    function getServiceSelector(id) {
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

    function getSubServicesOfServiceBySelectedOption(selectorId, serviceId, selected) {
        var parts = selectorId.toString().split("serviceSelector");
        var subServiceSelectorId = "#subServiceSelector" + parts[1];
        $.ajax({
            type: "GET",
            url: "/getSubServicesOfService/" + serviceId,
            success: function (data) {
                $(function () {
                    $(subServiceSelectorId).empty();
                    $.each(data, function (i, f) {
                        if (f.name === selected) {
                            $(subServiceSelectorId).append("<option id='" + f.id + "' value='" +
                                f.name + "' selected>" + f.name + "</option>");
                        } else {
                            $(subServiceSelectorId).append("<option id='" + f.id + "' value='" +
                                f.name + "'>" + f.name + "</option>");
                        }
                    });
                });
            }
        });
    }

    function getSubServicesOfService(selectorId) {
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
                        $(subServiceSelectorId).append("<option id='" + f.id + "' value='" +
                            f.name + "'>" + f.name + "</option>");
                    });
                });
            }
        });
    }

    function removeSubService(btnId) {
        var expertId = $("#expertId").val();
        var parts = btnId.toString().split("minusButton");
        var selectorId = "#subServiceSelector" + parts[1];
        var subServiceId = $('option:selected', $(selectorId).options).attr('id');
        $.ajax({
            type: "GET",
            url: "/removeExpertOfSubService/" + expertId + "/" + subServiceId,
            success: function () {
                $(function () {
                    $(selectorId).closest("tr").remove();
                });
            }
        });
        var rows = $('#subServicesTable > tbody > tr');
        var expertId = $("#expertId").val();
        var text = "";
        for (var i = 1; i < rows.length; i++) {
            var tds = rows[i].cells;
            var child2 = tds[tds.length - 1].children;
            text = text + $('option:selected', child2).val() + " - ";
        }
        var cellId = "#tdSubService" + expertId;
        var td = $(cellId);
        td.html("");
        td.html(text);
    }

    $("#saveChanges").click(function () {
        var rows = $('#subServicesTable > tbody > tr');
        var expertId = $("#expertId").val();
        var text = "";
        $.ajax({
            type: "GET",
            url: "/clearSubServiceListOfExpert/" + expertId,
            success: function () {
                $(function () {
                });
            }
        });
        for (var i = 1; i < rows.length; i++) {
            var tds = rows[i].cells;
            var child2 = tds[tds.length - 1].children;
            text = text + $('option:selected', child2).val() + " - ";
            var subServiceId = $('option:selected', child2).attr('id');
            $.ajax({
                type: "GET",
                url: "/addExpertToSubService/" + expertId + "/" + subServiceId,
                success: function () {

                }
            });
        }
        showMessage("Sub Services Are Saved Successfully!");
        var cellId = "#tdSubService" + expertId;
        var td = $(cellId);
        td.html("");
        td.html(text);
    });
</script>
<style>
    .vertical-menu {
        width: 20%;
        background: url("/resources/image/878.png");
        background-repeat: no-repeat;
        background-position: center;
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
</html>
