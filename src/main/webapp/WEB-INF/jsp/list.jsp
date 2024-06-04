<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Users</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(142.40deg, rgb(0, 0, 0) 11.607%, rgb(65, 0, 95) 92.473%, rgb(65, 0, 96) 99.137%);
            color: white;
            margin-top: 30px;
        }
        html{
            height: 1vh;
        }

        a {
            text-decoration: none;
            color: white;
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
            padding: 10px 80px;
            align-items: center;
        }

        .table-container {
            padding: 20px 80px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            background-color: rgba(255, 255, 255, 0.623);
            border: solid 1px #B2BCDF;
            border-radius: 24px;
            overflow: hidden;
        }

        colgroup col {
            width: 20%;
        }

        thead {
            background-color: #f8f9fa;
            color: black;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            white-space: nowrap;
        }

        th {
            font-size: 14px;
            color: #6c757d;
        }

        td {
            font-size: 16px;
            color: #212529;
        }

        .view-detail {
            background-color: #3d005a;
            color: #fff;
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
        }

        .view-detail:hover {
            background: rgb(51, 33, 65);
        }

        .back-link {
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>

<body>
<security:authentication var="principal" property="principal.id"/>
<div class="header">
    <a href="/app"><h1> PETPROJECTS </h1></a>
    <div class="id-logout">
        <div class="id">Your personal ID is: <a href="/app/users/${principal}">${principal}</a>
        </div>
        <div class="logout"><a href="${pageContext.request.contextPath}/logout">Log Out</a></div>
    </div>
</div>
<div class="table-container">
    <table>
        <colgroup>
            <col>
            <col>
            <col>
            <col>
            <col>
        </colgroup>
        <thead>
        <tr>
            <th>Name</th>
            <th>Surname</th>
            <th>Role</th>
            <th>Email</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${users}" var="user">
            <tr>
                <td>${user.first_name}</td>
                <td>${user.last_name}</td>
                <td>${user.role_name}</td>
                <td>${user.email}</td>
                <td><a href="/app/users/${user.id}" class="view-detail">View Detail</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="back-link">
        <a href="/app">Back</a>
    </div>
</div>
</body>

</html>
