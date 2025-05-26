<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Court Management</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
    </style>
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-custom">
    <a class="navbar-brand font-weight-bold" href="#">🏠 Region Admin</a>
    <div class="ml-auto">
        <a class="btn btn-outline-danger" href="login">Log out</a>
    </div>
</nav>
<div class="container-fluid">
    <div class="row mt-4">
        <div class="col-md-2">
            <jsp:include page="Sidebar.jsp" />
        </div>
        <div class="col-md-10">
            <div class="main-content">
                <h3 class="mb-4 text-primary">🏙 Court Management</h3>
                <div class="form-inline mb-4">
                    <input type="text" id="searchInput" class="form-control mr-2 w-50" placeholder="🔍 Search by court number">
                    <button class="btn btn-primary" onclick="searchCourts()">Search</button>
                </div>

                <div class="mb-4">
                    <button class="btn btn-success" data-toggle="modal" data-target="#courtModal">+ Add Court</button>
                </div>

                <div class="modal fade" id="courtModal" tabindex="-1" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form id="courtForm" action="courts" method="post">
                                <div class="modal-header">
                                    <h5 class="modal-title">${court != null ? 'Update Court' : 'Add Court'}</h5>
                                    <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="action" value="${court != null ? 'update' : 'add'}">
                                    <input type="hidden" name="courtId" value="${court != null ? court.court_id : ''}">
                                    <div class="form-group">
                                        <label for="courtNumber">Court Number</label>
                                        <input type="text" class="form-control" id="courtNumber" name="courtNumber" value="${court != null ? court.court_number : ''}" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="status">Status</label>
                                        <input type="text" class="form-control" id="status" name="status" value="${court != null ? court.status : ''}" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="areaId">Area ID</label>
                                        <input type="number" class="form-control" id="areaId" name="areaId" value="${court != null ? court.area_id : ''}" required>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-success">${court != null ? 'Update' : 'Save'}</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover table-bordered">
                        <thead class="thead-dark">
                        <tr>
                            <th>ID</th>
                            <th>Court Number</th>
                            <th>Status</th>
                            <th>Area ID</th>
                            <th style="width: 180px;">Action</th>
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
                                    <a href="courts?action=edit&courtId=${court.court_id}" class="btn btn-warning btn-sm">Update</a>
                                    <button class="btn btn-danger btn-sm delete-btn" data-id="${court.court_id}">Delete</button>
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
<script>
    function searchCourts() {
        let input = document.getElementById("searchInput").value.toUpperCase();
        let rows = document.querySelectorAll("table tbody tr");
        rows.forEach(row => {
            let courtNumber = row.cells[1].textContent.toUpperCase();
            row.style.display = courtNumber.includes(input) ? "" : "none";
        });
    }

    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function () {
            if (confirm('Do you want to delete this court?')) {
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
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
