<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Project</title>
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
            height: 100vh;
        }

        h1 {
            color: rgb(255, 255, 255);
            font-size: 48px;
            margin: 20px 0;
        }

        .success-message {
            background-color: rgba(0, 128, 0, 0.7);
            padding: 15px;
            border-radius: 10px;
            margin: 20px 0;
            text-align: center;
        }

        .form-container {
            background-color: rgba(255, 255, 255, 0.623);
            border: solid 1px #B2BCDF;
            border-radius: 24px;
            backdrop-filter: blur(100px);
            padding: 30px;
            width: 100%;
            max-width: 600px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .form-container form {
            width: 100%;
            display: flex;
            flex-direction: column;
        }

        .form-container label {
            margin-top: 10px;
            font-size: 16px;
            color: #212529;
        }

        .form-container input[type="text"],
        .form-container textarea {
            padding: 10px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .form-container input[type="submit"] {
            margin-top: 20px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #3d005a;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .form-container input[type="submit"]:hover {
            background-color: #3d005a;
        }

        .back-button {
            margin-top: 20px;
            text-align: center;
        }

        .back-button a {
            background-color: #3d005a;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
        }

        .back-button a:hover {
            background: rgb(51, 33, 65);
        }
    </style>
</head>

<body>
<h1>Create a new project</h1>

<c:if test="${addProjectSuccess}">
    <div class="success-message">Successfully added Project with name: ${savedProject.name}</div>
</c:if>

<div class="form-container">
    <c:url var="add_project_url" value="/projects/addProject" />
    <form:form action="${add_project_url}" method="post" modelAttribute="project">
        <form:label path="name">Name: </form:label>
        <form:input type="text" path="name" required="required"/>
        <form:label path="description">Description: </form:label>
        <form:textarea path="description" rows="4" cols="50" required="required"></form:textarea>
        <input type="submit" value="Submit" />
    </form:form>

    <div class="back-button">
        <a href="/app/projects">Back</a>
    </div>
</div>
</body>

</html>
