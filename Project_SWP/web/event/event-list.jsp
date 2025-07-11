<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Sự kiện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<!-- Thanh điều hướng -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Quản lý</a>
        <div class="d-flex">
            <a class="nav-link text-light" href="login">Đăng xuất</a>
        </div>
    </div>
</nav>

<div class="container-fluid mt-4">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-2">
            <jsp:include page="../Sidebar.jsp" />
        </div>

        <!-- Nội dung chính -->
        <div class="col-md-10">
            <div class="container py-4">
                <!-- Thông báo thành công/lỗi -->
                <c:if test="${param.success == 'email_sent'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> <strong>Thành công!</strong> 
                        Đã gửi email mời tham gia cho ${param.count}/${param.total} người dùng.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <c:if test="${param.error == 'event_not_found'}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> <strong>Lỗi!</strong> 
                        Không tìm thấy sự kiện!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <c:if test="${param.error == 'no_users_found'}">
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle"></i> <strong>Cảnh báo!</strong> 
                        Không tìm thấy người dùng nào để gửi email!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <c:if test="${param.error == 'send_email_failed'}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> <strong>Lỗi!</strong> 
                        Gửi email thất bại!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0"><i class="fas fa-calendar-alt"></i> Quản lý Sự kiện</h2>
                    <a href="manage-event?action=add" class="btn btn-success">
                        <i class="fas fa-plus-circle"></i> Thêm Sự kiện
                    </a>
                </div>

                <!-- Bộ lọc / Tìm kiếm -->
                <form action="manage-event" method="get" class="row mb-3 g-2">
                    <div class="col-md-8">
                        <input type="text" name="keyword" value="${param.keyword}" class="form-control" placeholder="Tìm theo tên sự kiện...">
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary w-100"><i class="fas fa-search"></i> Tìm kiếm</button>
                    </div>
                </form>

                <div class="card shadow-sm">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover mb-0 align-middle text-center">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên Sự kiện</th>
                                        <th>Tiêu đề</th>
                                        <th>Ngày bắt đầu</th>
                                        <th>Ngày kết thúc</th>
                                        <th>Khu vực</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="event" items="${eventList}">
                                        <tr>
                                            <td>${event.eventId}</td>
                                            <td class="text-start">${event.name}</td>
                                            <td class="text-start">${event.title}</td>
                                            <td><fmt:formatDate value="${event.startDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                            <td><fmt:formatDate value="${event.endDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty event.areaName}">
                                                        ${event.areaName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Chưa có</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${event.status}">
                                                        <span class="badge bg-success">Hoạt động</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Không hoạt động</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="manage-event?action=participants&id=${event.eventId}" class="btn btn-info btn-sm">
                                                    <i class="fas fa-users"></i> Xem
                                                </a>
                                                <a href="manage-event?action=edit&id=${event.eventId}" class="btn btn-warning btn-sm">
                                                    <i class="fas fa-edit"></i> Sửa
                                                </a>
                                                <a href="manage-event?action=sendEmail&id=${event.eventId}" class="btn btn-success btn-sm"
                                                   onclick="return confirm('Bạn có chắc chắn muốn gửi email mời tham gia cho tất cả người dùng?')">
                                                    <i class="fas fa-envelope"></i> Gửi Email
                                                </a>
                                                <a href="manage-event?action=delete&id=${event.eventId}" class="btn btn-danger btn-sm"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xoá sự kiện này không?')">
                                                    <i class="fas fa-trash"></i> Xoá
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Phân trang -->
                    <div class="card-footer bg-white">
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center mb-0">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="manage-event?page=${currentPage - 1}&keyword=${param.keyword}">&laquo;</a>
                                    </li>
                                </c:if>
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="manage-event?page=${i}&keyword=${param.keyword}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="manage-event?page=${currentPage + 1}&keyword=${param.keyword}">&raquo;</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
