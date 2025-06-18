<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts & Custom CSS -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(to right, #6dd5ed, #2193b0);
            min-height: 100vh;
        }
        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        .card-header {
            border-radius: 1rem 1rem 0 0;
            background-color: #28a745;
        }
        .btn-success {
            border-radius: 50px;
            padding: 10px 30px;
        }
    </style>
</head>
<body>
<div class="container d-flex align-items-center justify-content-center" style="min-height: 100vh;">
    <div class="col-md-6">
        <div class="card">
            <div class="card-header text-white text-center py-3">
                <h3>🔒 Change Password</h3>
            </div>
            <div class="card-body p-4">

                <!-- Error message -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger text-center">
                        <c:choose>
                            <c:when test="${error == 'username'}">Username not found. Please try again!</c:when>
                            <c:when test="${error == 'incorrect'}">Old password is incorrect!</c:when>
                            <c:when test="${error == 'mismatch'}">New passwords do not match!</c:when>
                            <c:otherwise>${error}</c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

                <!-- Form -->
                <form action="update-pass" method="post" id="changePassForm">
                    <div class="mb-3">
                        <label for="username" class="form-label">👤 Username</label>
                        <input type="text" name="username" class="form-control" id="username" required>
                    </div>
                    <div class="mb-3">
                        <label for="oldPassword" class="form-label">🔑 Old Password</label>
                        <input type="password" name="old-password" class="form-control" id="oldPassword" required>
                    </div>
                    <div class="mb-3">
                        <label for="newPassword" class="form-label">🆕 New Password</label>
                        <input type="password" name="new-password" class="form-control" id="newPassword" required>
                    </div>
                    <div class="mb-4">
                        <label for="confirmPassword" class="form-label">✅ Confirm New Password</label>
                        <input type="password" name="confirm-password" class="form-control" id="confirmPassword" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-success w-50">Change Password</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JS -->
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
