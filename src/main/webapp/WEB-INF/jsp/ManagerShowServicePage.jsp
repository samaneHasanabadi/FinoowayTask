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
            <li><a href="/logout" style="color: #1f1f1f"><span class="glyphicon glyphicon-log-in"></span> Log out</a></li>
        </ul>
    </div>
</nav>
<div id="message" class="well well-large"
     style="display: none;justify-content: center;align-items: center;background-color: #f1d548;width: 85%;height:5%;margin-top: 1%;margin-left: 5%">
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
            <ul class="pagination justify-content-center" id="ulPage">
            </ul>
        </nav>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="editServices" tabindex="-1" aria-labelledby="edit" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exampleModalLabel">Edit Sub Service</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="subService" method="post">
                    <div class="mb-3" style="display: none">
                        <label for="id" class="form-label">id</label>
                        <input name="name" id="id" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="subService-name" class="form-label">Sub Service Name</label>
                        <input name="name" id="subService-name" class="form-control" oninput="checkSubName()" required>
                        <div id="sbNameMessageDiv" style="color: red"></div>
                    </div>
                    <br>
                    <div class="mb-3">
                        <label for="subService-type" class="form-label">Sub Service Type</label>
                        <input name="type.name" id="subService-type" class="form-control" oninput="checkSubType()" required>
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
                        <label for="subService-price" class="form-label">Price</label>
                        <input name="price" type="number" id="subService-price" class="form-control" oninput="checkSubPrice()"
                               required>
                        <div id="sbPriceMessageDiv" style="color: red"></div>
                    </div>
                    <br>
                    <div class="mb-3">
                        <label for="subService-description" class="form-label">Description</label>
                        <textarea class="form-control" id="subService-description" rows="3" oninput="checkDescription()" required></textarea>
                        <div id="sbDescriptionMessageDiv" style="color: red"></div>
                    </div>
                    <br>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveChanges"
                        onclick="editSubService()"
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
                <h4 class="modal-title" id="deleteModalHeader">Delete Sub Service</h4>
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
        background: url("/878.png");
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
<script>

    var activeLiId = "";
    var numpages = 0;

    var boolServiceName = true;
    var boolServiceType = true;
    var boolSubServiceName = true;
    var boolSubServiceType = true;
    var boolSubServiceService = true;
    var boolSubServicePrice = true;

    var flag = true;

    var temp = false;

    function checkSubName() {
        $("#sbNameMessageDiv").hide();
        var name = {};
        name["input"] = $("#subService-name").val();
        name["inputName"] = "name";
        ajaxCall("/checkSubServiceFiledLength", name, "#subService-name", "#sbNameMessageDiv");
        boolSubServiceName = temp;
        if(temp) {
            checkSubServiceNameUniqueness();
        }
        if(validate()){
            $("#saveChanges").prop("disabled",false);
        }else {
            $("#saveChanges").prop("disabled",true);
        }
    }

    function checkSubType() {
        $("#sbTypeMessageDiv").hide();
        var name = {};
        name["input"] = $("#subService-type").val();
        name["inputName"] = "type";
        ajaxCall("/checkSubServiceFiledLength", name, "#subService-type", "#sbTypeMessageDiv");
        boolSubServiceType = temp;
        if(validate()){
            $("#saveChanges").prop("disabled",false);
        }else {
            $("#saveChanges").prop("disabled",true);
        }
    }

    function checkSubPrice() {
        $("#sbPriceMessageDiv").hide();
        var name = {};
        name["input"] = $("#subService-price").val();
        name["inputName"] = "price";
        ajaxCall("/checkSubServicePrice", name, "#subService-price", "#sbPriceMessageDiv");
        boolSubServicePrice = temp;
        if(validate()){
            $("#saveChanges").prop("disabled",false);
        }else {
            $("#saveChanges").prop("disabled",true);
        }
    }

    function checkSubServiceService() {
        if ($("#ServiceSelector").val() === "") {
            boolSubServiceService = false;
        } else {
            boolSubServiceService = true;
        }
        if(validate()){
            $("#saveChanges").prop("disabled",false);
        }else {
            $("#saveChanges").prop("disabled",true);
        }
    }

    function checkDescription(){
        if(validate()){
            $("#saveChanges").prop("disabled",false);
        }else {
            $("#saveChanges").prop("disabled",true);
        }
    }

    function checkSubServiceNameUniqueness() {
        $("#sbNameMessageDiv").hide();
        var name = {};
        name["input"] = $("#subService-name").val();
        var $row = document.getElementById("editBtn " + serviceId + " " + subServiceId).closest("tr");
        tds = $row.cells;
        var oldName = tds[3].innerHTML;
        ajaxCall("/checkSubServiceEditNameUniqueness/" + oldName, name, "#subService-name", "#sbNameMessageDiv");
        boolSubServiceName = temp;
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

    function getServiceSelector(id){
        if (flag) {
            $.ajax({
                type: "GET",
                url: "/getAllServices",
                success: function (data) {
                    $("#ServiceSelector").empty();
                    $(function () {
                        $.each(data, function (i, f) {
                            if(f.id.toString() === id) {
                                $("#ServiceSelector").append("<option id='" + f.id + "' value='" + f.id + "' selected>" + f.name + "</option>");
                            }else {
                                $("#ServiceSelector").append("<option id='" + f.id + "' value='" + f.id + "'>" + f.name + "</option>");
                            }
                        });
                    });
                }
            });
            flag = false;
        }
    };

    function addPage(numPages) {
        numpages = numPages;
        var liPrev = "";
        liPrev = "<li  class=\"page-item disabled\" id='li prev'>" +
            "<a class=\"page-link\" href=\"#\" aria-label=\"Previous\" tabindex=\"-1\" id='prev' onclick='prevPage()'>" +
            "<span aria-hidden=\"true\">&laquo;</span>" +
            "<span class=\"sr-only\">Previous</span>" +
            "</a>" +
            "</li>";
        var liNext = "";
        if (numPages < 2) {
            liNext = "<li class=\"page-item disabled\" id='li next'>" +
                "<a class=\"page-link\" href=\"#\" aria-label=\"Next\" tabindex=\"-1\" id='next' onclick='nextPage()'>" +
                "<span aria-hidden=\"true\">&raquo;</span>" +
                "<span class=\"sr-only\">Next</span>" +
                "</a>" +
                "</li>";
        } else {
            liNext = "<li class=\"page-item\" id='li next'>" +
                "<a class=\"page-link\" href=\"#\" aria-label=\"Next\" id='next' onclick='nextPage()'>" +
                "<span aria-hidden=\"true\">&raquo;</span>" +
                "<span class=\"sr-only\">Next</span>" +
                "</a>" +
                "</li>";
        }
        var lid = "";
        if (numPages < 4) {
            for (var i = 0; i < numPages; i++) {
                if (i === 0) {
                    lid = lid + "<li class=\"page-item active\" id='li 1'><a class=\"page-link\" href=\"#\" id='aTag 1' onclick='changeActivePageByNumber(id)'>" + (i + 1) + "</a></li>";
                } else {
                    lid = lid + "<li class=\"page-item\" id='li " + (i + 1) + "'><a class=\"page-link\" href=\"#\" id = 'aTag " + (i + 1) + "' onclick='changeActivePageByNumber(id)'>" + (i + 1) + "</a></li>";
                }
            }
        } else {
            lid = lid + "<li class=\"page-item active\" id='li 1'><a class=\"page-link\" href=\"#\" id='aTag 1' onclick='changeActivePageByNumber(id)'>1</a></li>";
            lid = lid + "<li class=\"page-item disabled\" id='li dot'><a class=\"page-link\" href=\"#\">. . .</a></li>";
            lid = lid + "<li class=\"page-item\" id='li " + numPages + "'><a class=\"page-link\" href=\"#\" id='aTag " + numPages + "' onclick='changeActivePageByNumber(id)'>" + numPages + "</a></li>";
        }
        var nav = liPrev + lid + liNext;
        $('#ulPage').html(nav);
        activeLiId = "li 1";
    }

    function addLastPage(numPages) {
        var liPrev = "<li  class=\"page-item\" id='li prev'>" +
            "<a class=\"page-link\" href=\"#\" aria-label=\"Previous\" tabindex=\"-1\" id='prev' onclick='prevPage()'>" +
            "<span aria-hidden=\"true\">&laquo;</span>" +
            "<span class=\"sr-only\">Previous</span>" +
            "</a>" +
            "</li>";
        var liNext = "<li class=\"page-item\" id='li next'>" +
            "<a class=\"page-link\" href=\"#\" aria-label=\"Next\" id='next' onclick='nextPage()'>" +
            "<span aria-hidden=\"true\">&raquo;</span>" +
            "<span class=\"sr-only\">Next</span>" +
            "</a>" +
            "</li>";
        var lid = "";
        lid = lid + "<li class=\"page-item disabled\" id='li dot'><a class=\"page-link\" href=\"#\">. . .</a></li>";
        lid = lid + "<li class=\"page-item active\" id='li " + (numPages - 1) + "'><a class=\"page-link\" href=\"#\" id='aTag " + (numPages - 1) + "' onclick='changeActivePageByNumber(id)'>" + (numPages - 1) + "</a></li>";
        lid = lid + "<li class=\"page-item\" id='li " + numPages + "'><a class=\"page-link\" href=\"#\" id='aTag " + numPages + "' onclick='changeActivePageByNumber(id)'>" + numPages + "</a></li>";
        var nav = liPrev + lid + liNext;
        $('#ulPage').html(nav);
        activeLiId = "li " + (numPages - 1);
    }

    function addPrevPage(numPages) {
        var liPrev = "<li  class=\"page-item\" id='li prev'>" +
            "<a class=\"page-link\" href=\"#\" aria-label=\"Previous\" tabindex=\"-1\" id='prev' onclick='prevPage()'>" +
            "<span aria-hidden=\"true\">&laquo;</span>" +
            "<span class=\"sr-only\">Previous</span>" +
            "</a>" +
            "</li>";
        var liNext = "<li class=\"page-item\" id='li next'>" +
            "<a class=\"page-link\" href=\"#\" aria-label=\"Next\" id='next' onclick='nextPage()'>" +
            "<span aria-hidden=\"true\">&raquo;</span>" +
            "<span class=\"sr-only\">Next</span>" +
            "</a>" +
            "</li>";
        var lid = "";
        lid = lid + "<li class=\"page-item active\" id='li " + (numPages - 2) + "'><a class=\"page-link\" href=\"#\" id='aTag " + (numPages - 2) + "' onclick='changeActivePageByNumber(id)'>" + (numPages - 2) + "</a></li>";
        lid = lid + "<li class=\"page-item disabled\" id='li dot'><a class=\"page-link\" href=\"#\">. . .</a></li>";
        lid = lid + "<li class=\"page-item\" id='li " + numPages + "'><a class=\"page-link\" href=\"#\" id='aTag " + numPages + "' onclick='changeActivePageByNumber(id)'>" + numPages + "</a></li>";
        var nav = liPrev + lid + liNext;
        $('#ulPage').html(nav);
        activeLiId = "li " + (numPages - 2);
    }

    function changeActivePageByNumber(id) {
        var newNumber = parseInt(id.toString().split(" ")[1]);
        getPageContent(newNumber);
        changeActiveByNumber(newNumber);
        if (newNumber === 1) {
            document.getElementById("li prev").classList.add("disabled");
            document.getElementById("li next").classList.remove("disabled");
        }
        if (newNumber === numpages) {
            document.getElementById("li next").classList.add("disabled");
            document.getElementById("li prev").classList.remove("disabled");
        }
        if (newNumber > 1 && newNumber < numpages) {
            document.getElementById("li next").classList.remove("disabled");
            document.getElementById("li prev").classList.remove("disabled");
        }
    }

    function changeActiveByNumber(newNumber) {
        var newLiId = "li " + (newNumber);
        document.getElementById(activeLiId).classList.remove("active");
        document.getElementById(newLiId).classList.add("active");
        activeLiId = newLiId;
    }

    function prevPage() {
        var activePage = activeLiId.split(" ")[1];
        var prevPage = parseInt(activePage) - 1;
        getPageContent(prevPage);
        document.getElementById("li next").classList.remove("disabled");
        if (numpages > 3) {
            if (parseInt(activePage) < (numpages - 1)) {
                changePrevActivePage(activePage);
                if (parseInt(activePage) === 2) {
                    document.getElementById("li prev").classList.add("disabled");
                }
            }
            if (parseInt(activePage) === (numpages - 1)) {
                addPrevPage(numpages);
            }
            if (parseInt(activePage) === numpages) {
                changePrevActive(activePage);
            }
        } else {
            changePrevActive(activePage);
            if (parseInt(activePage) === 2) {
                document.getElementById("li prev").classList.add("disabled");
            }
        }
    }

    function changePrevActivePage(activePage) {
        var newLiId = "li " + (parseInt(activePage) - 1);
        var aId = "aTag " + activePage;
        var atag = document.getElementById(aId);
        atag.innerHTML = (parseInt(activePage) - 1).toString();
        var newAId = "aTag " + (parseInt(activePage) - 1);
        document.getElementById(activeLiId).id = newLiId;
        atag.id = newAId;
        activeLiId = newLiId;
    }

    function changePrevActive(activePage) {
        var newLiId = "li " + (parseInt(activePage) - 1);
        document.getElementById(activeLiId).classList.remove("active");
        document.getElementById(newLiId).classList.add("active");
        activeLiId = newLiId;
    }

    function nextPage() {
        var activePage = activeLiId.split(" ")[1];
        var nextPage = parseInt(activePage) + 1;
        getPageContent(nextPage);
        document.getElementById("li prev").classList.remove("disabled");
        if (numpages > 3) {
            if (parseInt(activePage) < (numpages - 2)) {
                changeActivePage(activePage);
            }
            if (parseInt(activePage) === (numpages - 2)) {
                addLastPage(numpages);
            }
            if (parseInt(activePage) === (numpages - 1)) {
                changeActive(activePage);
                document.getElementById("li next").classList.add("disabled");
            }
        } else {
            changeActive(activePage);
            if (parseInt(activePage) === (numpages - 1)) {
                document.getElementById("li next").classList.add("disabled");
            }
        }
    };

    function changeActivePage(activePage) {
        var newLiId = "li " + (parseInt(activePage) + 1);
        var aId = "aTag " + activePage;
        var atag = document.getElementById(aId);
        atag.innerHTML = (parseInt(activePage) + 1).toString();
        var newAId = "aTag " + (parseInt(activePage) + 1);
        document.getElementById(activeLiId).id = newLiId;
        atag.id = newAId;
        activeLiId = newLiId;
    }

    function changeActive(activePage) {
        var newLiId = "li " + (parseInt(activePage) + 1);
        document.getElementById(activeLiId).classList.remove("active");
        document.getElementById(newLiId).classList.add("active");
        activeLiId = newLiId;
    }

    var numberOfPageElements = 0;

    function getPageContent(pageNumber) {
        $.ajax({
            type: "GET",
            url: "/getAllSubServices/" + (pageNumber - 1),
            async: false,
            success: function (data) {
                $("#serviceTable tr:gt(0)").remove();
                $(function () {
                    var row = "";
                    $.each(data.content, function (i, f) {
                        row = row + addRowToServiceTable((i + (numberOfPageElements * (pageNumber - 1))), f);
                    });
                    $("#serviceTable").append(row);
                });
            }
        });
    }

    var rowCount = 0;
    var expertRowCount = 0;
    $("#showServiceBtn").on('click', function () {
        $.ajax({
            type: "GET",
            url: "/getAllSubServices/0",
            async: false,
            success: function (data) {
                $("#serviceTable tr:gt(0)").remove();
                $(function () {
                    var row = "";
                    numberOfPageElements = ~~(parseInt(data.totalElements) / parseInt(data.totalPages));
                    if ((parseInt(data.totalElements) % parseInt(data.totalPages)) > 0)
                        numberOfPageElements = numberOfPageElements + 1;
                    $.each(data.content, function (i, f) {
                        row = row + addRowToServiceTable(i, f);
                    });
                    $("#serviceTable").append(row);
                    addPage(data.totalPages);
                });
            }
        });
    });

    function addRowToServiceTable(i, f) {
        var row = "";
        row = row + "<tr><th scope=\"row\">" + (i + 1) + "</th><td class='service-name'>" + f.service.name + "</td><td class='service-type'>" + f.service.type.name + "</td>";
        row = row + "<td class='subService-name'>" + f.name + "</td><td class='subService-type'>" + f.type.name + "</td><td class='subService-price'>" + f.price + "</td><td class='subService-description'>" + f.description + "</td><td><div class='btn-toolbar'>" +
            "<button type=\"button\" class=\"btn btn-warning\" id='editBtn " + f.service.id + " " + f.id + "' onclick='fillModal(id)' data-toggle='modal' data-target='#editServices' style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>Edit</button>" +
            "<button type=\"button\" class=\"btn btn-danger\" id='deleteBtn " + f.service.id + " " + f.id + "' onclick='fillDeleteModal(id)' data-toggle='modal' data-target='#deleteModal' style='background-color: #6adbbb;border-color: #6adbbb;color: #1f1f1f'>Delete</button></div></td><td><div class=\"form-check\">" +
            "<input class=\"form-check-input\" type=\"checkbox\" value=\"\" id=\"checkBox " + f.service.id + " " + f.id + "\" onclick='showExperts(id)' onchange='showModal(this)'></div></td></tr>";
        return row;
    }

    var serviceId;
    var subServiceId;

    function showModal(checkBox) {
        if (checkBox.checked) {
            $("#expertModal").modal("show");
        }
    }

    function editSubService() {
        if (validate())
        {
            if (boolSubServiceName) {
                var formData = {};
                var typeData = {};
                var id = $("#ServiceSelector").find('option:selected').attr('id');
                formData["id"] = subServiceId;
                typeData["name"] = $("#subService-type").val();
                formData["name"] = $("#subService-name").val();
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
                formData["price"] = $("#subService-price").val();
                formData["description"] = $("#subService-description").val();
                $.ajax({
                    type: "PUT",
                    contentType: "application/json",
                    url: "/editSubService",
                    data: JSON.stringify(formData),
                    dataType: 'json',
                    success: function (response) {
                        showSubSuccessMessage(response);
                        editSubServiceTable(formData["service"]);
                    },
                    error: function (error) {
                        showSubSuccessMessage(error.responseText)
                        if(error.responseText.includes("edit")){
                            editSubServiceTable(formData["service"]);
                        }
                    }
                });
            }
        }
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

    function editSubServiceTable(service){
        var $row = document.getElementById("editBtn " + serviceId + " " + subServiceId).closest("tr"), tds = $row.cells;
        tds[1].innerHTML = service.name;
        tds[2].innerHTML = service.type.name;
        tds[3].innerHTML = $("#subService-name").val();
        tds[4].innerHTML = $("#subService-type").val();
        tds[5].innerHTML = $("#subService-price").val();
        tds[6].innerHTML = $("#subService-description").val();
    }

    function validate(){
        if(boolSubServiceName && boolSubServiceType && boolSubServicePrice && boolSubServiceService)
            return true;
        return false;
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
        $.ajax({
            type: "DELETE",
            url: "/deleteSubService/" + subServiceId,
            success: function (response) {
                if (!response.toString().includes("expert")) {
                    var $row = document.getElementById("deleteBtn " + serviceId + " " + subServiceId).closest("tr");
                    $row.remove();
                    resetNumbers();
                    showDeleteMessage(response);
                } else {
                    showDeleteMessage(response);
                }
            },
            error: function (error) {
                if (!error.responseText.includes("expert")) {
                    var $row = document.getElementById("deleteBtn " + serviceId + " " + subServiceId).closest("tr");
                    $row.remove();
                    resetNumbers();
                } else {
                    showDeleteMessage(error.responseText);
                }
            }
        });
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
        getServiceSelector(serviceId);
        var $row = document.getElementById($id).closest("tr"), tds = $row.cells;
        for (var i = 3; i < tds.length - 1; i++) {
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
                        expertRowCount = i + 1;
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
        expertRowCount = expertRowCount - 1;
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
        expertRowCount = expertRowCount + 1;
        return "<tr id='tr " + id + "'><td>" + (expertRowCount) + "</td><td style='display: none'>" + id + "</td><td><button id=\"minusButton " + id + " " + subServiceId + "\" onclick='removeExpertOfSubService(id)' " +
            "class=\"btn btn-primary\" style='background-color: #6adbbb; border-color: #6adbbb'><i class=\"fa fa-minus\" style=\"color: #1f1f1f\"></i></button></td><td>" + name + "</td><td>" + family + "</td></tr>";

    }

    function resetNumbers() {
        $("table > tbody > tr").each(function (i) {
            var tds = this.cells;
            tds[0].innerHTML = (i + 1);
        });
    }

    function resetExpertsNumbers() {
        $("#expertTable > tbody > tr").each(function (i) {
            var tds = this.cells;
            tds[0].innerHTML = (i + 1);
        });
    }

</script>
</html>
