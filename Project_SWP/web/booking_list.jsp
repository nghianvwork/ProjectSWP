<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách đặt sân</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f5f5f5; }
        .main { max-width: 1200px; margin: 2rem auto; padding: 0 2rem; }
        .title { text-align: center; margin-top: 2rem; }
        .table { background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .table th { background-color: #ff4757; color: white; }
        .nav {
            background: white;
            padding: 1rem 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            display: flex;
            gap: 2rem;
        }

        .nav-item {
            padding: 0.5rem 1.5rem;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s;
            background: #f8f9fa;
            color: #333;
            
        }

        .nav-item.active {
            background: #ff4757;                   
        }
        
        .nav-item.active a {
            text-decoration: none;
            color: white;
        }

        .nav-item:hover {
            background: #ff6b7a;
            color: white;
        }
        
        .nav-item a{
            color: black;
            text-decoration: none;
        }        

    </style>
</head>
<body>

<!-- Header -->
<header class="header bg-danger text-white py-3 shadow-sm">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="logo fs-3 fw-bold">🏸 BadmintonCourt</div>
        
    </div>
</header>

<!-- Nav -->
<nav class="nav">
        <div class="nav-container">
            <div class="nav-item "><a href="homepage.jsp">Trang Chủ</a></div>
            <div class="nav-item"><a href="listCourt.jsp">Danh Sách Sân Bãi</a></div>
              <div class="nav-item"><a href="booking_list.jsp">Danh sách đặt sân</a></div>
            <div class="nav-item"><a href="#">Điều Khoản</a></div>
            <div class="nav-item"><a href="#">Danh Sách Chủ Sân</a></div>
            <div class="nav-item">Liên Hệ</div>
        </div>
    </nav>


<!-- Main -->
<main class="main">
    <div class="title">
        <h2>Đơn đặt sân của bạn</h2>
    </div>

    <div class="table-responsive mt-4">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Sân</th>
                    <th>Ngày</th>
                    <th>Thời gian</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="booking" items="${bookings}">
                    <tr>
                        <td>${booking.court_name}</td>
                        <td>${booking.date}</td>
                        <td>${booking.startTime} - ${booking.endTime}</td>
                        <td>${booking.status}</td>
                        <td>
                            <c:if test="${booking.status eq 'confirmed'}">
                                <form action="cancel-booking" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn hủy?');">
                                    <input type="hidden" name="bookingId" value="${booking.booking_id}">
                                    <button type="submit" class="btn btn-danger btn-sm">Hủy</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</main>

<!-- Footer -->
<footer class="footer bg-dark text-light mt-5 py-4">
    <div class="container d-grid gap-4" style="grid-template-columns: repeat(auto-fit, minmax(200px, 1fr))">
        <div>
            <h5 class="text-danger">Về BadmintonCourt</h5>
            <ul class="list-unstyled">
                <li><a href="#" class="text-light text-decoration-none">Giới thiệu</a></li>
                <li><a href="#" class="text-light text-decoration-none">Tuyển dụng</a></li>
                <li><a href="#" class="text-light text-decoration-none">Liên hệ</a></li>
                <li><a href="#" class="text-light text-decoration-none">Tin tức</a></li>
            </ul>
        </div>
        <div>
            <h5 class="text-danger">Dịch vụ</h5>
            <ul class="list-unstyled">
                <li><a href="#" class="text-light text-decoration-none">Đặt sân online</a></li>
                <li><a href="#" class="text-light text-decoration-none">Thiết bị cầu lông</a></li>
            </ul>
        </div>
        <div>
            <h5 class="text-danger">Hỗ trợ</h5>
            <ul class="list-unstyled">
                <li><a href="#" class="text-light text-decoration-none">Hướng dẫn đặt sân</a></li>
                <li><a href="#" class="text-light text-decoration-none">Chính sách hoàn tiền</a></li>
                <li><a href="#" class="text-light text-decoration-none">Câu hỏi thường gặp</a></li>
                <li>Hotline: <span class="text-danger fw-bold">1900-8386</span></li>
            </ul>
        </div>
        <div>
            <h5 class="text-danger">Kết nối</h5>
            <ul class="list-unstyled">
                <li><a href="#" class="text-light text-decoration-none">📘 Facebook</a></li>
                <li><a href="#" class="text-light text-decoration-none">📷 Instagram</a></li>
                <li><a href="#" class="text-light text-decoration-none">🐦 Twitter</a></li>
                <li><a href="#" class="text-light text-decoration-none">📺 YouTube</a></li>
            </ul>
        </div>
    </div>
    <div class="text-center pt-3 border-top mt-4 text-secondary">
        &copy; 2025 BadmintonCourt. Thế giới cầu lông.
    </div>
</footer>

</body>
</html>
