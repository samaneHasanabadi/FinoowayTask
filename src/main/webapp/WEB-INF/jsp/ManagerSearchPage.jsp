<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 1/15/21
  Time: 4:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <!-- Bootstrap CSS -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <%--    <link rel="stylesheet" href="MSPCSS.css">--%>
    <title>title</title>
</head>
<body>
<div class="well well-large" style="background-color: #55d5d1; display: flex; flex-direction: row">
    <div style="width: 40%;margin: 3%">
        <form id="searchForm">
            <div class="mb-3">
                <label for="name" class="form-label">Name</label>
                <input name="name" class="form-control" id="name">
            </div><br>
            <div class="mb-3">
                <label for="family" class="form-label">Family</label>
                <input name="family" class="form-control" id="family">
            </div><br>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input name="email" class="form-control" id="email">
            </div><br>
            <div class="mb-3">
                <label for="status" class="form-label">Status</label>
                <select name="status" id="status" class="form-select" aria-label="Default select example">
                    <option></option>
                    <option value="REGISTERED">REGISTERED</option>
                    <option value="WAITING">WAITING</option>
                    <option value="APPROVED">APPROVED</option>
                </select>
            </div><br>
        </form>
        <button class="btn btn-success" id="searchBtn">search</button>
    </div>
    <div style="width: 4%">
    </div>
    <div style="width: 40%; margin: 3%">
        <form id="conSearchForm">
            <div class="mb-3">
                <label for="service" class="form-label">Service Name</label>
                <input name="service" id="service" class="form-control">
            </div><br>
            <div class="mb-3">
                <label for="subService" class="form-label">Sub Service Name</label>
                <input name="subService" id="subService" class="form-control">
            </div><br>
        <div class="mb-3">
            <label for="role" class="form-label">Role</label>
            <select name="role" id="role" class="form-select" aria-label="Default select example">
                <option></option>
                <option value="EXPERT">EXPERT</option>
                <option value="CUSTOMER">CUSTOMER</option>
            </select>
        </div><br>
            <div class="mb-3">
                <label for="score" class="form-label">Score</label>
                <input name="score" type="number" id="score" class="form-control">
            </div><br>
        </form>
    </div>
</div>
<div style="display: none" id="divTable">
    <h3>Result Of Search</h3>
    <table class="table table-striped" id="searchTable">
        <thead class="thead-light">
        <tr>
            <th scope="col">#</th>
            <th scope="col">Name</th>
            <th scope="col">Family</th>
            <th scope="col">Email</th>
            <th scope="col">Role</th>
            <th scope="col">Status</th>
            <th scope="col">Service</th>
            <th scope="col">Sub Service</th>
            <th scope="col">Score</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
</body>
<script>
    function getFormData($form){
        var unindexed_array = $form.serializeArray();
        var indexed_array = {};

        $.map(unindexed_array, function(n, i){
            if(n['name'] === "role" && n['value'] === ""){
                indexed_array[n['name']]= null;
            }else if(n['name'] === "status" && n['value'] === ""){
                indexed_array[n['name']]= null;
            }else {
                indexed_array[n['name']] = n['value'];
            }
        });

        return indexed_array;
    }
    $("#searchBtn").on('click', function () {
        $("#divTable").show();
        $("#searchTable tr:gt(0)").remove();
        var form1 = $("#searchForm");
        var form2 = $("#conSearchForm");
        var formData1 = getFormData(form1);
        var formData2 = getFormData(form2);
        var searchData = $.extend(formData1, formData2);
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "findByCriteria",
            data: JSON.stringify(searchData),
            dataType: 'json',
            success: function (data2) {
                $.each(data2, function (i, f) {
                    $("#searchTable").append("<tr id='tr"+f.id+"'><td>"+(i+1)+"</td><td class='name'>" + f.name +
                        "</td><td class='family'>"+f.family+"</td><td class='username'>"+f.username+"</td><td class='id'>"+f.role+"</td>" +
                        "<td class='status'>"+f.status +"</td><td id='tdSubService"+f.id+"' class='subServices' >"+getServiceArrays(f.subServices, f.role)+"</td>" +
                        "<td id='tdSubService"+f.id+"' class='subServices' >"+getOfArrays(f.subServices, f.role)+"</td>" +
                        "<td class='id'>"+getScore(f.role,f.score)+"</td></tr>");
                });
            }
        });
    });
    function getOfArrays(array , role){
        var text = "";
        if(role === "EXPERT") {
            for (var i = 0; i < array.length; i++) {
                text = text + array[i].name + "-";
            }
        }
        return text;
    }
    function getServiceArrays(array, role){
        var text = "";
        if(role === "EXPERT") {
            for (var i = 0; i < array.length; i++) {
                text = text + array[i].service.name + "-";
            }
        }
        return text;
    }

    function getScore(role,score){
        var text = "";
        if(role === "EXPERT") {
            if(score === undefined){
                text = "0";
            }else {
                text = score;
            }
        }
        return text;
    }
</script>
</html>
