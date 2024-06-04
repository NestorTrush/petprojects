<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<HTMl>

<head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap"
          rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <style>
        .sec-1 {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        body {
            overflow: hidden;
            display: block;
            height: 100vh;
            width: 100vw;
            margin: 0;
            background: linear-gradient(142.40deg, rgb(0, 0, 0) 11.607%, rgb(65, 0, 95) 92.473%, rgb(65, 0, 96) 99.137%);
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

        .text p {
            font-family: "Montserrat";
            font-size: 20px;
            margin: 0px;
            color: #FFFFFF;
        }

        .login-card {
            position: relative;
            display: flex;
            flex-direction: column;
            height: 530px;
            width: 450px;
            padding-left: 10px;
            padding-right: 10px;
            padding-top: 20px;
            padding-bottom: 20px;
            justify-content: space-around;
            background-color: rgba(255, 255, 255, 0.623);
            border: solid 1px #B2BCDF;
            border-radius: 24px;
            backdrop-filter: blur(100px)
        }

        .text {
            margin: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .user-ipt {
            margin: 20px;
            display: flex;
            flex-direction: column;
            text-align: right;
            margin-bottom: 0px;
        }

        .login-btn {
            margin: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;

        }

        .user-ipt input {
            padding: 20px;
            border-radius: 6px;
            margin-bottom: 10px;
            font-family: "Inter";
            border: solid #C6D0EF 1px;
            color: #202020;
            font-size: 12px;
        }

        .user-ipt p {
            font-family: "Inter";
            font-size: 12px;
            margin: 0px;
            color: #FFFFFF;
        }

        .login-btn button {
            color: #F8F8F8;
            background-color: #7a22d7;
            padding: 20px;
            border-radius: 6px;
            margin-bottom: 10px;
            font-family: "Inter";
            border: solid #C6D0EF 1px;
            color: #F8F8F8;
            font-size: 12px;
            height: 100%;
            width: 100%;
        }

        .login-btn p {
            font-family: "Inter";
            font-size: 12px;
            margin: 0px;
            color: #FFFFFF;
        }

        .login-btn a {
            font-family: "Inter";
            font-size: 12px;
            margin: 0px;
            color: #7a22d7;
            text-decoration: none;
        }

        .login-btn button:hover {
            background-color: #6c05c0;
            border-color: #6c05c0;
            transition: all ease-in-out .5s;
            cursor: pointer;
        }

        .user-ipt p:hover {
            color: #0075FF;
            cursor: pointer;
        }

        .login-links div:hover {
            cursor: pointer;
        }

        .user-ipt input:focus {
            outline-style: none;
        }
    </style>
</head>

<body>
<div class="sec-1">
    <div style="position: absolute; height: 100vh; width: 100vw; overflow: hidden;"></div>
    <form class="login-card" id="login-form" action="${pageContext.request.contextPath}/login" method="post">
        <div class="text">
            <h1>
                <em>Welcome</em> back
            </h1>
            <p>
                Glad to see you <br>
                again!
            </p>
        </div>
        <c:if test="${param.error != null}">
            <p style="color: red; text-align: center;">Invalid username or password</p></c:if>
        <div class="user-ipt">
            <label for="username"></label>
            <input type="text" class="form-control" id="username" name="username" placeholder="User Email...">
            <label for="username"></label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Password...">
        </div>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="login-btn">
            <button type="submit">Login</button>
            <p>or <a href="${pageContext.request.contextPath}/register">sign up</a></p>
        </div>
    </form>
</div>
</body>

</HTMl>