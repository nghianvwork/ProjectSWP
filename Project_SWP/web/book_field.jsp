<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt sân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Đặt sân: ${court.court_number}</h2>
    <c:if test="${not empty message}">
        <div class="alert alert-danger">${message}</div>
    </c:if>
    <form action="book-field" method="post">
        <input type="hidden" name="courtId" value="${court.court_id}" />
        <div class="mb-3">
            <label>Chọn ngày:</label>
            <input type="date" name="date" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Giờ bắt đầu:</label>
            <input type="time" name="startTime" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Giờ kết thúc:</label>
            <input type="time" name="endTime" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">Kiểm tra & Xác nhận</button>
    </form>
</div>
</body>
</html>
