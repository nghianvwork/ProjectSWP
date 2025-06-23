<%-- 
    Document   : UpdateProfile
    Created on : Jun 24, 2025, 1:33:44 AM
    Author     : sangn
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Update Profile</title>
        <style>
            .form-container {
                width: 50%;
                margin: auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            input {
                width: 100%;
                padding: 6px;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2 style="text-align:center;">Update Profile</h2>

            <form action="updateprofile" method="post">
                <input type="hidden" name="userId" value="${user.userId}"/>

                Username:
                <input type="text" name="username" value="${user.username}" required/>

                Full Name:
                <input type="text" name="fullname" value="${user.fullname}" required/>

                Email:
                <input type="email" name="email" value="${user.email}" required/>

                Phone Number:
                <input type="text" name="phoneNumber" value="${user.phoneNumber}"/>

                Gender:
                <input type="text" name="gender" value="${user.gender}"/>

                Role:
                <input type="text" name="role" value="${user.role}"/>

                Status:
                <input type="text" name="status" value="${user.status}"/>

                Note:
                <input type="text" name="note" value="${user.note}"/>

                Date of Birth:
                <input type="date" name="dateOfBirth" value="${user.dateOfBirth}"/>

                <button type="submit">Update</button>
            </form>

            <c:if test="${not empty error}">
                <p style="color:red;">${error}</p>
            </c:if>

        </div>
    </body>
</html>