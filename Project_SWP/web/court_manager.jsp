<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sân Cầu Lông</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
          integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Roboto', sans-serif;
        }

        .sidebar {
            width: 250px;
            height: 100vh;
            background-color: #1e1e2f;
            color: #fff;
            position: fixed;
            top: 0;
            left: 0;
            display: flex;
            flex-direction: column;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            z-index: 1000;
        }

        .sidebar-logo {
            text-align: center;
            padding: 20px;
            border-bottom: 1px solid #444;
        }

        .sidebar-logo img {
            width: 100px;
            height: auto;
            border-radius: 50%;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
            flex: 1;
        }

        .nav-item {
            border-bottom: 1px solid #333;
        }

        .nav-link {
            display: block;
            padding: 15px 20px;
            color: #bbb;
            text-decoration: none;
            transition: background 0.3s ease;
        }

        .nav-link:hover, .nav-link.active {
            background-color: #343454;
            color: #fff;
        }

        .main-content {
            margin-left: 270px;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            margin-top: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .search-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .table th, .table td {
            vertical-align: middle;
            font-size: 0.95rem;
            padding: 12px;
        }

        .table-hover tbody tr:hover {
            background-color: #f1f3f5;
        }

        .modal-content {
            border-radius: 10px;
        }

        .modal-header {
            background-color: #007bff;
            color: #fff;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        @media (max-width: 768px) {
            .sidebar {
                position: static;
                width: 100%;
                height: auto;
            }
            .main-content {
                margin-left: 0;
                margin-top: 20px;
            }
        }
    </style>
</head>
<body>
<jsp:include page="navigation_court.jsp" />
<div class="sidebar">
    <div class="sidebar-logo">
        <img src="badminton.jpg" alt="Logo">
    </div>
    <ul>
        <li class="nav-item"><a class="nav-link" href="view-region">REGION MANAGEMENT</a></li>
        <li class="nav-item"><a class="nav-link" href="courts">COURT MANAGEMENT</a></li>
        <li class="nav-item"><a class="nav-link" href="ViewEquipments">SERVICE MANAGEMENT</a></li>
        <li class="nav-item"><a class="nav-link" href="manage-request">COURT REQUEST</a></li>
    </ul>
</div>

<div class="main-content">
    <h1 class="text-center mb-4">🏙 Quản Lý Sân Cầu Lông</h1>

    <div class="search-bar">
        <div class="form-inline">
            <input type="text" id="searchInput" class="form-control mr-2" placeholder="Tìm kiếm theo số sân">
            <button class="btn btn-primary" onclick="searchCourts()">Tìm kiếm</button>
        </div>
        <button class="btn btn-primary" data-toggle="modal" data-target="#addCourtModal">Thêm Sân</button>
    </div>

    <!-- Modal thêm sân -->
    <div class="modal fade" id="addCourtModal" tabindex="-1" aria-labelledby="addCourtModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addCourtModalLabel">Thêm Sân</h5>
                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                </div>
                <div class="modal-body">
                    <form action="courts" method="post" autocomplete="off">
                        <input type="hidden" name="action" value="add">
                        <div class="form-group">
                            <label>Tên Sân</label>
                            <input type="text" class="form-control" name="courtNumber" required>
                        </div>
                        <div class="form-group">
                            <label>Trạng Thái</label>
                            <select class="form-control" name="status" required>
                                <option value="available">Available</option>
                                <option value="maintenance">Maintenance</option>
                                <option value="booked">Booked</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Khu Vực ID</label>
                            <input type="number" class="form-control" name="areaId" required>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-success">Lưu</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal sửa sân -->
    <div class="modal fade" id="updateCourtModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Sửa Sân</h5>
                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                </div>
                <div class="modal-body">
                    <form action="courts" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="courtId" id="updateCourtId">
                        <div class="form-group">
                            <label>Tên Sân</label>
                            <input type="text" class="form-control" id="updateCourtNumber" name="courtNumber" required>
                        </div>
                        <div class="form-group">
                            <label>Trạng Thái</label>
                            <select class="form-control" id="updateStatus" name="status" required>
                                <option value="available">Available</option>
                                <option value="maintenance">Maintenance</option>
                                <option value="booked">Booked</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Khu Vực ID</label>
                            <input type="number" class="form-control" id="updateAreaId" name="areaId" required>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-success">Cập Nhật</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Danh sách sân -->
    <div class="card">
        <div class="card-header"><h4 class="mb-0">Danh Sách Sân</h4></div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead class="thead-light">
                    <tr>
                        <th>Mã Sân</th>
                        <th>Tên Sân</th>
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
                                <button class="btn btn-sm btn-warning edit-btn"
                                        data-id="${court.court_id}"
                                        data-number="${court.court_number}"
                                        data-status="${court.status}"
                                        data-area="${court.area_id}">Sửa</button>
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

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function () {
            if (confirm('Bạn có chắc muốn xóa sân này?')) {
                const courtId = this.getAttribute('data-id');
                fetch('courts', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: `action=delete&courtId=${courtId}`
                })
                .then(response => {
                    if (!response.ok) throw new Error('Xóa thất bại');
                    location.reload();
                })
                .catch(error => alert('Lỗi: ' + error.message));
            }
        });
    });

    function searchCourts() {
        let input = document.getElementById("searchInput").value.toUpperCase();
        let rows = document.querySelectorAll("table tbody tr");
        rows.forEach(row => {
            let courtNumber = row.cells[1].textContent.toUpperCase();
            row.style.display = courtNumber.includes(input) ? "" : "none";
        });
    }

    document.querySelectorAll('.edit-btn').forEach(button => {
        button.addEventListener('click', function () {
            document.getElementById('updateCourtId').value = this.dataset.id;
            document.getElementById('updateCourtNumber').value = this.dataset.number;
            document.getElementById('updateStatus').value = this.dataset.status;
            document.getElementById('updateAreaId').value = this.dataset.area;
            $('#updateCourtModal').modal('show');
        });
    }); 
</script>
</body>
</html>
