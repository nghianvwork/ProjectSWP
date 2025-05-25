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
    <style>
        body {
            background-color: #f8f9fa;
        }
        .main-content {
            padding: 30px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }
        .form-inline input {
            border-radius: 8px;
        }
        .btn {
            border-radius: 8px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .modal-content {
            border-radius: 12px;
        }
        .modal-header {
            background-color: #007bff;
            color: #fff;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
        }
    </style>
</head>
<body class="bg-light">
<jsp:include page="navigation_court.jsp" />

<div class="container-fluid">
    <div class="row mt-4">
        <div class="col-md-2">
            <jsp:include page="Sidebar.jsp" />
        </div>
        <div class="col-md-10">
            <div class="main-content">
                <h1 class="mb-4">Quản Lý Sân Cầu Lông</h1>

                <!-- Search Bar -->
                <div class="form-inline mb-4">
                    <input type="text" id="searchInput" class="form-control mr-2" placeholder="Tìm kiếm theo số sân">
                    <button class="btn btn-primary" onclick="searchCourts()">Tìm kiếm</button>
                </div>

                <!-- Nút mở modal thêm sân -->
                <div class="mb-4">
                    <button class="btn btn-success" data-toggle="modal" data-target="#courtModal">+ Thêm Sân</button>
                </div>

                <!-- Modal thêm/sửa sân -->
                <div class="modal fade" id="courtModal" tabindex="-1" aria-labelledby="courtModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="courtModalLabel">${court != null ? 'Sửa Sân' : 'Thêm Sân'}</h5>
                                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="courtForm" action="courts" method="post">
                                    <input type="hidden" name="action" value="${court != null ? 'update' : 'add'}">
                                    <input type="hidden" name="courtId" value="${court != null ? court.court_id : ''}">
                                    <div class="form-group">
                                        <label for="courtNumber">Mã Sân</label>
                                        <input type="text" class="form-control" id="courtNumber" name="courtNumber" value="${court != null ? court.court_number : ''}" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="status">Trạng Thái</label>
                                        <input type="text" class="form-control" id="status" name="status" value="${court != null ? court.status : ''}" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="areaId">Khu Vực ID</label>
                                        <input type="number" class="form-control" id="areaId" name="areaId" value="${court != null ? court.area_id : ''}" required>
                                    </div>
                                    <button type="submit" class="btn btn-success">${court != null ? 'Cập Nhật' : 'Lưu'}</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
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
                                    <td>${court.court_id}</td>
                                    <td>${court.court_number}</td>
                                    <td>${court.status}</td>
                                    <td>${court.area_id}</td>
                                    <td>
                                        <a href="courts?action=edit&courtId=${court.court_id}" class="btn btn-sm btn-warning">Sửa</a>
                                        <button class="btn btn-sm btn-danger delete-btn" data-id="${court.court_id}">Xóa</button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

<script>
    // Xử lý tìm kiếm sân
    function searchCourts() {
        let input = document.getElementById("searchInput").value.toUpperCase();
        let rows = document.querySelectorAll("table tbody tr");
        rows.forEach(row => {
            let courtNumber = row.cells[1].textContent.toUpperCase();
            row.style.display = courtNumber.includes(input) ? "" : "none";
        });
    }

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