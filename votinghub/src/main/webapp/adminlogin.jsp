<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <style>
        body {
        background-image:images.png;
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f4;
        }
        .login-container {
            margin: 100px auto;
            width: 300px;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        input {
            width: 90%;
            margin: 10px 0;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Admin Login</h2>
        <form action="result.jsp" method="POST">
            <input type="text" name="adminID" placeholder="Admin ID" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="text" name="electionID" placeholder="Election ID" required>
            <input type="text" name="regionID" placeholder="Region ID" required>
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>
