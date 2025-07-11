<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Sự kiện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header">
            <h3><i class="fas fa-plus-circle"></i> Thêm Sự kiện mới</h3>
        </div>
        <div class="card-body">
            <form action="manage-event?action=create" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="name" class="form-label">Tên sự kiện</label>
                    <input type="text" class="form-control" id="name" name="name" required>
                </div>
                <div class="mb-3">
                    <label for="title" class="form-label">Tiêu đề</label>
                    <input type="text" class="form-control" id="title" name="title" required>
                </div>
                <div class="mb-3">
                    <label for="imageUrl" class="form-label">Hình ảnh</label>
                    <input type="file" class="form-control" id="imageUrl" name="imageUrl">
                </div>
                <div class="mb-3">
                    <label for="areaId" class="form-label">Khu vực</label>
                    <select class="form-select" id="areaId" name="areaId" required>
                        <option value="">-- Chọn khu vực --</option>
                        <c:forEach var="area" items="${areaList}">
                            <option value="${area.area_id}">${area.name} - ${area.location}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="startDate" class="form-label">Ngày bắt đầu</label>
                        <input type="datetime-local" class="form-control" id="startDate" name="startDate" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="endDate" class="form-label">Ngày kết thúc</label>
                        <input type="datetime-local" class="form-control" id="endDate" name="endDate" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="status" class="form-label">Trạng thái</label>
                    <select class="form-select" id="status" name="status">
                        <option value="true">Hoạt động</option>
                        <option value="false">Không hoạt động</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Lưu</button>
                <a href="manage-event" class="btn btn-secondary">Hủy</a>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
