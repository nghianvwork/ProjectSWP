<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Region Management</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .main-content {
            padding: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="navigation.jsp" />
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2">
            <jsp:include page="Sidebar.jsp" />
        </div>
        <div class="col-md-10 main-content">
            <h2 class="mb-4">Region Management</h2>

            <!-- Search Bar -->
            <div class="form-inline mb-3">
                <input type="text" id="searchInput" class="form-control mr-2" placeholder="Search by region name">
                <button class="btn btn-primary" onclick="searchDorms()">Search</button>
            </div>

            <!-- Regions Table -->
            <table class="table table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Empty Court</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dorm" items="${dormList}" varStatus="loop">
                        <tr>
                            <td>${dorm.name}</td>
                            <td>${dorm.address}</td>
                            <td>${dorm.emptyRoom}</td>
                            <td>
                                <!-- Update Button -->
                                <button class="btn btn-sm btn-warning" data-toggle="modal" data-target="#updateModal">Update</button>
                                <a href="dorm-detail?id=${dorm.id}" class="btn btn-sm btn-info">Detail</a>
                                <a href="delete-dorm?id=${dorm.id}" class="btn btn-sm btn-danger" onclick="return confirmDelete()">Delete</a>

                                <!-- Update Modal -->
                                <div class="modal fade" id="updateModal" tabindex="-1" role="dialog">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <form action="update-region" method="POST">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Update Region</h5>
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                </div>
                                                <div class="modal-body">
                                                    <input type="hidden" name="regionID" value="${dorm.id}">
                                                    <div class="form-group">
                                                        <label>Region Name</label>
                                                        <input type="text" name="RegionName" class="form-control" value="${dorm.name}" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Address</label>
                                                        <input type="text" name="address" class="form-control" value="${dorm.address}">
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Empty Court</label>
                                                        <input type="number" name="empty" class="form-control" value="${dorm.emptyRoom}">
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="submit" class="btn btn-success">Update</button>
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
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

            <!-- Pagination -->
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="manage-department?page=${currentPage - 1}">Previous</a>
                </li>
                <c:forEach begin="1" end="${numberOfPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="manage-department?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == numberOfPages ? 'disabled' : ''}">
                    <a class="page-link" href="manage-department?page=${currentPage + 1}">Next</a>
                </li>
            </ul>

            <!-- Add Region Button -->
            <button class="btn btn-success mt-3" data-toggle="modal" data-target="#addModal">Add Region</button>

            <!-- Add Modal -->
            <div class="modal fade" id="addModal" tabindex="-1" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="add-dorm" method="POST">
                            <div class="modal-header">
                                <h5 class="modal-title">Add Region</h5>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label>Region Name</label>
                                    <input type="text" name="departmentName" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Address</label>
                                    <input type="text" name="address" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>Empty Court</label>
                                    <input type="number" name="emptyRoom" class="form-control" value="0" min="0">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-success">Add</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Scripts -->
<script>
    function searchDorms() {
        let input = document.getElementById("searchInput").value.toUpperCase();
        let rows = document.querySelectorAll("table tbody tr");
        rows.forEach(row => {
            let name = row.cells[0].textContent.toUpperCase();
            row.style.display = name.includes(input) ? "" : "none";
        });
    }

    function confirmDelete() {
        return confirm("Do you want to delete this?");
    }
</script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
