<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        /* CSS nh? b?n ?� c� */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background: url('') no-repeat center center fixed;
            background-size: cover;
            backdrop-filter: blur(5px);
            -webkit-backdrop-filter: blur(5px);
        }
        .login-container {
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
        }
        .input-field {
            width: 100%;
            padding: 10px 10px 10px 40px;
            border: 1px solid #ccc;
            border-radius: 25px;
            box-sizing: border-box;
            font-size: 14px;
        }
        .input-field:focus {
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
        .remember-me {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            margin: 10px 0;
            font-size: 14px;
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
        .forgot-password, .register {
            display: block;
            margin-top: 10px;
            color: #1da1f2;
            text-decoration: none;
            font-size: 14px;
        }
        .forgot-password:hover, .register:hover {
            text-decoration: underline;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <% if (request.getAttribute("errorLogin") != null) { %>
            <div class="error"><%= request.getAttribute("errorLogin") %></div>
        <% } %>
        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
            <div class="input-group">
                <span class="input-icon">?</span>
                <input type="text" class="input-field" name="username" placeholder="Username" required>
            </div>
            <div class="input-group">
                <span class="input-icon">?</span>
                <input type="password" class="input-field" name="password" placeholder="Password" required>
            </div>
            <div class="remember-me">
                <input type="checkbox" name="rememberMe" id="remember">
                <label for="remember">Remember Me</label>
            </div>
            <button type="submit" class="btn">Submit</button>
            <a href="${pageContext.request.contextPath}/forgotPassword" class="forgot-password">Forgot Password?</a>
            <p>Don't have an account? <a href="${pageContext.request.contextPath}/register" class="register">Register</a></p>
        </form>
    </div>
</body>
</html>
