<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voting Hub</title>
    <style>
        /* General Styling */
        * {
            margin: 0;
            padding: 0;
        }

        body {
            background-color: rgb(28, 25, 25);
            font-family: "Roboto", sans-serif;
            color: white;
        }

        a {
            text-decoration: none;
            color: white;
            letter-spacing: 0.7px;
        }

        .main {
            height: 99vh;
            width: calc(99vw - 2vw);
        }

        .nav-bar {
            display: flex;
            justify-content: space-between;
            padding: 5px 10px;
            align-items: center;
            margin-top: 5px;
        }

        .name {
            display: flex;
            gap: 0.3rem;
        }

        .pic img {
            height: 2rem;
            width: 2rem;
        }

        .options {
            display: flex;
            gap: 1.2rem;
        }

        .context {
            height: 90%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px;
        }

        .para {
            width: 45%;
            padding-left: 15px;
            font-size: 24px;
        }

        .content {
            width: 45%;
        }

        .booth img {
            height: 80%;
            width: 100%;
            object-fit: cover;
        }

        .btn {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        button {
            padding: 10px 40px;
            border: none;
            border-radius: 10px;
            font-weight: bold;
            font-size: 18px;
            background-color: #000;
            color: white;
            transition: all 0.3s ease-in-out;
        }

        button:hover {
            background-color: white;
            color: black;
            cursor: pointer;
        }

        select {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
        }

        .adhar-display {
            font-size: 18px;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>
    <div class="main">
        <div class="nav-bar">
            <div class="name">
                <div class="pic"><img src="Colored_logo1-removebg-preview.png" alt="The Logo"></div>
                <h2>Voting Hub</h2>
            </div>
            <div class="options">
                <a href="#about">ABOUT US</a>
                <a href="#contact">CONTACT US</a>
            </div>
        </div>
        <div class="context">
            <div class="para">
                <h2>Choose Your Nation's Leader with a Single Click Now.</h2>
            </div>
            <div class="content">
                <div class="booth">
                    <img src="hand.jpg" alt="An random Image">
                </div>
                <form action="Validate" method="POST">
                    <div class="adhar-display">
                        Aadhaar Number: <span id="adharDisplay"></span>
                    </div>
                    <input type="hidden" name="adharNumber" id="adharNumber">
                    <select name="electionType">
                        <option value="National">National</option>
                        <option value="State">State</option>
                    </select>
                    <div class="btn">
                        <button type="submit">VOTE NOW</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script>
        const adharNum = new URLSearchParams(window.location.search).get('adharNumber');
        if (!adharNum) {
            alert("Aadhaar Number is required to proceed.");
            window.location.href = 'home.jsp';
        } else {
            document.getElementById('adharNumber').value = adharNum;
            document.getElementById('adharDisplay').innerText = adharNum;
        }
    </script>
</body>

</html>
