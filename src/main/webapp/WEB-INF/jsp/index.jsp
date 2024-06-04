<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>

<head>
    <title>Home page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(142.40deg, rgb(0, 0, 0) 11.607%, rgb(65, 0, 95) 92.473%, rgb(65, 0, 96) 99.137%);
            color: white;
            text-align: center;
            padding: 0;
            margin-left: 80px;
            margin-right: 80px;
            margin-top: 30px;
        }

        h1 {
            color: rgb(255, 255, 255);
            font-size: 48px;
            margin: 0;

        }

        .id-logout {
            display: flex;
            padding: 10px;
            font-size: 32px;
            align-items: center;
            gap: 20px;
        }

        .id {
            font-size: 26px;
        }

        .logout {
            padding: 10px;
            border: 1px solid rgb(180, 191, 197);
            border-radius: 20px;
            font-size: 20px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            align-items: center;
        }

        h2 {
            font-size: 64px;
            font-weight: 700;
            margin: 0;
        }

        .description {
            display: flex;
            gap: 20px;
            font-size: 32px;
            font-weight: 300;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .about {
            display: flex;
            flex-direction: column;
            gap: 16px;
            justify-content: center;
            align-items: center;
        }

        .top {
            display: flex;
            flex-direction: column;
            gap: 75px;
        }

        .cards {
            border: 1px solid rgb(180, 191, 197);
            border-radius: 30px;
            padding: 150px;
            font-size: 72px;
            font-weight: 400;
            text-decoration: none;
            transition: 0.15s;
        }

        .cards:hover {
            background: rgb(51, 33, 65);
        }

        a {
            text-decoration: none;
            color: white;
        }

        .bottom {
            display: flex;
            gap: 20px;
            justify-content: center;
        }

        .center {
            display: flex;
            gap: 100px;
            justify-content: center;
        }
    </style>
</head>

<body>
<security:authentication var="principal" property="principal.id"/>
<div class="top">
    <div class="header">
        <a href="/app"><h1> PETPROJECTS </h1></a>
        <div class="id-logout">
            <div class="id">Your personal ID is: <a href="/app/users/${principal}">${principal}</a>
            </div>
            <div class="logout"><a href="${pageContext.request.contextPath}/logout">Log Out</a></div>
        </div>
    </div>
    <div class="center">
        <div class="about">
            <h2>Build your new career</h2>
            <div class="description">
                <div>find teammates</div>
                <div>find ideas</div>
                <div>find experience</div>
                <div>update your skill</div>
            </div>
        </div>
    </div>
    <div class="bottom">
        <a href="/app/users">
            <div class="cards">Users</div>
        </a>

        <a href="/app/projects">
            <div class="cards">Projects</div>
        </a>
    </div>
</div>
</body>

</html>