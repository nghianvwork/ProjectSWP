<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manager Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* General body styling */
        body {
            overflow-x: hidden;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #f5f6fa;
            color: #333;
            line-height: 1.6;
        }

        /* Container optimization */
        .container-fluid {
            padding: 20px 24px;
            max-width: 1400px;
        }

        /* Table responsive wrapper */
        .table-responsive {
            overflow-x: auto;
            border-radius: 8px;
            background: #fff;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        /* Table styling */
        #userTable {
            table-layout: auto;
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            font-size: 14px;
        }

        /* Table header */
        #userTable th {
            padding: 12px 16px;
            font-weight: 600;
            color: #1a3c34;
            background: #f8f9fa;
            border-bottom: 2px solid #e9ecef;
            white-space: nowrap;
            text-align: center;
        }

        /* Table cells */
        #userTable td {
            padding: 12px 16px;
            vertical-align: middle;
            border-bottom: 1px solid #e9ecef;
            transition: background 0.2s ease;
        }

        #userTable tr:hover {
            background: #f1f3f5;
        }

        /* Action column */
        .action-column {
            min-width: 220px;
            max-width: 240px;
        }

        /* Action buttons container */
        .action-buttons {
            display: flex;
            flex-direction: row;
            gap: 8px;
            justify-content: center;
            align-items: center;
            flex-wrap: nowrap;
        }

        /* Action buttons */
        .action-buttons .btn {
            padding: 6px 14px;
            font-size: 13px;
            border-radius: 6px;
            font-weight: 500;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .action-buttons .btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .action-buttons .btn i {
            font-size: 12px;
            margin-right: 4px;
        }

        /* Role badge */
        .role-badge {
            font-size: 12px;
            padding: 4px 10px;
            border-radius: 12px;
            font-weight: 600;
            display: inline-block;
        }

        /* Status badge */
        .status-badge {
            font-size: 12px;
            padding: 5px 12px;
            border-radius: 16px;
            font-weight: 600;
            display: inline-block;
        }

        /* Date display */
        .date-display {
            font-size: 12px;
            padding: 4px 8px;
            border-radius: 6px;
            background: #e3f2fd;
            color: #1565c0;
            display: inline-block;
        }

        /* Navbar styling */
        .navbar {
            background: linear-gradient(90deg, #1a3c34, #2a5c54);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.4rem;
        }

        .nav-link {
            font-weight: 500;
            transition: color 0.2s ease;
        }

        .nav-link:hover {
            color: #17a2b8 !important;
        }

        /* Card styling */
        .card {
            border: none;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            background: #fff;
        }

        .card-body {
            padding: 20px;
        }

        /* Search form */
        .search-form .form-control,
        .search-form .form-select {
            border-radius: 6px;
            border: 1px solid #ced4da;
            font-size: 14px;
            padding: 8px 12px;
            transition: border-color 0.2s ease;
        }

        .search-form .form-control:focus,
        .search-form .form-select:focus {
            border-color: #17a2b8;
            box-shadow: 0 0 0 2px rgba(23, 162, 184, 0.2);
        }

        /* Modal styling */
        .modal-content {
            border-radius: 8px;
            border: none;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        }

        .modal-header {
            background: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
        }

        .modal-title {
            font-weight: 600;
            color: #1a3c34;
        }

        /* User icon */
        .user-icon {
            font-size: 16px;
            margin-right: 6px;
        }

        /* Note text */
        .note-text {
            max-width: 140px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            font-size: 12px;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .container-fluid {
                padding: 12px;
            }

            .action-buttons {
                flex-direction: column;
                gap: 6px;
            }

            .action-buttons .btn {
                width: 100%;
                font-size: 12px;
                padding: 6px 10px;
            }

            #userTable th,
            #userTable td {
                padding: 8px 10px;
                font-size: 13px;
            }

            .search-form .form-control,
            .search-form .form-select {
                font-size: 13px;
                padding: 6px 10px;
            }
        }
    </style>
</head>

<c:if test="${not empty openEditModal}">
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var modal = new bootstrap.Modal(document.getElementById('editUserModal'));
            modal.show();

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
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"></a>
           <div class="d-flex">
    <a class="btn btn-outline-light btn-sm" href="login">
        <i class="fas fa-sign-out-alt me-1"></i> Đăng xuất
    </a>
</div>
        </div>
    </nav>

    <!-- Main Layout -->
    <div class="container-fluid mt-4">
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
                    </c:if>

                <div class="py-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3 class="mb-0"><i class="fas fa-users me-2"></i>Quản Lý Người Dùng</h3>
                        <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addUserModal">
                            <i class="fas fa-user-plus me-1"></i> Thêm Người Dùng
                        </button>
                    </div>

                    <!-- Search + Filter -->
                    <form method="get" class="row mb-4 g-3 search-form">
                        <div class="col-md-5">
                            <input type="text" name="keyword" value="${param.keyword}" class="form-control" placeholder="Tìm kiếm theo Username, Email, SĐT...">
                        </div>
                        <div class="col-md-3">
                            <select name="status" class="form-select">
                                <option value="">Tất cả trạng thái</option>
                                <option value="Active" ${param.status == 'Active' ? 'selected' : ''}>Hoạt động</option>
                                <option value="banned" ${param.status == 'banned' ? 'selected' : ''}>Đã cấm</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-search me-1"></i> Tìm
                            </button>
                        </div>
                    </form>

                    <div class="card">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table id="userTable" class="table table-hover mb-0">
                                    <thead>
                                        <tr class="text-center">
                                            <th>ID</th>
                                            <th>Tên đăng nhập</th>
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
                                                <td>
                                                    <i class="fas fa-user-circle text-primary user-icon"></i>
                                                    <strong>${user.username}</strong>
                                                </td>
                                                <td class="text-start">${user.email}</td>
                                                <td>${user.phone_number}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${user.role eq 'staff'}">
                                                            <span class="role-badge" style="background: #17a2b8; color: white;">
                                                                Nhân Viên
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="role-badge" style="background: #6c757d; color: white;">
                                                                Người dùng
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty user.createdAt}">
                                                            <span class="date-display">${user.createdAt}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="date-display" style="background: #f1f3f5; color: #6c757d;">-</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${user.status eq 'Active'}">
                                                            <span class="status-badge" style="background: #28a745; color: white;">
                                                                Hoạt động
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${user.status eq 'Suspended'}">
                                                            <span class="status-badge" style="background: #ffc107; color: black;">
                                                                Suspended
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${user.status eq 'banned'}">
                                                            <span class="status-badge" style="background: #dc3545; color: white;">
                                                                Bị cấm
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${user.status eq 'pending'}">
                                                            <span class="status-badge" style="background: #fd7e14; color: white;">
                                                                Pending
                                                            </span>
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
                                                        <button type="button" class="btn btn-warning"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#editUserModal"
                                                                data-userid="${user.user_Id}"
                                                                data-username="${user.username}"
                                                                data-email="${user.email}"
                                                                data-phone="${user.phone_number}"
                                                                data-role="${user.role}">
                                                            <i class="fas fa-edit"></i> Chỉnh
                                                        </button>
                                                        <form action="users" method="post" class="d-inline" onsubmit="return confirm('Bạn có chắc muốn xóa?');">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="userId" value="${user.user_Id}">
                                                            <button type="submit" class="btn btn-danger">
                                                                <i class="fas fa-trash"></i> Xoá
                                                            </button>
                                                        </form>
                                                        <c:choose>
                                                            <c:when test="${user.status ne 'banned'}">
                                                                <button type="button" class="btn btn-dark"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target="#banUserModal"
                                                                        data-userid="${user.user_Id}"
                                                                        data-username="${user.username}">
                                                                    <i class="fas fa-ban"></i> Chặn
                                                                </button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <form action="users" method="post" class="d-inline" onsubmit="return confirm('Gỡ chặn user này?');">
                                                                    <input type="hidden" name="action" value="unban">
                                                                    <input type="hidden" name="userId" value="${user.user_Id}">
                                                                    <button type="submit" class="btn btn-success">
                                                                        <i class="fas fa-check"></i> Gỡ chặn
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
                            <!-- Pagination -->
                            <div class="card-footer bg-white py-3">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination pagination-sm justify-content-center mb-0">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="users?page=${currentPage-1}">«</a>
                                            </li>
                                        </c:if>
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="users?page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="users?page=${currentPage+1}">»</a>
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
                                    <h5 class="modal-title" id="banUserModalLabel"><i class="fas fa-user-slash me-2"></i> Ban Người Dùng</h5>
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
                                    <button type="submit" class="btn btn-danger"><i class="fas fa-user-slash me-1"></i> Ban</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Modal Thêm User -->
                    <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <form class="modal-content" action="users" method="post">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="addUserModalLabel"><i class="fas fa-user-plus me-2"></i> Thêm Người Dùng</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="action" value="add">
                                    <div class="mb-3">
                                        <label class="form-label">Username</label>
                                        <input type="text" name="username" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Password</label>
                                        <input type="password" name="password" class="form-control" required>
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
                                        <label class="form-label">Vai trò</label>
                                        <select name="role" class="form-select" required>
                                            <option value="user">Người dùng</option>
                                            <option value="staff">Nhân viên</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <button type="submit" class="btn btn-primary"><i class="fas fa-save me-1"></i> Lưu</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Modal Sửa User -->
                    <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <form class="modal-content" action="users" method="post">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editUserModalLabel"><i class="fas fa-user-edit me-2"></i> Sửa Người Dùng</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="userId" id="editUserId">
                                    <div class="mb-3">
                                        <label five="editUsername" class="form-label">Username</label>
                                        <input type="text" name="username" id="editUsername" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="editEmail" class="form-label">Email</label>
                                        <input type="email" name="email" id="editEmail" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="editPhone" class="form-label">Số điện thoại</label>
                                        <input type="text" name="phone_number" id="editPhone" class="form-control">
                                    </div>
                                    <div class="mb-3">
                                        <label for="editRole" class="form-label">Vai trò</label>
                                        <select name="role" id="editRole" class="form-select" required>
                                            <option value="user">Người dùng</option>
                                            <option value="staff">Nhân viên</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <button type="submit" class="btn btn-primary"><i class="fas fa-save me-1"></i> Cập nhật</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
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

            if (searchInput) searchInput.addEventListener('input', filterTable);
            if (statusFilter) statusFilter.addEventListener('change', filterTable);
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

        var editUserModal = document.getElementById('editUserModal');
        if (editUserModal) {
            editUserModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                document.getElementById('editUserId').value = button.getAttribute('data-userid');
                document.getElementById('editUsername').value = button.getAttribute('data-username');
                document.getElementById('editEmail').value = button.getAttribute('data-email');
                document.getElementById('editPhone').value = button.getAttribute('data-phone');
                document.getElementById('editRole').value = button.getAttribute('data-role');
            });
        }
    </script>
</body>
</html>