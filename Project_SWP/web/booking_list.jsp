<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh s�ch ??t s�n</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h3>??n ??t s�n c?a b?n</h3>
    <table class="table table-bordered mt-3">
        <thead>
            <tr>
                <th>S�n</th>
                <th>Ng�y</th>
                <th>Th?i gian</th>
                <th>Tr?ng th�i</th>
                <th>H�nh ??ng </th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="booking" items="${bookings}">
            <tr>
                <td>${booking.court_name}</td>
                <td>${booking.date}</td>
                <td>${booking.startTime} - ${booking.endTime}</td>
                <td>${booking.status}</td>
                <td>
                    <c:if test="${booking.status eq 'confirmed'}">
                        <form action="cancel-booking" method="post" onsubmit="return confirm('B?n c� ch?c ch?n mu?n h?y?');">
                            <input type="hidden" name="bookingId" value="${booking.booking_id}">
                            <button type="submit" class="btn btn-danger btn-sm">H?y</button>
                        </form>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
