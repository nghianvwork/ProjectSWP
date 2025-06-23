<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đặt sân</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: #f5f6fa;
                font-family: 'Segoe UI', sans-serif;
            }
            .booking-container {
                max-width: 600px;
                background: #fff;
                padding: 2rem;
                margin: 3rem auto;
                border-radius: 15px;
                box-shadow: 0 8px 24px rgba(0,0,0,0.1);
            }
            .booking-title {
                font-size: 1.8rem;
                font-weight: bold;
                color: #2f3542;
                margin-bottom: 1.5rem;
            }
            label {
                font-weight: 500;
                margin-bottom: 0.5rem;
                color: #34495e;
            }
            .form-control {
                border-radius: 8px;
            }
            .btn-primary {
                background-color: #ff4757;
                border-color: #ff4757;
                padding: 0.5rem 1.5rem;
                font-weight: 500;
            }
            .btn-primary:hover {
                background-color: #ff6b81;
                border-color: #ff6b81;
            }
            .slot-button {
                margin: 5px 5px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="homehead.jsp" />
        <div class="container booking-container">
            <h2 class="booking-title">Đặt sân: ${court.court_number}</h2>

            <c:if test="${not empty message}">
                <div class="alert alert-danger">${message}</div>
            </c:if>

            <!-- Form GET: chỉ để chọn lại ngày -->
            <form action="book-field" method="get" id="dateForm">
                <input type="hidden" name="courtId" value="${court.court_id}" />
                <div class="mb-3">
                    <label for="date">Chọn ngày</label>
                    <input type="date" id="dateInput" name="date"
                           value="${selectedDate}"
                           min="<%= java.time.LocalDate.now().toString() %>"
                           required
                           onchange="document.getElementById('dateForm').submit();" />
                </div>
            </form>

            <!-- Form POST: chọn ca để đặt sân -->
            <form action="book-field" method="post">
                <input type="hidden" name="courtId" value="${court.court_id}" />
                <input type="hidden" name="date" value="${selectedDate}" />
                <div class="mb-3">
                    <label class="form-label">Chọn ca chơi:</label>
                    <div class="d-flex flex-wrap gap-2">
                        <c:forEach var="slot" items="${slots}">
    <c:if test="${slot.available}">
        <form action="book-field" method="post" style="display:inline;">
            <input type="hidden" name="courtId" value="${court.court_id}" />
            <input type="hidden" name="date" value="${selectedDate}" />
            <input type="hidden" name="startTime" value="${slot.start}" />
            <input type="hidden" name="endTime" value="${slot.end}" />
            <button type="submit" class="btn btn-success btn-sm slot-button">
                ${slot.start} - ${slot.end}
            </button>
        </form>
    </c:if>
    <c:if test="${!slot.available}">
        <button type="button" class="btn btn-secondary btn-sm slot-button" disabled>
            ${slot.start} - ${slot.end}
        </button>
    </c:if>
</c:forEach>

                    </div>
                </div>
            </form>

        </div>
        <jsp:include page="homefooter.jsp" />
    </body>
</html>
