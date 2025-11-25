<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <c:set var="contextPath" value="${pageContext.request.contextPath}" />

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Admin Dashboard - Electro</title>
            <link href="${contextPath}/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container">
                    <a class="navbar-brand" href="#">Electro Admin</a>
                    <div class="collapse navbar-collapse">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="${contextPath}/logout">Đăng xuất</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container mt-5">
                <h1>Chào mừng quản trị viên!</h1>
                <p>Đây là trang quản trị.</p>
            </div>
        </body>

        </html>