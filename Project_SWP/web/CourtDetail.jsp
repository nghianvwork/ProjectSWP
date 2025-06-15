<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sân cầu lông Panda Badminton</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f5f5;
                color: #333;
                line-height: 1.6;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            .header {
                background: white;
                border-radius: 12px;
                padding: 24px;
                /*margin-bottom: 20px;*/
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .court-title {
                font-size: 24px;
                font-weight: 700;
                color: #2c3e50;
                margin-bottom: 12px;
            }

            .location {
                display: flex;
                align-items: center;
                color: #666;
                font-size: 14px;
                margin-bottom: 16px;
            }

            .location::before {
                content: "📍";
                margin-right: 8px;
            }

            .rating {
                display: flex;
                align-items: center;
                gap: 8px;
                float: right;
                margin-top: -40px;
            }

            .rating-score {
                background: #ff6b35;
                color: white;
                padding: 4px 8px;
                border-radius: 6px;
                font-weight: 600;
                font-size: 14px;
            }

            .rating-stars {
                color: #ffc107;
                font-size: 16px;
            }

            .main-content {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 20px;
            }

            .gallery {
                background: white;
                border-radius: 12px;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .main-image {
                width: 100%;
                height: 300px;
                border-radius: 8px;
                object-fit: cover;
                margin-bottom: 16px;
            }

            .thumbnail-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 12px;
            }

            .thumbnail {
                width: 100%;
                height: 120px;
                border-radius: 6px;
                object-fit: cover;
                cursor: pointer;
                transition: transform 0.2s ease;
            }

            .thumbnail:hover {
                transform: scale(1.05);
            }

            .more-photos {
                position: relative;
                background: rgba(0, 0, 0, 0.7);
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 600;
                cursor: pointer;
            }

            .info-panel {
                background: white;
                border-radius: 12px;
                padding: 24px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                height: fit-content;
            }

            .info-section {
                margin-bottom: 24px;
            }

            .info-title {
                background: #fff3cd;
                color: #856404;
                padding: 8px 16px;
                border-radius: 6px;
                font-weight: 600;
                margin-bottom: 16px;
                font-size: 14px;
            }

            .info-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 0;
                border-bottom: 1px solid #eee;
            }

            .info-row:last-child {
                border-bottom: none;
            }

            .info-label {
                color: #666;
                font-size: 14px;
            }

            .info-value {
                font-weight: 600;
                color: #2c3e50;
            }

            .price {
                color: #e74c3c;
                font-size: 16px;
                font-weight: 700;
            }

            .services {
                margin-top: 24px;
            }

            .service-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 12px;
            }

            .service-item {
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 14px;
                color: #555;
            }

            .service-icon {
                width: 16px;
                height: 16px;
                color: #28a745;
            }

            .book-button {
                width: 100%;
                background: linear-gradient(135deg, #ff6b35, #f7931e);
                color: white;
                border: none;
                padding: 16px;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: transform 0.2s ease;
                margin-top: 20px;
            }

            .book-button:hover {
                transform: translateY(-2px);
            }

            @media (max-width: 768px) {
                .main-content {
                    grid-template-columns: 1fr;
                }

                .rating {
                    float: none;
                    margin-top: 0;
                }

                .thumbnail-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="homehead.jsp" />
        
        <div class="container">

            <div class="main-content">
                <div class="gallery">
                    <img src="https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=800&h=300&fit=crop" alt="Sân cầu lông chính" class="main-image">

                    <div class="thumbnail-grid">
                        <img src="https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=800&h=300&fit=crop" alt="Sân cầu lông 1" class="thumbnail">
                        <img src="https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=800&h=300&fit=crop" alt="Sân cầu lông 2" class="thumbnail">
                        <img src="https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=800&h=300&fit=crop" alt="Sân cầu lông 2" class="thumbnail">

                    </div>
                </div>

                <div class="info-panel">
                    <div class="info-section">
                        <div class="info-title">📋 Thông tin sân</div>

                        <div class="info-row">
                            <span class="info-label">Giờ mở cửa:</span>
                            <span class="info-value">6h - 23h</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Số sân thi đấu:</span>
                            <span class="info-value">4 Sân</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Giá sân:</span>
                            <span class="info-value price">120.000 đ</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Giá sân giờ vàng:</span>
                            <span class="info-value price">120.000 đ</span>
                        </div>
                    </div>

                    <div class="services">
                        <div class="info-title">🛎️ Dịch vụ tiện ích</div>

                        <div class="service-grid">
                            <div class="service-item">
                                <span class="service-icon">📶</span>
                                <span>Wifi</span>
                            </div>
                            <div class="service-item">
                                <span class="service-icon">🚗</span>
                                <span>Bãi đỗ xe oto</span>
                            </div>
                            <div class="service-item">
                                <span class="service-icon">🏍️</span>
                                <span>Bãi đỗ xe máy</span>
                            </div>
                            <div class="service-item">
                                <span class="service-icon">🍽️</span>
                                <span>Đồ ăn</span>
                            </div>
                            <div class="service-item">
                                <span class="service-icon">💧</span>
                                <span>Nước uống</span>
                            </div>
                        </div>
                    </div>
                    <!--<button class="book-button">Đặt sân ngay</button>-->
                </div>
            </div>
        </div>
        
        
        <jsp:include page="homefooter.jsp" />

    </body>
</html>