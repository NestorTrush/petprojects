<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Projects</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(142.40deg, rgb(0, 0, 0) 11.607%, rgb(65, 0, 95) 92.473%, rgb(65, 0, 96) 99.137%);
            color: white;
            padding: 0;
            margin-top: 30px;
        }

        html {
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

        .search-container {
            display: flex;
            background-color: rgba(255, 255, 255, 0.623);
            padding: 10px;
            padding-left: 20px;
            padding-right: 20px;
            border: solid 1px #B2BCDF;
            border-radius: 24px;
            width: fit-content;
        }

        .search-container form {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
            width: 100%;
        }

        .search-container form label {
            font-size: 14px;
            color: white;
        }

        .search-container form input,
        .search-container form select,
        .search-container form button {
            padding: 5px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .search-container form button {
            background-color: #3d005a;
            color: white;
            cursor: pointer;
        }

        .search-container form button:hover {
            background: rgb(51, 33, 65);
        }

        .table-container {
            padding: 20px 80px;
            display: flex;
            flex-direction: column;
            gap: 10px;
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
            width: 12.5%;
        }

        thead {
            background-color: #f8f9fa;
            color: black;
        }

        th,
        td {
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

        .status-yes {
            color: #237f23;
        }

        .status-no {
            color: #9f1111;
        }

        .action-links {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            padding: 0 80px;
        }

        .create-project {
            white-space: nowrap;
        }

        .back-link {
            text-align: center;
            width: 100%;
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
    <div class="search-container">
        <form:form action="projects" method="post" modelAttribute="filter">
            <form:label path="name">Project Name: </form:label>
            <form:input type="text" path="name" />
            <form:label path="completed">Status: </form:label>
            <form:select path="completed">
                <form:option value="All">All</form:option>
                <form:option value="Completed">Completed</form:option>
                <form:option value="In progress">In progress</form:option>
            </form:select>
            <button type="submit">Search</button>
        </form:form>
    </div>


    <table>
        <colgroup>
            <col>
            <col>
            <col>
            <col>
            <col>
            <col>
            <col>
        </colgroup>
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Owner</th>
            <th>Start Time</th>
            <th>Finish Time</th>
            <th>Is completed</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${projects}" var="project">
            <tr>
                <td>${project.id}</td>
                <td>${project.name}</td>
                <td>${usernames[project.ownerId]}</td>
                <td>${project.startTime}</td>
                <td>${project.finishTime}</td>
                <td class="${project.completed ? 'status-yes' : 'status-no'}">
                        ${project.completed ? 'Yes' : 'No'}
                </td>
                <td><a href="/app/projects/${project.id}" class="view-detail">View Detail</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div class="action-links">
    <div class="create-project">
        <a href="/app/projects/addProject">Create Project</a>
    </div>
    <div class="back-link">
        <a href="/app">Back</a>
    </div>
</div>
</body>

</html>
