<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Region Management</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                background-color: #f4f6f9;
            }
            .main-content {
                padding: 30px;
                background-color: #ffffff;
                border-radius: 15px;
                box-shadow: 0 0 15px rgba(0,0,0,0.05);
            }
            .form-inline input {
                border-radius: 10px;
            }
            .btn {
                border-radius: 10px;
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
            .navbar-custom {
                background-color: #ffffff;
                padding: 10px 20px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.05);
            }
            .navbar-custom .btn {
                border-radius: 8px;
            }
            .col-small {
                width: 90px;
            }
            .col-time {
                width: 110px;
            }
            .col-description {
                width: 250px;
            }
            .notification.success {
                background-color: #4CAF50;
                color: white;
                padding: 15px;
                position: fixed;
                top: 20px;
                right: 20px;
                border-radius: 10px;
                z-index: 9999;
                animation: fadeIn 0.5s;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            .close-btn {
                border: none;
                background: transparent;
                color: white;
                font-size: 18px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-custom">
            <a class="navbar-brand font-weight-bold" href="#">🏠 Region Admin</a>


            <div class="ml-auto">
                <a class="btn btn-outline-danger" href="login">Đăng xuất</a>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row mt-4">
                <div class="col-md-2 mb-4">
                    <jsp:include page="Sidebar.jsp" />
                </div>
                <div class="col-md-10">
                    <div class="main-content">
                        <h3 class="mb-4 text-primary">🏙 Quản lí khu vực</h3>

                        <!-- Search Bar -->
                        <form action="search-branch" method="POST" class="form-inline mb-4">
                            <input type="text" name="searchInput" value="${searchKeyword}" class="form-control mr-2 w-50" placeholder="🔍 Tìm kiếm theo tên khu vực">
                            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                        </form>


                        <!-- Regions Table -->
                        <div class="table-responsive">
                            <table class="table table-hover table-bordered">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>Tên</th>
                                        <th>Địa chỉ</th>
                                        <th class="col-small">Số lượng sân</th>
                                        <th class="col-time">Thời gian mở cửa</th>
                                        <th class="col-time">Thời gian đóng cửa</th>
                                        <th class="col-description">Mô tả</th>

                                        <th class="col-small">Tên quản lí </th>
                                        <th class="col-small">Số điện thoại quản lí </th>
                                        <th style="width: 220px;">Hành động</th>

                                    </tr>
                                </thead>
                                <c:if test="${not empty sessionScope.success}">
                                    <div id="notification" class="notification success">
                                        <i class="fas fa-check-circle"></i> ${sessionScope.success}
                                        <button class="close-btn" onclick="closeNotification()">&times;</button>
                                    </div>
                                </c:if>
                                <tbody>
                                    <c:forEach var="a" items="${area}" varStatus="loop">
                                        <tr>
                                            <td>${a.name}</td>
                                            <td>${a.location}</td>
                                            <td>
                                                <a href="courts?area_id=${a.area_id}">${a.emptyCourt}</a>
                                            </td>
                                            <td>${a.openTime}</td>
                                            <td>${a.closeTime}</td>
                                            <td>${a.description}</td>
                                            <td>${a.nameStaff}</td>
                                            <td>${a.phone_branch}</td>
                                            <td>
                                                <button class="btn btn-warning btn-sm" data-toggle="modal" data-target="#updateModal${loop.index}">Cập nhật</button>
                                                <a href="detailBranch?area_id=${a.area_id}" class="btn btn-info btn-sm">Chi tiết</a>

                                                <a href="delete?regionId=${a.area_id}" class="btn btn-danger btn-sm" onclick="return confirmDelete()">Xóa</a>


                                                <div class="modal fade" id="updateModal${loop.index}" tabindex="-1" role="dialog">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <form action="UpdateArea" method="POST">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title">Cập nhật địa điểm</h5>
                                                                    <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <input type="hidden" name="regionID" value="${a.area_id}">
                                                                    <div class="form-group">
                                                                        <label>Tên địa điểm</label>
                                                                        <input type="text" name="RegionName" class="form-control" value="${a.name}" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label>Địa chỉ</label>
                                                                        <input type="text" name="address" class="form-control" value="${a.location}">
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label>Giờ mở cửa</label>
                                                                        <input type="time" name="openTime" class="form-control" value="${a.openTime}">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label>Giờ đóng cửa</label>

                                                                        <input type="time" name="closeTime" class="form-control" value="${a.closeTime }">

                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label>Mô tả </label>
                                                                        <input type="text" name="description" class="form-control" value="${a.description}">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label>Chọn nhân viên quản lí</label>
                                                                        <select name="manager_id" class="form-control" required>
                                                                            <option value="">-- Chọn nhân viên --</option>
                                                                            <c:forEach var="staff" items="${staffList}">
                                                                                <option value="${staff.user_Id}"
                                                                                        <c:if test="${a.manager_id == staff.user_Id}">selected</c:if>
                                                                                            >
                                                                                        ${staff.lastname} ${staff.firstname}
                                                                                </option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label>Số điện thoại quản lí </label>
                                                                        <input type="text" name="phone_branch" class="form-control" value="${a.phone_branch}">
                                                                    </div>

                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="submit" class="btn btn-success">Cập nhật</button>
                                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <ul class="pagination justify-content-center mt-4">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="view-region?page=${currentPage - 1}">Previous</a>
                            </li>
                            <c:forEach begin="1" end="${numberOfPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="view-region?page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == numberOfPages ? 'disabled' : ''}">
                                <a class="page-link" href="view-region?page=${currentPage + 1}">Next</a>
                            </li>
                        </ul>


                        <button class="btn btn-success mt-4" data-toggle="modal" data-target="#addModal">+ Thêm địa điểm</button>


                        <div class="modal fade" id="addModal" tabindex="-1" role="dialog">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <form action="add-region" method="POST">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Add Region</h5>
                                            <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
                                        </div>
                                        <div class="modal-body">

                                            <div class="form-group">
                                                <label>Tên địa điểm</label>
                                                <input type="text" name="regionName" class="form-control" required>
                                            </div>
                                            <div class="form-group">
                                                <label>Địa chỉ</label>
                                                <input type="text" name="address" class="form-control">
                                            </div>

                                            <div class="form-group">
                                                <label>Giờ mở cửa</label>
                                                <input type="time" name="openTime" class="form-control" required>
                                            </div>
                                            <div class="form-group">
                                                <label>Giờ đóng cửa</label>
                                                <input type="time" name="closeTime" class="form-control" required>
                                            </div>
                                            <div class="form-group">
                                                <label>Mô tả</label>
                                                <input type="text" name="description" class="form-control" required>
                                            </div>
                                            <div class="form-group">
                                                <label>Chọn nhân viên quản lí</label>
                                                <select name="manager_id" class="form-control" required>
                                                    <option value="">-- Chọn nhân viên --</option>
                                                    <c:forEach var="staff" items="${staffList}">
                                                        <option value="${staff.user_Id}">
                                                            ${staff.lastname} ${staff.firstname}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label>Số điện thoại quản lí </label>
                                                <input type="text" name="phone_branch" class="form-control" required="">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-success">Thêm</button>
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!--        <script>
                    $(document).ready(function () {
        <% if (request.getAttribute("error") != null) { %>
            $('#addModal').modal('show');
        <% } %>
        });
    </script>-->

        <script>

            function confirmDelete() {
                return confirm("Do you want to delete this?");
            }
            function closeNotification() {
                const notification = document.getElementById('notification');
                if (notification) {
                    notification.style.animation = 'slideOutRight 0.3s ease-out';
                    setTimeout(() => {
                        notification.style.display = 'none';
                    }, 300);
                }
            }
        </script>
        <c:if test="${not empty error}">
            <script>
                Swal.fire({
                    title: "Tồn tại !",
                    text: "Tồn tại địa điểm rồi!",
                    icon: "warning"
                });
            </script>
        </c:if>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
