<%-- 
    Document   : homepageUser
    Created on : May 26, 2025, 10:48:19 PM
    Author     : sangn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                flex-wrap: wrap;
                gap: 30px;
                padding: 30px 20px;
            }

            .featured-box {
                width: 300px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                overflow: hidden;
                background-color: white;
                transition: transform 0.3s;
            }

            .featured-box:hover {
                transform: translateY(-5px);
            }

            .logo-san img {
                width: 100%;
                height: 180px;
                object-fit: cover;
            }

            .san-title {
                padding: 15px;
                text-align: center;
            }

            .san-title h3 {
                margin-bottom: 10px;
                color: #2d6db6;
            }

            .san-title h5 {
                margin: 5px 0;
                font-weight: normal;
                color: #555;
            }

            .san-button {
                text-align: center;
                padding: 15px;
            }

            .san-button-s {
                background-color: #003366;
                color: white;
                padding: 10px 25px;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .san-button-s:hover {
                background-color: #0055aa;
            }

            .single_slider {
                background-image: url('./images/logo/hinh_nen.jpg');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                height: 100vh;
                position: relative;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
            }

            .slider_content {
                text-align: center;
                color: white;
                /*background-color: rgba(0, 0, 0, 0.5);  nền đen mờ */
                padding: 20px 30px;
                border-radius: 12px;
            }

            .slider_content h1 {
                font-size: 40px;
                margin-bottom: 20px;
            }

            .slider_content p {
                font-size: 18px;
                margin-bottom: 30px;
            }

            .slider_content a {
                display: inline-block;
                padding: 12px 30px;
                background-color: white;
                color: black;
                text-decoration: none;
                font-weight: bold;
                border-radius: 30px;
                transition: background 0.3s;
            }

            .slider_content a:hover {
                background-color: #ddd;
            }
        </style>
    </head>
    <body>
        <jsp:include page="homehead.jsp" />

        <div class="single_slider" style="background-image: url('./images/logo/san.jpg');">
            <div class="slider_content">
                <div class="slider_content_inner">  
                    <!--                    <h1>Badminton</h1>
                                        <p>Sự lựa chọn hàng đầu</p>-->
                </div>     
            </div>    
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
