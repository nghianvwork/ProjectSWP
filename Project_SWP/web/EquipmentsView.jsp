<%-- 
    Document   : EquipmentsView
    Created on : May 25, 2025, 11:28:33 PM
    Author     : admin
--%>

<%@ page import="java.util.List" %>
<%@ page import="Model.Equipments" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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
        padding: 10px 30px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        width: 100%;
    }
    .navbar-brand {
        font-size: 18px;
        font-weight: bold;
        color: #000;
        text-decoration: none;
    }
    .navbar-custom .btn {
        border-radius: 8px;
    }
</style>
</head>
<body>

  <!-- Navbar -->
<div style="margin-left: 270px;"> <!-- Đẩy sang phải để nằm sau sidebar -->
    <nav class="navbar navbar-custom d-flex justify-content-between align-items-center">
        <div>
            <a class="navbar-brand font-weight-bold" href="#">🏸 Badminton System</a>
        </div>
        <div>
            <a class="btn btn-logout" href="login">Logout</a>
        </div>
    </nav>
</div>


    <jsp:include page="Sidebar.jsp" />

    <%
        List<Equipments> equipments = (List<Equipments>) request.getAttribute("equipments");
        if (equipments == null) equipments = java.util.Collections.emptyList();
        String status = (String) request.getAttribute("status");
    %>

    <!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Equipment View</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f7f7f7;
                margin-top: 70px;
                margin-left: 270px; /* Chừa chỗ cho sidebar */
                padding: 30px;
            }

            h2 {
                color: #333;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: white;
                box-shadow: 0 0 5px rgba(0,0,0,0.1);
            }

            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #4CAF50;
                color: white;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            .btn-add {
                margin-top: 20px;
                display: inline-block;
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                border: none;
                text-decoration: none;
                font-weight: bold;
                border-radius: 5px;
                cursor: pointer;
            }

            .btn-add:hover {
                background-color: #0056b3;
            }

            .status-message {
                font-weight: bold;
                padding: 10px;
                margin-bottom: 15px;
                border-radius: 4px;
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



        </style>
    </head>




    <h2>Danh sách thiết bị</h2>

    <% if ("success".equals(status)) { %>
    <p class="status-message success">✔ Thiết bị đã được thêm thành công!</p>
    <% } else if ("fail".equals(status)) { %>
    <p class="status-message fail">✘ Thêm thiết bị thất bại. Vui lòng thử lại.</p>
    <% } else if ("duplicate".equals(status)) { %>
    <p class="status-message duplicate">⚠ Thiết bị đã tồn tại!</p>
    <% } %>

    <table>
        <tr>
            <th>ID</th>
            <th>Tên thiết bị</th>
            <th>Giá</th>
        </tr>
        <% for (Equipments e : equipments) { %>
        <tr>
            <td><%= e.getEquipment_id() %></td>
            <td><%= e.getName() %></td>
            <td><%= e.getPrice() %> VND</td>
        </tr>
        <% } %>
    </table>
</body>
</html>
