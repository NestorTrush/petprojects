<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <style>
        body {
            background: linear-gradient(142.40deg, rgb(0, 0, 0) 11.607%, rgb(65, 0, 95) 92.473%, rgb(65, 0, 96) 99.137%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            font-family: 'Montserrat', sans-serif;
        }

        .sec-1 {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            width: 100vw;
        }

        .login-card {
            background-color: rgba(255, 255, 255, 0.623);
            border: solid 1px #B2BCDF;
            border-radius: 24px;
            backdrop-filter: blur(100px);
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            width: 400px;
        }

        .text {
            text-align: center;
            margin-bottom: 20px;
        }

        .text h1 {
            font-size: 32px;
            color: #FFFFFF;
            margin: 0;
        }

        .text h1 em {
            color: #7a22d7;
        }

        .text p {
            font-size: 20px;
            color: #FFFFFF;
            margin: 5px 0 20px 0;
        }

        .user-ipt {
            width: 100%;
        }

        .user-ipt label {
            display: block;
            font-size: 12px;
            color: #FFFFFF;
            margin-bottom: 5px;
        }

        .user-ipt input {
            width: 100%;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-family: 'Montserrat', sans-serif;
            border: solid #C6D0EF 1px;
            font-size: 14px;
            box-sizing: border-box;
        }

        .login-btn {
            width: 100%;
            text-align: center;
        }

        .login-btn button {
            width: 100%;
            padding: 15px;
            border-radius: 6px;
            border: none;
            background-color: #7a22d7;
            color: #F8F8F8;
            font-family: 'Montserrat', sans-serif;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.5s ease-in-out, border-color 0.5s ease-in-out;
        }

        .login-btn button:hover {
            background-color: #6c05c0;
        }

        .login-links {
            margin-top: 10px;
            text-align: center;
        }

        .login-links p {
            font-size: 12px;
            color: #FFFFFF;
            margin: 0;
        }

        .login-links a {
            color: #7a22d7;
            text-decoration: none;
        }

        .login-links a:hover {
            text-decoration: underline;
        }

        h1 {
            font-family: "Montserrat";
            font-size: 32px;
            font-style: normal;
            margin: 0px;
            color: #FFFFFF;
        }
        h1 em {
            font-family: "Montserrat";
            font-size: 32px;
            font-style: normal;
            color: #7a22d7;
        }
    </style>
</head>
<body>
<div class="sec-1">
    <div class="login-card">
        <div class="text">
            <h1>
                <em>Sign</em> up
            </h1>
        </div>
        <c:if test="${not empty error}">
            <div style="color: red; text-align: center;" class="alert alert-danger">
                <c:out value="${error}" />
            </div>
        </c:if>
        <div class="user-ipt">
            <form action="${save_user_url}" method="post" modelAttribute="user">
                <label for="first_name">User First Name:</label>
                <input type="text" id="first_name" name="first_name" required="required"/>

                <label for="last_name">User Last Name:</label>
                <input type="text" id="last_name" name="last_name" required="required"/>

                <label for="email">User Email:</label>
                <input type="text" id="email" name="email" required="required"/>

                <label for="password">User Password:</label>
                <input type="password" id="password" name="password" required="required"/>

                <label for="role_name">User Role:</label>
                <input type="text" id="role_name" name="role_name" required="required"/>

                <div class="login-btn">
                    <button type="submit">Sign up</button>
                </div>
            </form>
        </div>
        <div class="login-links">
            <p>or <a href="/app/login">log in</a></p>
        </div>
    </div>
</div>
</body>
</html>
