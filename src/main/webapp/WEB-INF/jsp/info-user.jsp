<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(142.40deg, rgb(0, 0, 0) 11.607%, rgb(65, 0, 95) 92.473%, rgb(65, 0, 96) 99.137%);
            color: white;
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 1vh;
        }

        h1 {
            color: rgb(255, 255, 255);
            font-size: 48px;
            margin: 20px 0;
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
            align-self: normal;
        }

        .content-container {
            background-color: rgba(255, 255, 255, 0.623);
            border: solid 1px #B2BCDF;
            border-radius: 24px;
            backdrop-filter: blur(100px);
            padding: 30px;
            width: 80%;
            max-width: 1000px;
            margin-top: 20px;
        }

        ul, ol {
            text-align: left;
            padding-left: 20px;
            display: flex;
            flex-direction: column;
            gap: 15px
        }

        ul li, ol li {
            margin-bottom: 10px;
        }

        .back-button {
            margin-top: 20px;
            padding-bottom: 20px;
            text-align: center;
            width: 100%;
        }

        .content-container a {
            background-color: #3d005a;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
        }

        .content-container a:hover {
            background-color: #6c05c0;
        }

        .error-message {
            color: red;
            margin-top: 10px;
        }
        a {
            text-decoration: none;
            color: white;
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

<div class="content-container">
    <h2>User Information</h2>
    <ul>
        <li>ID: ${userinfo.id}</li>
        <li>First Name: ${userinfo.first_name}</li>
        <li>Last Name: ${userinfo.last_name}</li>
        <li>User Email: ${userinfo.email}</li>
        <li>Role: ${userinfo.role_name}</li>
    </ul>

    <h2>Related Projects:</h2>
    <ol>
        <c:forEach items="${userinfo.projects}" var="project">
            <li>
                <a href="/app/projects/${project.id}">${project.name} ${project.completed ? 'Completed' : 'In progress'}</a>
            </li>
        </c:forEach>
    </ol>

    <h2>Owned Projects:</h2>
    <ol>
        <c:forEach items="${ownedProjects}" var="project">
            <li><a href="/app/projects/${project.id}">${project.name} ${project.completed ? 'Completed' : 'In progress'}</a></li>
        </c:forEach>
    </ol>

    <c:if test="${errorMessage != null}">
        <div class="error-message">${errorMessage}</div>
    </c:if>

    <c:url var="add_project_url" value="/users/assignProject">
        <c:param name="user_id" value="${userinfo.id}"></c:param>
    </c:url>

    <security:authentication var="principal" property="principal.id"/>
    <c:if test="${principal == userinfo.id}">
        <a href="/app/users/update/${userinfo.id}">Update my information</a>
    </c:if>
</div>

<div class="back-button">
    <a href="/app/users">Back</a>
</div>
</body>

</html>
