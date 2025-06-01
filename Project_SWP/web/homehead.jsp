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
            /* Main header styling */
            .badminton-header {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f7f7f7;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            /* Top logo and auth area */
            .header-top {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 24px;
            }

            .logo {
                font-weight: bold;
                color: red;
            }

            .logo img{
                width: 50px;
                height: 50px;
            }

            .site-name {
                font-size: 20px;
                font-weight: bold;
                color: #0b3b8c;
            }

            /* Auth links */
            .auth-links {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 10px;
                font-size: 14px;
            }
            
            .auth-links img {
                width: 50px;
                height:50px;
                border-radius: 50%;
            }
            
            .auth-links a {
                text-decoration: none;
                color: black;
                font-weight: 700;
            }
            
            /* Navigation bar */
            .nav-bar {
                display: flex;
                justify-content: center;
                background-color: #2b6cb0;
                padding: 10px 0;
                gap: 28px;
            }

            .nav-bar a {
                color: white;
                text-decoration: none;
                font-weight: 500;
                font-size: 15px;
                transition: color 0.2s, transform 0.2s;
            }

            .nav-bar a:hover {
                color: #ffe066;
                transform: scale(1.05);
            }
            
        </style>
    </head>

    <body>
        <%
        User user = (User) session.getAttribute("user");
        %>
        <!-- Header -->
        <header class="badminton-header">
            <div class="header-top">
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

            <nav class="nav-bar">
                <a href="homepageUser.jsp">Trang Chủ</a>
                <a href="#">Danh Sách Sân Bãi</a>
                <a href="GioiThieu.jsp">Giới Thiệu</a>
                <a href="#">Điều Khoản</a>
                <a href="#">Danh Sách Chủ Sân</a>
                <a href="#">Liên Hệ</a>
            </nav>              
        </header>              
    </body>
</html>
