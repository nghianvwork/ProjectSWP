<%-- 
    Document   : homehead
    Created on : May 24, 2025, 2:35:17 AM
    Author     : sangn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #e9e9e9;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #f2f2f2;
                padding: 10px 50px;
                height: 50px;
            }

            .logo {
                font-weight: bold;
                color: red;
            }

            .logo img{
                width: 50px;
                height: 50px;
            }

            .banner {
                font-size: 20px;
            }

            .auth-links {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 10px;
                font-size: 14px;
            }
            
            .auth-links a {
                text-decoration: none;
                color: black;
                font-weight: 600;
            }

            .auth-links img {
                width: 50px;
                height:50px;
                border-radius: 50%;
            }

            .nav-bar {
                background-color: #2d6db6;
                padding: 10px;
                text-align: center;
            }

            .nav-bar a {
                color: white;
                margin: 0 10px;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
        %>
        <div class="header">
            <div class="logo">
                <img src="./images/logo/Badminton.jpg" alt="Logo" />
            </div>
            <div class="auth-links">
                <img src="./images/avt/avt.jpg" alt="avt" />
                <span>
                    <a href="viewprofile.jsp"><%=user.getUsername()%></a>
                </span>
                <a href="homepage.jsp">Thoát</a>
            </div>
        </div>

        <div class="nav-bar">
            <a href="homepageUser.jsp">Trang Chủ</a>
            <a href="#">Danh Sách Sân Bãi</a>
            <a href="#">Giới Thiệu</a>
            <a href="#">Điều Khoản</a>
            <a href="#">Danh Sách Chủ Sân</a>
            <a href="#">Liên Hệ</a>
        </div>
    </body>
</html>
