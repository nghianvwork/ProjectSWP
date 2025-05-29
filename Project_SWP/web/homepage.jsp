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
            gap: 20px;
        }

        .auth-links a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
            transition: color 0.3s;
        }

        .auth-links a:hover {
            color: #2d6db6;
        }

        .nav-bar {
            background-color: #2d6db6;
            padding: 12px 0;
            text-align: center;
        }

        .nav-bar a {
            color: white;
            margin: 0 15px;
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            transition: text-decoration 0.3s;
        }

        .nav-bar a:hover {
            text-decoration: underline;
        }

        .search-area {
            text-align: center;
            padding: 40px 20px;
            background-color: #e0e0e0;
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
    </style>
</head>
<body>
    <div class="header">
        <div class="logo">
            <img src="./images/logo/Badminton.jpg" alt="Logo" />
        </div>
        <div class="auth-links">
            <a href="login.jsp">Đăng Nhập</a> 
            <a href="register.jsp">Đăng Ký</a>
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
