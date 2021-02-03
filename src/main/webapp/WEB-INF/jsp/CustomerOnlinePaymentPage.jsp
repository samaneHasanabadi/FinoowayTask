<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: samane
  Date: 2/2/21
  Time: 11:21 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>online payment</title>

    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/theme/css/styles.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/theme/css/demo.css"/>">
    <script src="/resources/js/jquery.payform.min.js" charset="utf-8"></script>
    <script src="/resources/js/script.js"></script>
    <script src='https://www.google.com/recaptcha/api.js?hl=en'></script>
</head>
<body onload="timeControl();start()">
<div class="creditCardForm">
    <div class="heading">
        <h1>Online Payment</h1>
    </div>
    <div class="payment">
        <div><strong>time left in seconds:</strong></div>
        <p id="demo">60000</p>
        <form>
            <div class="form-group" id="card-number-field">
                <label for="cardNumber">Card Number</label>
                <input type="text" class="form-control" id="cardNumber">
            </div>
            <div class="form-group owner">
                <label for="owner">Password</label>
                <input type="password" class="form-control" id="owner">
            </div>
            <div class="form-group CVV">
                <label for="cvv">CVV2</label>
                <input type="text" class="form-control" id="cvv">
            </div>
            <div>
            <div>
                <label>Expiration Date</label>
                <select>
                    <option value="01">January</option>
                    <option value="02">February </option>
                    <option value="03">March</option>
                    <option value="04">April</option>
                    <option value="05">May</option>
                    <option value="06">June</option>
                    <option value="07">July</option>
                    <option value="08">August</option>
                    <option value="09">September</option>
                    <option value="10">October</option>
                    <option value="11">November</option>
                    <option value="12">December</option>
                </select>
                <select>
                    <option value="16"> 2016</option>
                    <option value="17"> 2017</option>
                    <option value="18"> 2018</option>
                    <option value="19"> 2019</option>
                    <option value="20"> 2020</option>
                    <option value="21"> 2021</option>
                </select>
            </div><br>
            <div class="g-recaptcha"
                 data-sitekey="6LeLBUgaAAAAAOvYsolj7ch3e9Skxo6bnjiy3ql0"></div>
                <div class="help-block with-errors"></div>
            <div class="form-group" id="pay-now">
                <button type="submit" class="btn btn-default" id="confirm-purchase">Confirm</button>
            </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>

<script>
    function timeControl() {
        setTimeout('disableBtn()', 600000);
    }

    function disableBtn(){
        document.getElementById("confirm-purchase").disabled = true;
        alert("Your time ends!!")
    }
    function changeValue() {
        document.getElementById("demo").innerHTML = --value;
    }

    var timerInterval = null;
    function start() {
        value = 600000;
        timerInterval = setInterval(changeValue, 1000);
    }
    function changeValue() {
        document.getElementById("demo").innerHTML = --value;
    }
</script>