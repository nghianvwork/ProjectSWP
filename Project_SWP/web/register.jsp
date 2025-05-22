<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f0f0f0;
        }
        .register-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            width: 300px;
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
            font-size: 24px;
        }
        .input-group {
            position: relative;
            margin-bottom: 15px;
            text-align: left;
        }
        .input-field, select {
            width: 100%;
            padding: 10px 10px 10px 40px;
            border: 1px solid #ccc;
            border-radius: 25px;
            box-sizing: border-box;
            font-size: 14px;
        }
        .input-field:focus, select:focus {
            outline: none;
            border-color: #1da1f2;
        }
        .input-icon {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            font-size: 16px;
        }
        .btn {
            width: 100%;
            padding: 10px;
            background-color: #1da1f2;
            color: #fff;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }
        .btn:hover {
            background-color: #1a91da;
        }
        .error-message {
            color: red;
            margin-bottom: 15px;
            font-size: 14px;
        }
        .login-link {
            margin-top: 15px;
            font-size: 14px;
            color: #1da1f2;
            text-decoration: none;
        }
        .login-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h2>Register</h2>
        <% if(request.getAttribute("errorRegister") != null) { %>
            <div class="error-message"><%= request.getAttribute("errorRegister") %></div>
        <% } %>
        <form action="RegisterServlet" method="post">
            <div class="input-group">
                <span class="input-icon">?</span>
                <input type="text" class="input-field" name="username" placeholder="Username" required>
            </div>
            
            <div class="input-group">
                <span class="input-icon">?</span>
                <input type="password" class="input-field" name="password" placeholder="Password" required>
            </div>
            <div class="input-group">
                <span class="input-icon">?</span>
                <input type="email" class="input-field" name="email" placeholder="Email" required>
            </div>
            <div class="input-group" style="padding-left: 40px;">
                <label for="role">Role:</label>
                <select name="role" id="role" required style="border-radius: 25px; padding: 10px; width: 100%; font-size: 14px; margin-top: 5px;">
                    <option value="user" selected>User</option>
                    <option value="staff">Staff</option>
                </select>
            </div>
            <button type="submit" class="btn">Register</button>
        </form>
        <a href="login.jsp" class="login-link">Already have an account? Login here</a>
    </div>
</body>
</html>
