<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BadmintonCourt - Đặt Sân Cầu Lông Online</title>
        <style>

            /* Main Content */
            .main {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 2rem;
            }

            .search-section {
                background: white;
                padding: 2rem;
                border-radius: 15px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
            }

            .search-filters {
                display: grid;
                grid-template-columns: 1fr 200px 200px 200px auto;
                gap: 1rem;
                align-items: end;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
            }

            .filter-group label {
                margin-bottom: 0.5rem;
                font-weight: 500;
                color: #333;
            }

            .filter-group input,
            .filter-group select {
                padding: 0.75rem;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 1rem;
            }

            .search-main-btn {
                background: #ff4757;
                color: white;
                border: none;
                padding: 0.75rem 2rem;
                border-radius: 8px;
                cursor: pointer;
                font-size: 1rem;
                transition: all 0.3s;
            }

            .search-main-btn:hover {
                background: #ff3838;
                transform: translateY(-2px);
            }

            /* Featured Section */
            .featured {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 2rem;
                margin-bottom: 3rem;
            }

            .featured-card {
                background: linear-gradient(135deg, #ffd700, #ffed4e);
                padding: 2rem;
                border-radius: 15px;
                position: relative;
                overflow: hidden;
            }

            .featured-card::after {
                content: "🏸";
                position: absolute;
                right: -10px;
                top: -10px;
                font-size: 8rem;
                opacity: 0.1;
            }

            .featured-card h3 {
                font-size: 1.5rem;
                margin-bottom: 1rem;
                color: #333;
            }


        .court-card:nth-child(2) { animation-delay: 0.1s; }
        .court-card:nth-child(3) { animation-delay: 0.2s; }
        .court-card:nth-child(4) { animation-delay: 0.3s; }
    </style>
</head>
<body>
    
    <!-- Header -->
    <header class="header">
        <div class="header-container">
            <div class="logo">BadmintonCourt</div>
            <div class="search-bar">
                <input type="text" placeholder="Tìm sân cầu lông...">
                <button class="search-btn">Tìm</button>
            </div>
           <div class="header-actions">
                    
                    <span>
                        <a href="viewprofile.jsp" class="header-btn"></a>
                    </span>
                    <a href="homepage.jsp" class="header-btn">Thoát</a>
                </div>
        </div>
    </header>

    <!-- Navigation -->
    <nav class="nav">
        <div class="nav-container">
            <div class="nav-item"><a href="homepage.jsp">Trang Chủ</a></div>
            <div class="nav-item active"><a href="listCourt.jsp">Danh Sách Sân Bãi</a></div>
              <div class="nav-item"><a href="booking_list.jsp">Danh sách đặt sân</a></div>
            <div class="nav-item"><a href="#">Điều Khoản</a></div>
            <div class="nav-item"><a href="#">Danh Sách Chủ Sân</a></div>
            <div class="nav-item">Liên Hệ</div>
        </div>
    </nav>

          


        <jsp:include page="homehead.jsp" />

        <!-- Main Content -->
        <main class="main">

            <!-- Search Section -->
            <div class="search-section">
                <div class="search-filters">
                    <div class="filter-group">
                        <label>Tìm sân</label>
                        <input type="text" placeholder="Nhập tên sân hoặc địa điểm...">
                    </div>
                    <div class="filter-group">
                        <label>Khu vực</label>
                        <select>
                            <option>Tất cả</option>
                            <option>Hà Nội</option>
                            <option>TP. Hồ Chí Minh</option>
                            <option>Đà Nẵng</option>
                            <option>Hải Phòng</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label>Mức giá</label>
                        <select>
                            <option>Tất cả</option>
                            <option>50k - 100k</option>
                            <option>100k - 200k</option>
                            <option>200k - 300k</option>
                            <option>Trên 300k</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label>Thời gian</label>
                        <select>
                            <option>Tất cả</option>
                            <option>Sáng (6h-12h)</option>
                            <option>Chiều (12h-18h)</option>
                            <option>Tối (18h-22h)</option>
                        </select>
                    </div>
                    <div>
                        <button class="search-main-btn">🔍 Tìm sân</button>
                    </div>
                </div>
            </div>

            <!-- Featured Section -->
            <div class="featured">
                <div class="featured-card">
                    <h3>Có 8.386 Sân cầu lông</h3>
                    <p>Đa dạng các sân cầu lông chất lượng cao trên toàn quốc</p>
                    <button class="featured-btn">Đăng ký ngay</button>
                </div>
                <div class="featured-card pricing-card">
                    <h3>Dụng cụ chất lượng cao</h3>
                    <p>Dịch vụ thuê dụng cụ cầu lông chất lượng</p>
                    <button class="featured-btn">Thuê ngay</button>
                </div>
            </div>

            <!-- Courts Grid -->
          <div class="courts-grid">
    <c:forEach var="area" items="${areaList}">
        <div class="court-card">
            <div class="logo-san">
                <img src="images/san/san.jpg" alt="${area.name}" />
            </div>
            <div class="court-info">
                <div class="court-name">${area.name}</div>
                <div class="court-location">${area.location}</div>
                <p>Giờ mở cửa: ${area.openTime} - ${area.closeTime}</p>
                <p>${area.description}</p>
                <form action="areaDetail" method="get">
                    <input type="hidden" name="area_id" value="${area.area_id}" />
                    <button type="submit" class="book-btn">Xem chi tiết</button>
                </form>
            </div>
        </div>
    </c:forEach>
</div>
        </main>

        <jsp:include page="homefooter.jsp" />
    </body>
</html>