<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách người tham gia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header">
            <h3><i class="fas fa-users"></i> Người tham gia sự kiện: ${event.name}</h3>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>ID Người dùng</th>
                            <th>Tên người dùng</th>
                            <th>Thời gian đăng ký</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${participants}">
                            <tr>
                                <td>${p.user.user_Id}</td>
                                <td>${p.user.fullname}</td>
                                <td><fmt:formatDate value="${p.registeredAt}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty participants}">
                            <tr>
                                <td colspan="3" class="text-center">Chưa có ai đăng ký tham gia sự kiện này.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            <a href="manage-event" class="btn btn-secondary mt-3">Quay lại danh sách</a>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
