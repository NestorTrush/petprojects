<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Information</title>
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

        a {
            text-decoration: none;
            color: white;
        }
        .error-message {
            color: red;
            margin-top: 10px;
        }

        .success-message {
            background-color: rgba(0, 128, 0, 0.7);
            padding: 15px;
            border-radius: 10px;
            margin: 20px 0;
            text-align: center;
        }

        .apply-form {
            margin-top: 20px;
        }

        .apply-form textarea {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .apply-form input[type="submit"] {
            margin-top: 10px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #3d005a;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .apply-form input[type="submit"]:hover {
            background-color: #6c05c0;
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
    <h2>Project Information</h2>
    <ul>
        <li>ID: ${projectinfo.id}</li>
        <li>Project Name: ${projectinfo.name}</li>
        <li>Project Owner: <a href="/app/users/${projectinfo.ownerId}">${owner.first_name} ${owner.last_name}</a></li>
        <li>Description: ${projectinfo.description}</li>
        <li>Start Date: ${projectinfo.startTime}</li>
        <li>End Date: ${projectinfo.finishTime}</li>
        <li>Status: ${projectinfo.completed ? 'Completed' : 'In progress'}</li>
    </ul>

    <h2>Assigned Users:</h2>
    <ol>
        <c:forEach items="${projectinfo.users}" var="user">
            <li>
                <a href="/app/users/${user.id}">${user.first_name} ${user.last_name} </a> ${user.role_name}
                <c:if test="${principal == projectinfo.ownerId}">
                    <a href="/app/projects/unassignUser/${projectinfo.id}/${user.id}">Unassign</a>
                </c:if>
            </li>
        </c:forEach>
    </ol>

    <c:if test="${principal == projectinfo.ownerId}">
        <h2>Applied Users:</h2>
        <ol>
            <c:forEach items="${applies}" var="user">
                <li>
                    <a href="/app/users/${user.id}">${user.first_name} ${user.last_name}</a>
                    Role: ${user.role_name}
                    <p>Description: ${user.email}</p>
                    <a href="/app/projects/assignUser/${projectinfo.id}/${user.id}">Accept</a>
                    <a href="/app/projects/declineUser/${projectinfo.id}/${user.id}">Decline</a>
                </li>
            </c:forEach>
        </ol>
        <a href="/app/projects/${projectinfo.id}/delete">Delete</a>
    </c:if>

    <c:if test="${principal == projectinfo.ownerId && !projectinfo.completed}">
        <a href="/app/projects/markCompleted/${projectinfo.id}">Mark as completed</a>
    </c:if>

    <c:if test="${errorMessage != null}">
        <div class="error-message">${errorMessage}</div>
    </c:if>

    <c:if test="${errorMessage2 != null}">
        <div class="error-message">${errorMessage2}</div>
    </c:if>

    <c:url var="add_user_url" value="/projects/applyToProject">
        <c:param name="project_id" value="${projectinfo.id}"></c:param>
    </c:url>

    <c:if test="${warning != null}">
        <div class="success-message">${warning}</div>
    </c:if>

    <c:if test="${principal != projectinfo.ownerId && applyUser != null}">
        <div class="apply-form">
            <form:form action="${add_user_url}" method="post" modelAttribute="applyUser">
                <h2>Apply for the Project</h2>
                <form:textarea path="description" rows="4" cols="50" required="required"></form:textarea>
                <input type="submit" value="Submit"/>
            </form:form>
        </div>
    </c:if>
</div>

<div class="back-button">
    <a href="/app/projects">Back</a>
</div>
</body>

</html>

