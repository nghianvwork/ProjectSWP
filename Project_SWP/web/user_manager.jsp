<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Manager Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            /* Ẩn thanh cuộn ngang toàn bộ trang */
            body {
                overflow-x: hidden;
                font-size: 16px;
            }

            /* Tối ưu kích thước container */
            .container-fluid {
                padding-left: 16px;
                padding-right: 16px;
            }

            /* Ngăn bảng tràn ra ngoài khi trong div.table-responsive */
            .table-responsive {
                overflow-x: auto;
                max-width: 100%;
            }

            /* Cố định bảng không vượt quá khung */
            #userTable {
                table-layout: auto;
                width: 100%;
                word-wrap: break-word;
                font-size: 15px;
            }

            /* Tối ưu header bảng */
            #userTable th {
                padding: 10px 8px;
                font-size: 15px;
                font-weight: 600;
                white-space: nowrap;
                vertical-align: middle;
            }

            /* Tối ưu cell bảng */
            #userTable td {
                padding: 10px 8px;
                vertical-align: middle;
                font-size: 14px;
            }

            /* Tối ưu cột hành động - QUAN TRỌNG */
            .action-column {
                min-width: 200px;
                max-width: 220px;
            }

            /* Container cho các nút hành động - nằm ngang */
            .action-buttons {
                display: flex;
                flex-direction: row;
                gap: 3px;
                justify-content: center;
                align-items: center;
                flex-wrap: nowrap;
            }

            /* Tối ưu kích thước nút */
            .action-buttons .btn {
                padding: 6px 12px;
                font-size: 13px;
                border-radius: 4px;
                white-space: nowrap;
                min-width: 70px;
                font-weight: 500;
            }

            /* Icon trong nút nhỏ hơn */
            .action-buttons .btn i {
                font-size: 10px;
                margin-right: 2px;
            }

            /* Tối ưu badge role */
            .role-badge {
                font-size: 11px;
                padding: 3px 8px;
                border-radius: 12px;
                font-weight: 600;
                white-space: nowrap;
            }

            /* Tối ưu status badge */
            .status-badge {
                font-size: 13px;
                padding: 4px 10px;
                border-radius: 8px;
                font-weight: 600;
                white-space: nowrap;
            }

            /* Tối ưu date display */
            .date-display {
                font-size: 11px;
                padding: 2px 6px;
                border-radius: 6px;
                white-space: nowrap;
            }

            /* Responsive cho màn hình nhỏ */
            @media (max-width: 768px) {
                .action-buttons {
                    flex-direction: column;
                    gap: 2px;
                }

                .action-buttons .btn {
                    width: 100%;
                    min-width: auto;
                    font-size: 10px;
                    padding: 3px 6px;
                }

                #userTable {
                    font-size: 16px;
                }

                #userTable th,
                #userTable td {
                    padding: 5px 3px;
                }
            }

            /* Tối ưu search form */
            .search-form .form-control,
            .search-form .form-select {
                padding: 6px 12px;
                font-size: 13px;
            }

            /* Compact card */
            .card-body {
                padding: 15px;
            }

            /* User icon styling */
            .user-icon {
                font-size: 14px;
                margin-right: 5px;
            }

            /* Note column styling */
            .note-text {
                max-width: 120px;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
                font-size: 11px;
            }
        </style>
    </head>

    <c:if test="${not empty openEditModal}">
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var modal = new bootstrap.Modal(document.getElementById('editUserModal'));
                modal.show();

                // Gán lại dữ liệu vào các input trong form sửa
                document.getElementById('editUserId').value = '${editUser.user_Id}';
                document.getElementById('editUsername').value = '${editUser.username}';
                document.getElementById('editEmail').value = '${editUser.email}';
                document.getElementById('editPhone').value = '${editUser.phone_number}';
                document.getElementById('editRole').value = '${editUser.role}';
            });
        </script>
    </c:if>

    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Quản lí</a>
                <div class="d-flex">
                    <a class="nav-link text-light" href="login">Đăng xuất</a>
                </div>
            </div>
        </nav>

        <!-- Main Layout -->
        <div class="container-fluid mt-3">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3">
                    <jsp:include page="Sidebar.jsp" />
                </div>

                <!-- Content -->
                <div class="col-md-9">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <div class="container-fluid py-3">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h3 class="mb-0"><i class="fas fa-users me-2"></i>Quản Lý Người Dùng</h3>
                            <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#addUserModal">
                                <i class="fas fa-user-plus me-1"></i>Thêm
                            </button>
                        </div>

                        <!-- Search + Filter -->
                        <form method="get" class="row mb-3 g-2 search-form">
                            <div class="col-md-5">
                                <input type="text" name="keyword" value="${param.keyword}" class="form-control form-control-sm" placeholder="Tìm kiếm theo Username, Email, SĐT...">
                            </div>
                            <div class="col-md-3">
                                <select name="status" class="form-select form-select-sm">
                                    <option value="">Tất cả trạng thái</option>
                                    <option value="Active" ${param.status == 'Active' ? 'selected' : ''}>Hoạt Động </option>

                                    <option value="banned" ${param.status == 'banned' ? 'selected' : ''}>Đã chặn</option>

                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary btn-sm w-100">
                                    <i class="fas fa-search me-1"></i>Tìm
                                </button>
                            </div>
                        </form>

                        <div class="card shadow-sm">
                            <div class="card-body p-2">
                                <div class="table-responsive">
                                    <table id="userTable" class="table table-bordered table-hover mb-0 align-middle">
                                        <thead class="table-light">
                                            <tr class="text-center">
                                                <th>ID</th>
                                                <th>Tên đăng nhập</th>
                                                <th>Họ</th>
                                                <th>Tên</th>
                                                <th>Full name</th>
                                                <th>Giới tính</th>
                                                <th>Ngày sinh</th>
                                                <th>Email</th>
                                                <th>SĐT</th>
                                                <th>Vai trò</th>
                                                <th>Ngày tạo</th>
                                                <th>Trạng thái</th>
                                                <th>Ghi chú</th>
                                                <th class="action-column">Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody id="userTableBody">
                                            <c:forEach var="user" items="${users}">
                                                <tr class="text-center"
                                                    data-username="${user.username}"
                                                    data-email="${user.email}"
                                                    data-phone="${user.phone_number}"
                                                    data-status="${user.status}">
                                                    <td>${user.user_Id}</td>
                                                    <td><i class="fas fa-user-circle text-primary user-icon"></i><strong>${user.username}</strong></td>
                                                    <td>${user.lastname}</td>
                                                    <td>${user.firstname}</td>
                                                    <td>${user.lastname} ${user.firstname} </td>
                                                    <td>${user.gender}</td>
                                                    <td><fmt:formatDate value="${user.dateOfBirth}" pattern="yyyy-MM-dd"/></td>
                                                    <td class="text-start" style="font-size: 11px;">${user.email}</td>
                                                    <td>${user.phone_number}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${user.role eq 'admin'}">
                                                                <span class="role-badge" style="background: #ff9800; color: white;">Quản lí</span>
                                                            </c:when>
                                                            <c:when test="${user.role eq 'staff'}">
                                                                <span class="role-badge" style="background: #17a2b8; color: white;">Nhân viên</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="role-badge" style="background: #6c757d; color: white;">Người dùng</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty user.createdAt}">
                                                                <span class="date-display" style="background: #e3f2fd; color: #1565c0;">${user.createdAt}</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="date-display" style="background: #efefef; color: #888;">-</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${user.status eq 'Active'}">
                                                                <span class="status-badge" style="background: #28a745; color: white;">Active</span>
                                                            </c:when>
                                                            <c:when test="${user.status eq 'Suspended'}">
                                                                <span class="status-badge" style="background: #ffc107; color: black;">Suspended</span>
                                                            </c:when>
                                                            <c:when test="${user.status eq 'banned'}">
                                                                <span class="status-badge" style="background: #dc3545; color: white;">Banned</span>
                                                            </c:when>
                                                            <c:when test="${user.status eq 'pending'}">
                                                                <span class="status-badge" style="background: #fd7e14; color: white;">Pending</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="status-badge" style="background: #6c757d; color: white;">-</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <span class="note-text" title="${user.note}">${user.note}</span>
                                                    </td>
                                                    <td class="action-column">
                                                        <div class="action-buttons">
                                                            <!-- Nút Edit -->
                                                            <button type="button" class="btn btn-warning"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#editUserModal"
                                                                    data-userid="${user.user_Id}"
                                                                    data-username="${user.username}"
                                                                    data-email="${user.email}"
                                                                    data-phone="${user.phone_number}"
                                                                    data-role="${user.role}"
                                                                    data-gender="${user.gender}"
                                                                    data-firstname="${user.firstname}"
                                                                    data-lastname="${user.lastname}"
                                                                    data-dob="${user.dateOfBirth}">
                                                                <i class="fas fa-edit"></i>Chỉnh
                                                            </button>

                                                            <!-- Nút Delete -->
                                                            <form action="users" method="post" class="d-inline" onsubmit="return confirm('Bạn có chắc muốn xóa?');">
                                                                <input type="hidden" name="action" value="delete">
                                                                <input type="hidden" name="userId" value="${user.user_Id}">
                                                                <button type="submit" class="btn btn-danger">
                                                                    <i class="fas fa-trash"></i>Xoá
                                                                </button>
                                                            </form>

                                                            <!-- Nút Ban hoặc Unban -->
                                                            <c:choose>
                                                                <c:when test="${user.status ne 'banned'}">
                                                                    <button type="button" class="btn btn-dark"
                                                                            data-bs-toggle="modal"
                                                                            data-bs-target="#banUserModal"
                                                                            data-userid="${user.user_Id}"
                                                                            data-username="${user.username}">
                                                                        <i class="fas fa-ban"></i>Chặn
                                                                    </button>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <form action="users" method="post" class="d-inline" onsubmit="return confirm('Unban user này?');">
                                                                        <input type="hidden" name="action" value="unban">
                                                                        <input type="hidden" name="userId" value="${user.user_Id}">
                                                                        <button type="submit" class="btn btn-success">
                                                                            <i class="fas fa-check"></i>Gỡ chặn
                                                                        </button>
                                                                    </form>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                </div>
                            </div>

                            <!-- Pagination -->
                            <div class="card-footer bg-white py-2">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination pagination-sm justify-content-center mb-0">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="users?page=${currentPage-1}">&laquo;</a>
                                            </li>
                                        </c:if>
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="users?page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="users?page=${currentPage+1}">&raquo;</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>

                    <!-- Modal Ban User -->
                    <div class="modal fade" id="banUserModal" tabindex="-1" aria-labelledby="banUserModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <form class="modal-content" action="users" method="post">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="banUserModalLabel"><i class="fas fa-user-slash"></i> Ban Người Dùng</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="action" value="ban">
                                    <input type="hidden" name="userId" id="banUserId">
                                    <div class="mb-3">
                                        <label class="form-label">Lý do Ban</label>
                                        <textarea name="note" class="form-control" id="banNote" required placeholder="Nhập lý do ban..."></textarea>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <button type="submit" class="btn btn-danger"><i class="fas fa-user-slash"></i> Ban</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Modal Thêm User -->
                    <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <form class="modal-content" action="users" method="post">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="addUserModalLabel">
                                        <i class="fas fa-user-plus"></i> Thêm Người Dùng
                                    </h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="action" value="add">

                                    <div class="row">
                                        <!-- Cột trái -->
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Username</label>
                                                <input type="text" name="username" class="form-control" required>
                                            </div>

                                         

                                            <div class="mb-3">
                                                <label class="form-label">Email</label>
                                                <input type="email" name="email" class="form-control" required>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Số điện thoại</label>
                                                <input type="text" name="phone_number" class="form-control">
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Giới tính</label>
                                                <select name="gender" class="form-select">
                                                    <option value="">-- Chọn giới tính --</option>
                                                    <option value="Male">Nam</option>
                                                    <option value="Female">Nữ</option>
                                                    <option value="Other">Khác</option>
                                                </select>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Ngày sinh</label>
                                                <input type="date" name="date_of_birth" class="form-control">
                                            </div>
                                        </div>

                                        <!-- Cột phải -->
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Họ</label>
                                                <input type="text" name="lastname" class="form-control">
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Tên</label>
                                                <input type="text" name="firstname" class="form-control">
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Trạng thái</label>
                                                <select name="status" class="form-select">
                                                    <option value="Active">Đang hoạt động</option>
                                                    <option value="Suspended">Tạm khóa</option>
                                                    <option value="banned">Bị chặn</option>
                                                    <option value="pending">Chờ duyệt</option>
                                                </select>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Vai trò</label>
                                                <select name="role" class="form-select" required>
                                                    <option value="user">Người dùng</option>
                                                    <option value="staff">Nhân viên</option>
                                                    <option value="admin">Quản lí</option>
                                                </select>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Ghi chú</label>
                                                <input type="text" name="note" class="form-control">
                                            </div>
                                        </div>
                                    </div> <!-- End row -->
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Lưu</button>
                                </div>
                            </form>
                        </div>
                    </div>



                    <!-- Modal Sửa User -->
                    <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <form class="modal-content" action="users" method="post">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editUserModalLabel"><i class="fas fa-user-edit"></i> Sửa Người Dùng</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="userId" id="editUserId">

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Tên đăng nhập</label>
                                                <input type="text" name="username" id="editUsername" class="form-control" required>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Email</label>
                                                <input type="email" name="email" id="editEmail" class="form-control" required>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Số điện thoại</label>
                                                <input type="text" name="phone_number" id="editPhone" class="form-control">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Giới tính</label>
                                                <select name="gender" id="editGender" class="form-select">
                                                    <option value="">-- Chọn giới tính --</option>
                                                    <option value="Male">Nam</option>
                                                    <option value="Female">Nữ</option>
                                                    <option value="Other">Khác</option>
                                                </select>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Ngày sinh</label>
                                                <input type="date" name="date_of_birth" id="editDOB" class="form-control">
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Họ</label>
                                                <input type="text" name="lastname" id="editLastname" class="form-control">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Tên</label>
                                                <input type="text" name="firstname" id="editFirstname" class="form-control">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Ghi chú</label>
                                                <textarea name="note" id="editNote" class="form-control" rows="2"></textarea>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Trạng thái</label>
                                                <select name="status" id="editStatus" class="form-select">
                                                    <option value="Active">Active</option>
                                                    <option value="Suspended">Suspended</option>
                                                    <option value="banned">Banned</option>
                                                    <option value="pending">Pending</option>
                                                </select>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Vai trò</label>
                                                <select name="role" id="editRole" class="form-select" required>
                                                    <option value="user">Người dùng</option>
                                                    <option value="staff">Nhân viên</option>
                                                    <option value="admin">Quản lí</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Cập nhật</button>
                                </div>
                            </form>
                        </div>
                    </div>




                </div>
            </div>
        </div>

        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                                                                        // Filter table functionality
                                                                        document.addEventListener('DOMContentLoaded', function () {
                                                                            const searchInput = document.querySelector('input[name="keyword"]');
                                                                            const statusFilter = document.querySelector('select[name="status"]');
                                                                            const tbody = document.getElementById('userTableBody');
                                                                            const rows = Array.from(tbody.querySelectorAll('tr'));

                                                                            function filterTable() {
                                                                                const keyword = searchInput?.value.toLowerCase() || '';
                                                                                const status = statusFilter?.value || '';

                                                                                rows.forEach(row => {
                                                                                    const username = row.getAttribute('data-username')?.toLowerCase() || '';
                                                                                    const email = row.getAttribute('data-email')?.toLowerCase() || '';
                                                                                    const phone = row.getAttribute('data-phone')?.toLowerCase() || '';
                                                                                    const rowStatus = row.getAttribute('data-status') || '';

                                                                                    const matchSearch = (
                                                                                            username.includes(keyword) ||
                                                                                            email.includes(keyword) ||
                                                                                            phone.includes(keyword)
                                                                                            );
                                                                                    const matchStatus = (status === "" || rowStatus === status);

                                                                                    row.style.display = (matchSearch && matchStatus) ? "" : "none";
                                                                                });
                                                                            }

                                                                            if (searchInput)
                                                                                searchInput.addEventListener('input', filterTable);
                                                                            if (statusFilter)
                                                                                statusFilter.addEventListener('change', filterTable);
                                                                        });

                                                                        // Modal handlers
                                                                        var banUserModal = document.getElementById('banUserModal');
                                                                        if (banUserModal) {
                                                                            banUserModal.addEventListener('show.bs.modal', function (event) {
                                                                                var button = event.relatedTarget;
                                                                                var userId = button.getAttribute('data-userid');
                                                                                document.getElementById('banUserId').value = userId;
                                                                                document.getElementById('banNote').value = '';
                                                                            });
                                                                        }


        </script>
        <script>
            var editUserModal = document.getElementById('editUserModal');
            if (editUserModal) {
                editUserModal.addEventListener('show.bs.modal', function (event) {
                    var button = event.relatedTarget;

                    document.getElementById('editUserId').value = button.getAttribute('data-userid');
                    document.getElementById('editUsername').value = button.getAttribute('data-username');
                    document.getElementById('editEmail').value = button.getAttribute('data-email');
                    document.getElementById('editPhone').value = button.getAttribute('data-phone');
                    document.getElementById('editRole').value = button.getAttribute('data-role');
                    document.getElementById('editGender').value = button.getAttribute('data-gender');
                    document.getElementById('editFirstname').value = button.getAttribute('data-firstname');
                    document.getElementById('editLastname').value = button.getAttribute('data-lastname');
                    document.getElementById('editDOB').value = button.getAttribute('data-dob');

                    // Nếu bạn có thêm trường note và status
                    var noteInput = document.getElementById('editNote');
                    if (noteInput) {
                        noteInput.value = button.getAttribute('data-note') || '';
                    }

                    var statusInput = document.getElementById('editStatus');
                    if (statusInput) {
                        statusInput.value = button.getAttribute('data-status') || '';
                    }
                });
            }
        </script>

    </body>
</html>