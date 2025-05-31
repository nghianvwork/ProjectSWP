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
                background-color: #f4f4f4;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #ffffff;
                padding: 10px 20px;
                border-bottom: 1px solid #ccc;
            }

            .logo img {
                width: 50px;
                height: 50px;
            }

            .auth-links {
                display: flex;
                gap: 12px;
            }

            .auth-links .auth-btn {
                text-decoration: none;
                font-weight: 600;
                color: #0b3b8c;
                padding: 6px 14px;
                border: 1px solid transparent;
                border-radius: 5px;
                transition: 0.3s;
            }

            .auth-links .auth-btn:hover {
                background-color: #d8e7ff;
                border-color: #0b3b8c;
            }

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

            .search-area {
                text-align: center;
                padding: 40px 20px;
            }

            .search-title {
                font-size: 26px;
                font-weight: bold;
                margin-bottom: 20px;
            }

            .search-form {
                display: flex;
                justify-content: center;
                gap: 10px;
                flex-wrap: wrap;
            }

            .search-form input {
                padding: 10px;
                font-size: 16px;
                width: 250px;
            }

            .search-form button {
                background-color: #ffcc00;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .search-form button:hover {
                background-color: #e6b800;
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
        <div class="header">
            <div class="logo">
                <img src="./images/logo/Badminton.jpg" alt="Logo" />
            </div>
            <div class="auth-links">
                <a href="login.jsp" class="auth-btn">Đăng Nhập</a>
                <a href="register.jsp" class="auth-btn">Đăng Ký</a>
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

        <div class="featured">
            <div class="featured-box">
                <div class="logo-san">
                    <img src="./images/san/san.jpg" alt="Sân A" />
                </div>
                <div class="san-title">
                    <h3>SAN A</h3>
                    <h5>123 Đường ABC, Quận 1</h5>
                    <h5>0909 123 456</h5>
                </div>
                <div class="san-button">
                    <button class="san-button-s">Chi Tiết</button>
                </div>
            </div>

            <div class="featured-box">
                <div class="logo-san">
                    <img src="./images/san/san.jpg" alt="Sân B" />
                </div>
                <div class="san-title">
                    <h3>SAN B</h3>
                    <h5>456 Đường DEF, Quận 5</h5>
                    <h5>0912 345 678</h5>
                </div>
                <div class="san-button">
                    <button class="san-button-s">Chi Tiết</button>
                </div>
            </div>

            <div class="featured-box">
                <div class="logo-san">
                    <img src="./images/san/san.jpg" alt="Sân C" />
                </div>
                <div class="san-title">
                    <h3>SAN C</h3>
                    <h5>789 Đường XYZ, Quận 7</h5>
                    <h5>0987 654 321</h5>
                </div>
                <div class="san-button">
                    <button class="san-button-s">Chi Tiết</button>
                </div>
            </div>
        </div>

        <jsp:include page="homefooter.jsp" />
    </body>
</html>
