<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Sửa Banner</title>
</head>
<body>
    <h2>Sửa Banner</h2>
    <form action="banner-edit" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${banner.id}"/>
        Ảnh: <input type="file" name="image"/><br/>
        <img src="${pageContext.request.contextPath}/${banner.imageUrl}" width="120"/><br/>
        Tiêu đề: <input type="text" name="title" value="${banner.title}" required/><br/>
        Chú thích: <input type="text" name="caption" value="${banner.caption}"/><br/>
        Hiển thị: <input type="checkbox" name="status" value="1" <c:if test="${banner.status}">checked</c:if>/><br/>
        <button type="submit">Cập nhật Banner</button>
    </form>
    <a href="banner-list">Quay lại danh sách</a>
</body>
</html>
