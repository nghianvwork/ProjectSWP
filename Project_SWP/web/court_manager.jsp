<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sân Cầu Lông</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
</head>
<body class="bg-light">
<div class="container py-4">
    <h1 class="text-center mb-4">Quản Lý Sân Cầu Lông</h1>

    <!-- Nút mở modal thêm sân -->
    <div class="mb-4">
        <button class="btn btn-primary" data-toggle="modal" data-target="#courtModal">Thêm Sân</button>
    </div>

    <!-- Modal thêm/sửa sân -->
    <div class="modal fade" id="courtModal" tabindex="-1" aria-labelledby="courtModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="courtModalLabel">${court != null ? 'Sửa Sân' : 'Thêm Sân'}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="courtForm" action="courts" method="post">
                        <input type="hidden" name="action" value="${court != null ? 'update' : 'add'}">
                        <input type="hidden" name="courtId" value="${court != null ? court.courtId : ''}">
                        <div class="form-group">
                            <label for="courtNumber">Mã Sân</label>
                            <input type="text" class="form-control" id="courtNumber" name="courtNumber" value="${court != null ? court.courtNumber : ''}" required>
                        </div>
                        <div class="form-group">
                            <label for="status">Trạng Thái</label>
                            <input type="text" class="form-control" id="status" name="status" value="${court != null ? court.status : ''}" required>
                        </div>
                        <div class="form-group">
                            <label for="areaId">Khu Vực ID</label>
                            <input type="number" class="form-control" id="areaId" name="areaId" value="${court != null ? court.areaId : ''}" required>
                        </div>
                        <button type="submit" class="btn btn-primary">${court != null ? 'Cập Nhật' : 'Lưu'}</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bảng hiển thị sân -->
    <div class="card">
        <div class="card-header">
            <h4 class="mb-0">Danh Sách Sân</h4>
        </div>
        <div class="card-body">
            <table class="table table-bordered table-hover">
                <thead class="thead-light">
                <tr>
                    <th>Mã Sân</th>
                    <th>Số Sân</th>
                    <th>Trạng Thái</th>
                    <th>Khu Vực ID</th>
                    <th>Hành Động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="court" items="${courts}">
                    <tr>
                        <td>${court.courtId}</td>
                        <td>${court.courtNumber}</td>
                        <td>${court.status}</td>
                        <td>${court.areaId}</td>
                        <td>
                            <a href="courts?action=edit&courtId=${court.courtId}" class="btn btn-sm btn-warning">Sửa</a>
                            <button class="btn btn-sm btn-danger delete-btn" data-id="${court.courtId}">Xóa</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

<script>
    // Xử lý nút xóa
    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function () {
            if (confirm('Bạn có chắc muốn xóa sân này?')) {
                const courtId = this.getAttribute('data-id');
                fetch('courts', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: `action=delete&courtId=${courtId}`
                }).then(() => location.reload());
            }
        });
    });
</script>
</body>
</html>