<%-- 
    Document   : homefooter
    Created on : May 24, 2025, 9:30:27 AM
    Author     : sangn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .custom-footer {
                background-color: #0d3c80;
                color: #ffffff;
                font-family: Arial, sans-serif;
                font-size: 14px;
            }

            .footer-top {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                padding: 40px 20px;
                border-bottom: 1px solid #285da1;
            }

            .footer-section {
                flex: 1 1 30%;
                margin: 10px;
            }

            .footer-section h4 {
                font-size: 16px;
                margin-bottom: 10px;
                border-bottom: 2px solid #ffffff55;
                padding-bottom: 5px;
            }

            .footer-section ul {
                list-style: none;
                padding-left: 0;
            }

            .footer-section ul li {
                margin-bottom: 6px;
            }

            .footer-section ul li a {
                color: #fff;
                text-decoration: none;
            }

            .footer-section ul li a:hover {
                text-decoration: underline;
            }

            .icon {
                margin-right: 5px;
            }

            .contact-box .hotline {
                font-size: 18px;
                color: #4fc3f7;
                font-weight: bold;
                margin: 8px 0;
            }

            .call-btn {
                background-color: #ffc107;
                border: none;
                color: #000;
                padding: 8px 16px;
                font-weight: bold;
                cursor: pointer;
                border-radius: 4px;
            }

            .call-btn:hover {
                background-color: #ffb300;
            }

            .footer-bottom {
                background-color: #061c3f;
                color: #ccc;
                text-align: center;
                padding: 15px 10px;
                font-size: 13px;
            }

            .footer-links {
                margin-top: 8px;
            }

            .footer-links a {
                color: #ccc;
                text-decoration: none;
                margin: 0 6px;
            }

            .footer-links a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
       <footer class="custom-footer">
            <div class="footer-top">
                <div class="footer-section">
                    <h4>GIỚI THIỆU</h4>
                    <p>Hệ thống hỗ trợ tìm kiếm sân nhanh, giúp bạn tìm và đặt sân hiệu quả.</p>
                    <ul>
                        <li><a href="#">Chính sách bảo mật</a></li>
                        <li><a href="#">Chính sách huỷ (đổi trả)</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>THÔNG TIN</h4>
                    <p><i class="icon">🏢</i> Nhóm 3</p>
                    <p><i class="icon">📄</i> MST: 0123456789</p>
                    <p><i class="icon">📧</i> Email: support@SanCauLong.vn</p>
                    <p><i class="icon">📍</i> Địa chỉ: Trường Đại Học FPT Hà Nội</p>
                    <p><i class="icon">📞</i> Điện thoại: 0123.456.789</p>
                </div>
                <div class="footer-section contact-box">
                    <h4>LIÊN HỆ</h4>
                    <p>Chăm sóc khách hàng:</p>
                    <p class="hotline">0123.456.789</p>
                    <button class="call-btn">Gọi ngay</button>
                </div>
            </div>
            <div class="footer-bottom">
                © 2025 SanCauLong.vn. Toàn bộ bản quyền thuộc về SanCauLong.vn.
                <div class="footer-links">
                    <a href="#">Dành cho chủ sân</a> | 
                    <a href="#">Điều khoản</a> | 
                    <a href="#">Chính sách</a> | 
                    <a href="#">Giới thiệu</a>
                </div>
            </div>
        </footer>
    </body>
</html>
