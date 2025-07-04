<%-- 
    Document   : homepageUser
    Created on : May 26, 2025, 10:48:19 PM
    Author     : sangn
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Hệ thống tìm kiếm sân bãi</title>
        <style>
            .main {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 2rem;
            }

            .banner-slider {
                position: relative;
                width: 100%;
                max-width: 900px;
                margin: 0 auto;
            }
            .banner-slide {
                display: none;
                position: absolute;
                width: 100%;
            }
            .banner-slide.active {
                display: block;
            }
            .banner-caption {
                position: absolute;
                bottom: 20px;
                left: 30px;
                background: rgba(0,0,0,0.4);
                color: #fff;
                padding: 10px 20px;
                border-radius: 5px;
            }
            
            .title {
                text-align: center;
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
            
            .court-info p{
                margin-bottom: 0.5rem;
            }

            .court-info {
                padding: 1.5rem;
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
            }

            .book-btn:hover {
                background: #ff3838;
            }
        </style>
    </head>
    <body>
        <jsp:include page="homehead.jsp" />

        <main class="main">

            <div class="banner-slider" style="height: 350px;">
                <c:forEach var="banner" items="${bannerList}">
                    <div class="banner-slide">
                        <img src="${pageContext.request.contextPath}/${banner.imageUrl}" alt="${banner.title}" style="width:100%;height:350px;object-fit:cover;">
                        <div class="banner-caption">
                            <h2>${banner.title}</h2>
                            <p>${banner.caption}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="title">
                <h1>Danh sách khu vực nổi bật</h1>
            </div>

           <!-- Courts Grid -->
            <div class="courts-grid">
                <c:forEach var="top" items="${listTop3}">
                    <div class="court-card">
                        <div class="court-images">
                            <c:forEach var="img" items="${areaImagesMap[top.area_id]}">
                                <div class="logo-san">
                                    <img src="${pageContext.request.contextPath}/${img.imageURL}" alt="Image ${img.image_id}" />
                                </div>
                            </c:forEach>
                        </div>
                        <div class="court-info">
                            <div class="court-name">${top.name}</div>
                            <div class="court-location">${top.location}</div>
                            <p>Giờ mở cửa: ${top.openTime} - ${top.closeTime}</p>
                            <p>Mô tả: ${top.description}</p>
                            <form action="AreaDetail" method="get">
                                <input type="hidden" name="area_id" value="${top.area_id}" />
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
