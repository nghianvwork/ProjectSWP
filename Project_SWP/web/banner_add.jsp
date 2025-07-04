<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Thêm Banner mới</title>
</head>
<body>
    <h2>Thêm Banner mới</h2>
    <form action="banner-add" method="post" enctype="multipart/form-data">
        Ảnh: <input type="file" name="image" required/><br/>
        Tiêu đề: <input type="text" name="title" required/><br/>
        Chú thích: <input type="text" name="caption"/><br/>
        Hiển thị: <input type="checkbox" name="status" value="1" checked/><br/>
        <button type="submit">Thêm Banner</button>
    </form>
    <a href="banner-list">Quay lại danh sách</a>
</body>
</html>
