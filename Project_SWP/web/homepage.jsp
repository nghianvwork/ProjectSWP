<%-- 
    Document   : homepage
    Created on : May 22, 2025, 10:25:58 AM
    Author     : sangn
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Hệ thống tìm kiếm sân bãi</title>
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
                padding: 10px 20px;
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
                gap: 20px;
                font-size: 14px;
            }

            .auth-links a {
                text-decoration: none;
                color: black;
                font-weight: 600;
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

            .search-area {
                text-align: center;
                padding: 30px;
                background-color: #ccc;
            }

            .search-title {
                font-size: 24px;
                font-weight: bold;
                padding-bottom: 20px;
            }

            .search-form {
                display: flex;
                justify-content: center;
                gap: 10px;
                flex-wrap: wrap;
            }

            .search-form input,
            .search-form select {
                padding: 8px;
                font-size: 14px;
            }

            .search-form button {
                background-color: #ffcc00;
                border: none;
                padding: 9px 15px;
                font-weight: bold;
                cursor: pointer;
            }

            .featured {
                display: flex;
                justify-content: center;
                gap: 20px;
            }

            /*            .logo-san {
                            text-align: center;
                            width: 200px;
                            height: 150px;
                        }*/

            .logo-san img{
                width: 100%;
                height: 150px;
                object-fit: cover;
            }

            .san-title {
                /*                text-align: center;*/
                padding: 15px;
            }

            .san-title h3 {
                text-align: center;
                margin: 10px 0;
            }


            .san-button {
                text-align: center;
                padding-bottom: 20px;
            }
            .san-button-s {
                margin-top: 15px;
                padding: 10px 20px;
                background-color: #003366;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                text-align: center;
            }


            .featured-box {
                width: 300px;
                border-radius: 15px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
                overflow: hidden;
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: white;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="logo">
                <img src="./images/logo/Badminton.jpg" alt="Logo" />
            </div>
            <div class="auth-links">
                <a href="login.jsp">Đăng Nhập</a> 
                <a href="#">Đăng Ký</a>
            </div>
        </div>

        <div class="nav-bar">
            <a href="#">Trang Chủ</a>
            <a href="#">Danh Sách Sân Bãi</a>
            <a href="#">Giới Thiệu</a>
            <a href="#">Điều Khoản</a>
            <a href="#">Danh Sách Chủ Sân</a>
            <a href="#">Liên Hệ</a>
        </div>

        <div class="search-area">
            <div class="search-title">HỆ THỐNG HỖ TRỢ TÌM KIẾM SÂN BÃI NHANH</div>

            <div class="search-form">
                <input type="text" placeholder="Nhập khu vực">
                <button>Tìm Kiếm</button>
            </div>
        </div>

        <form action="action">
            <div class="featured">
                <div class="featured-box">
                    <div class="logo-san">
                        <img src="./images/san/san.jpg" alt="Logo" />
                    </div>
                    <div class="san-title">
                        <h3>SAN A</h3>
                        <h5>Địa Chỉ</h5>
                        <h5>Số Điện Thoại</h5>
                    </div>
                    <div class="san-button">
                        <button class="san-button-s">Chi Tiết</button>
                    </div>
                </div>
                <div class="featured-box">
                    <div class="logo-san">
                        <img src="./images/san/san.jpg" alt="Logo" />
                    </div>
                    <div class="san-title">
                        <h3>SAN B</h3>
                        <h5>Địa Chỉ</h5>
                        <h5>Số Điện Thoại</h5>
                    </div>
                    <div class="san-button">
                        <button class="san-button-s">Chi Tiết</button>
                    </div>
                </div>
                <div class="featured-box">
                    <div class="logo-san">
                        <img src="./images/san/san.jpg" alt="Logo" />
                    </div>
                    <div class="san-title">
                        <h3>SAN C</h3>
                        <h5>Địa Chỉ</h5>
                        <h5>Số Điện Thoại</h5>
                    </div>
                    <div class="san-button">
                        <button type="button" class="san-button-s" >Chi Tiết</button>
                    </div>
                </div>
            </div>
        </form>

        <jsp:include page="homefooter.jsp" />
    </body>
</html>

