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
                max-width: 1200px;
                margin-bottom: 30px;
                background: white;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 30px;
            }

            .search-filters {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 24px;
                align-items: end;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

            .filter-group label {
                font-weight: 600;
                color: #2c3e50;
                font-size: 14px;
                margin-bottom: 4px;
            }

            .filter-group select {
                width: 100%;
                padding: 12px 16px;
                border: 2px solid #e1e8ed;
                border-radius: 8px;
                font-size: 15px;
                color: #2c3e50;
                background: white;
                cursor: pointer;
                transition: all 0.3s ease;
                appearance: none;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
                background-position: right 12px center;
                background-repeat: no-repeat;
                background-size: 16px;
                padding-right: 40px;
            }

            .filter-group select:focus {
                outline: none;
                border-color: #3498db;
                box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            }

            .filter-group select:hover {
                border-color: #bdc3c7;
            }

            /* Responsive design */
            @media (max-width: 768px) {
                .search-filters {
                    grid-template-columns: 1fr;
                    gap: 20px;
                }

                .search-section {
                    padding: 20px;
                    margin: 10px;
                }
            }

            @media (min-width: 769px) and (max-width: 1024px) {
                .search-filters {
                    grid-template-columns: repeat(2, 1fr);
                }
            }

            @media (min-width: 1025px) {
                .search-filters {
                    grid-template-columns: repeat(3, 1fr);
                }
            }

            /* Hiệu ứng loading khi hover */
            .filter-group select:active {
                transform: translateY(1px);
            }

            /* Style cho option */
            .filter-group select option {
                padding: 8px;
                color: #2c3e50;
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

            .featured-card p {
                font-size: 1.1rem;
                color: #666;
                margin-bottom: 1.5rem;
            }

            .featured-btn {
                background: #ff4757;
                color: white;
                border: none;
                padding: 0.75rem 1.5rem;
                border-radius: 25px;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.3s;
            }

            .featured-btn:hover {
                background: #ff3838;
                transform: translateY(-2px);
            }

            .pricing-card {
                background: linear-gradient(135deg, #74b9ff, #0984e3);
                color: white;
            }

            .pricing-card::after {
                content: "💰";
            }

            /* Courts Grid */
            .courts-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 2rem;
                margin-top: 2rem;
            }

            .court-card {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                transition: all 0.3s;
            }

            .court-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            }

            .logo-san img {
                width: 100%;
                height: 180px;
                object-fit: cover;
            }

            .court-info {
                padding: 1.5rem;
            }

            .court-info p{
                margin-bottom: 1.5rem;
            }

            .court-name {
                font-size: 1.2rem;
                font-weight: bold;
                margin-bottom: 0.5rem;
                color: #333;
            }

            .court-location {
                color: #666;
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
            }

            .court-location::before {
                content: "📍";
                margin-right: 0.5rem;
            }

            .book-btn {
                width: 100%;
                background: #ff4757;
                color: white;
                border: none;
                padding: 0.75rem;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.3s;
                text-decoration: none;
            }

            .book-btn:hover {
                background: #ff3838;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .header-container {
                    flex-direction: column;
                    gap: 1rem;
                }

                .nav-container {
                    flex-wrap: wrap;
                    gap: 1rem;
                }
            }

            /* Animations */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .court-card {
                animation: fadeInUp 0.6s ease-out;
            }

            .court-card:nth-child(2) {
                animation-delay: 0.1s;
            }
            .court-card:nth-child(3) {
                animation-delay: 0.2s;
            }
            .court-card:nth-child(4) {
                animation-delay: 0.3s;
            }
        </style>
    </head>
    <body>

        <jsp:include page="homehead.jsp" />

        <!-- Main Content -->
        <main class="main">

            <!-- Search Section -->
            <div class="search-section">
                <div class="search-filters">
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
                </div>
            </div>

            <!-- Featured Section -->
            <div class="featured">
                <div class="featured-card">
                    <h3>Có ${areaList.size()} Khu vực sân cầu lông</h3>
                    <p>Đa dạng các sân cầu lông chất lượng cao trên toàn quốc</p>
                    <button class="featured-btn">Đăng ký ngay</button>
                </div>
                <div class="featured-card pricing-card">
                    <h3>Dụng cụ chất lượng cao</h3>
                    <p>Dịch vụ thuê dụng cụ cầu lông chất lượng</p>
                    <button class="featured-btn">Thuê ngay</button>
                </div>
            </div>


            <div class="courts-grid">
                <c:forEach var="area" items="${areaList}">
                    <div class="court-card">
                        <div class="logo-san">
                            <img src="          " alt="${area.name}" />
                        </div>
                        <div class="court-info">
                            <div class="court-name">${area.name}</div>
                            <div class="court-location">${area.location}</div>
                            <p>Giờ mở cửa: ${area.openTime} - ${area.closeTime}</p>
                            <p>Mô tả: ${area.description}</p>
                            <a href="AreaDetail?area_id=${area.area_id}" class="book-btn btn" >Xem chi tiết</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </main>

        <jsp:include page="homefooter.jsp" />
    </body>
</html>