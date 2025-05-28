<%@ page import="java.util.List" %>
<%@ page import="Model.Equipments" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>


<html>
    <head>
        <title>Danh sách thiết bị</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }

            /* Sidebar */
            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                width: 250px;
                height: 100%;
                background-color: #1e1e2f;
                color: white;
                padding-top: 20px;
            }

            .sidebar a {
                padding: 12px 20px;
                display: block;
                color: white;
                text-decoration: none;
            }

            .sidebar a:hover {
                background-color: #333;
            }

            /* Header */
            .header {
                margin-left: 250px;
                padding: 10px 20px;
                background-color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid #ccc;
            }

            /* Logout */
            .logout-button {
                color: red;
                border: 1px solid red;
                padding: 6px 14px;
                border-radius: 5px;
                text-decoration: none;
                font-weight: bold;
                transition: 0.3s;
            }

            .logout-button:hover {
                background-color: red;
                color: white;
            }

            /* Main content */
            .main-content {
                margin-left: 250px;
                padding: 30px;
            }

            .card {
                background-color: white;
                padding: 30px;
                border-radius: 16px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .card h2 {
                color: #007bff;
                display: flex;
                align-items: center;
            }

            .card h2::before {
                content: "🛠️";
                margin-right: 10px;
            }

            .table-container {
                margin-top: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th {
                background-color: #2c2f36;
                color: white;
                padding: 12px;
                text-align: left;
            }

            td {
                padding: 12px;
                background-color: #fff;
                border-bottom: 1px solid #ddd;
            }

            /* Button */
            .btn-green {
                background-color: #28a745;
                color: white;
                padding: 10px 18px;
                text-decoration: none;
                border-radius: 8px;
                display: inline-block;
                margin-top: 20px;
                font-weight: bold;
                border: none;
            }

            .btn-green:hover {
                background-color: #218838;
            }

            .search-bar {
                margin-top: 20px;
                display: flex;
            }

            .search-bar input {
                flex: 1;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 8px 0 0 8px;
                outline: none;
            }

            .search-bar button {
                padding: 10px 16px;
                border: none;
                background-color: #007bff;
                color: white;
                border-radius: 0 8px 8px 0;
                cursor: pointer;
            }

            .search-bar button:hover {
                background-color: #0056b3;
            }

            .success {
                color: green;
            }

            .fail {
                color: red;
            }

            .duplicate {
                color: orange;
            }

            .btn {
                padding: 6px 12px;
                border-radius: 6px;
                font-weight: bold;
                text-decoration: none;
                margin-right: 5px;
            }

            .btn-warning {
                background-color: orange;
                color: white;
            }

            .btn-danger {
                background-color: red;
                color: white;
            }

            .action-buttons {
                padding-right: 50px; /* cách phải 1 chút */
            }

            .action-wrapper {
                display: flex;
                justify-content: flex-end; /* đẩy nút sát phải */
                gap: 15px; /* khoảng cách giữa 2 nút */
            }

            .btn-pagination {
                padding: 6px 14px;
                margin: 0 4px;
                border: 1px solid #ccc;
                border-radius: 6px;
                background-color: #fff;
                color: #333;
                text-decoration: none;
                font-size: 14px;
                display: inline-block;
                transition: background-color 0.2s;
            }

            .btn-pagination:hover {
                background-color: #e9ecef;
            }

            .btn-pagination.disabled {
                pointer-events: none;
                opacity: 0.5;
            }

            .btn-pagination.active {
                background-color: #007bff;
                color: white;
                border-color: #007bff;
            }

            .btn-pagination span {
                color: #007bff; /* màu xanh */
                font-weight: bold;
            }

        </style>
    </head>
    <body>

        <jsp:include page="Sidebar.jsp" />
        <%
                List<Equipments> equipments = (List<Equipments>) request.getAttribute("equipments");
                if (equipments == null) equipments = java.util.Collections.emptyList();
                String status = (String) request.getAttribute("status");
        %>
        <!-- Header -->
        <div class="header">
            <h3></h3>
            <a href="login" class="logout-button">Logout</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="card">
                <h2>Danh sách thiết bị</h2>

                <% if ("success".equals(status)) { %>
                <p class="status-message success">✔ Thiết bị đã được thêm thành công!</p>
                <% } else if ("fail".equals(status)) { %>
                <p class="status-message fail">✘ Thêm thiết bị thất bại. Vui lòng thử lại.</p>
                <% } else if ("duplicate".equals(status)) { %>
                <p class="status-message duplicate">⚠ Thiết bị đã tồn tại!</p>
                <% } %>
                <!--                 Tìm kiếm 
                                <div class="search-bar">
                                    <input type="text" placeholder="🔍 Tìm kiếm tên thiết bị">
                                    <button>Tìm</button>
                                </div>-->

                <!-- Bảng -->
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên thiết bị</th>
                                <th>Giá</th>
                                <th style="width: 220px;"> </th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Equipments eq : equipments) { %>
                            <tr>
                                <td><%= eq.getEquipment_id() %></td>
                                <td><%= eq.getName() %></td>
                                <td><%= eq.getPrice() %></td>
                                <td class="action-buttons">
                                    <a href="UpdateEquipments.jsp?id=<%= eq.getEquipment_id() %>" 
                                       class="btn btn-sm btn-warning">Sửa</a>
                                    <a href="deleteEquipment?id=<%= eq.getEquipment_id() %>" 
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa thiết bị này?');">Xóa</a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <!-- Pagination -->
                <div style="text-align: center; margin-top: 20px;">
                    <a href="view-region?page=${currentPage - 1}" 
                       class="btn-pagination ${currentPage == 1 ? 'disabled' : ''}">Previous</a>

                    <c:forEach begin="1" end="${numberOfPages}" var="i">
                        <a href="view-region?page=${i}" 
                           class="btn-pagination ${currentPage == i ? 'active' : ''}">${i}</a>
                    </c:forEach>

                    <a href="view-region?page=${currentPage + 1}" 
                       class="btn-pagination ${currentPage == numberOfPages ? 'disabled' : ''}">Next</a>
                </div>



                <a href="AddEquipments.jsp" class="btn-green">+ Thêm thiết bị mới</a>
            </div>
        </div>

    </body>
</html>
