<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-header bg-success text-white text-center">
                    <h4>Change Password</h4>
                </div>
                <div class="card-body">

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <c:choose>
                                <c:when test="${error == 'username'}">
                                    Username not found. Please try again!
                                </c:when>
                                <c:when test="${error == 'incorrect'}">
                                    Old password is incorrect!
                                </c:when>
                                <c:when test="${error == 'mismatch'}">
                                    New passwords do not match!
                                </c:when>
                                <c:otherwise>
                                    ${error}
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>

                    <form action="update-pass" method="post" id="changePassForm">
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" name="username" class="form-control" id="username" required>
                        </div>
                        <div class="form-group">
                            <label for="oldPassword">Old Password</label>
                            <input type="password" name="old-password" class="form-control" id="oldPassword" required>
                        </div>
                        <div class="form-group">
                            <label for="newPassword">New Password</label>
                            <input type="password" name="new-password" class="form-control" id="newPassword" required>
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">Confirm New Password</label>
                            <input type="password" name="confirm-password" class="form-control" id="confirmPassword" required>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-success">Change Password</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const form = document.getElementById('changePassForm');
        const newPassword = document.getElementById('newPassword');
        const confirmPassword = document.getElementById('confirmPassword');

        form.addEventListener('submit', function (e) {
            if (newPassword.value !== confirmPassword.value) {
                e.preventDefault();
                alert("New passwords do not match. Please re-enter.");
            }
        });
    });
</script>
</body>
</html>
