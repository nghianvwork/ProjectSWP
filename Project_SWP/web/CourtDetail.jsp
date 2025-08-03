<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sân cầu lông Panda Badminton</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">



    </head>
    <body>
        <jsp:include page="homehead.jsp" />
        <div class="container my-5">
            <!-- Thông tin khu vực -->
            <div class="bg-white rounded-4 p-4 shadow-sm mb-5">
                <h2 class="mb-3 text-primary fw-bold">🏠 Khu vực: ${area.name}</h2>
                <p><i class="bi bi-geo-alt-fill text-danger me-2"></i><strong>Địa điểm:</strong> ${area.location}</p>
                <p><i class="bi bi-clock-fill text-warning me-2"></i><strong>Giờ mở cửa:</strong> ${area.openTime} - ${area.closeTime}</p>
                <p><i class="bi bi-info-circle-fill text-secondary me-2"></i><strong>Mô tả:</strong> ${area.description}</p>
            </div>

            <!-- Bộ lọc thời gian -->
            <form class="row row-cols-lg-auto g-3 align-items-center mb-4" method="get" action="AreaDetail">
                <input type="hidden" name="area_id" value="${area.area_id}" />
                <div class="col-12">
                    <label class="form-label mb-0" for="date">Ngày:</label>
                    <input type="date" class="form-control" name="date" id="date"
                           value="${date != null ? date : ''}" required />
                </div>
                <div class="col-12">
                    <label class="form-label mb-0" for="fromTime">Từ:</label>
                    <input type="time" class="form-control" name="fromTime" id="fromTime"
                           value="${fromTime != null ? fromTime : ''}" required />
                </div>
                <div class="col-12">
                    <label class="form-label mb-0" for="toTime">Đến:</label>
                    <input type="time" class="form-control" name="toTime" id="toTime"
                           value="${toTime != null ? toTime : ''}" required />
                </div>
                <div class="col-12">
                    <button type="submit" class="btn btn-primary">Lọc sân trống</button>
                </div>
            </form>


            <!-- Danh sách sân -->
            <h4 class="mb-4 text-success fw-semibold">🎯 Danh sách các sân thi đấu</h4>

            <c:if test="${empty courts}">
                <div class="alert alert-warning">Không có sân nào trong khu vực này.</div>
            </c:if>

            <div class="row g-4">
                <c:forEach var="court" items="${courts}">
                    <div class="col-md-4">
                        <div class="card h-100 shadow-sm border-0">
                            <img src="${pageContext.request.contextPath}/${court.image_url}" class="card-img-top" style="height: 200px; object-fit: cover;" alt="Ảnh sân ${court.court_number}">
                            <div class="card-body d-flex flex-column justify-content-between">
                                <div>
                                    <h5 class="card-title fw-bold">Sân ${court.court_number}</h5>
                                    <ul class="list-unstyled mb-3 small text-muted">
                                        <li>🔸 <strong>Loại:</strong> ${court.type}</li>
                                        <li>🔹 <strong>Sàn:</strong> ${court.floor_material}</li>
                                        <li>💡 <strong>Đèn:</strong> ${court.lighting}</li>
                                        <li>📍 <strong>Trạng thái:</strong> ${court.status}</li>
                                    </ul>
                                </div>
                                <a href="book-field?courtId=${court.court_id}" class="btn btn-warning w-100 fw-semibold">⚡ Đặt ngay</a>

                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <h4 class="mt-5 text-success fw-semibold">Đánh giá của người dùng</h4>
            <c:if test="${empty reviews}">
                <p class="text-muted">Chưa có đánh giá.</p>
            </c:if>
            <c:forEach var="rv" items="${reviews}">
                <div class="border rounded p-3 mb-3">
                    <div class="fw-bold">${rv.username} - ${rv.rating}★</div>
                    <div>${rv.comment}</div>
                    <div class="text-end small text-muted">${rv.created_at}</div>
                </div>
            </c:forEach>
        </div>



        <jsp:include page="homefooter.jsp" />

    </body>

</html>