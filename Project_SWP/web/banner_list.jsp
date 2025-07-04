<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh sách Banner</title>
</head>
<body>
    <h2>Danh sách Banner</h2>
    <c:if test="${not empty msg}">
        <div style="color: green;">${msg}</div>
    </c:if>
    <a href="banner-add">+ Thêm Banner</a>
    <table border="1" cellpadding="5">
        <tr>
            <th>Ảnh</th>
            <th>Tiêu đề</th>
            <th>Chú thích</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
        </tr>
        <c:forEach var="banner" items="${bannerList}">
            <tr>
                <td>
                    <img src="${pageContext.request.contextPath}/${banner.imageUrl}" width="120"/>
                </td>
                <td>${banner.title}</td>
                <td>${banner.caption}</td>
                <td>
                    <c:choose>
                        <c:when test="${banner.status}">Hiện</c:when>
                        <c:otherwise>Ẩn</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <a href="banner-edit?id=${banner.id}">Sửa</a>
                     <!--Nếu muốn thêm xóa:--> 
                    <form action="banner-delete" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="${banner.id}"/>
                        <button type="submit" onclick="return confirm('Xóa banner này?')">Xóa</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
