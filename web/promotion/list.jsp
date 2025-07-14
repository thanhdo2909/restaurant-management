<%-- 
    Document   : list
    Created on : Jul 14, 2025, 10:54:19 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Model.Promotion"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Mã giảm giá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .promo-card {
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.05);
            transition: 0.3s;
        }

        .promo-card:hover {
            transform: scale(1.02);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }

        .promo-status {
            font-weight: bold;
        }

        .promo-status.active {
            color: green;
        }

        .promo-status.inactive {
            color: red;
        }
    </style>
</head>
<body>

    <%@ include file="../includes/Nappar.jsp" %>

    <section class="py-5">
        <div class="container text-center mb-4">
            <h2>Danh sách mã giảm giá</h2>
            <a href="promotion?action=add-form" class="btn btn-primary">+ Thêm mã mới</a>
        </div>

        <div class="container">
            <div class="row gy-4">
                <c:forEach items="${list}" var="p">
                    <div class="col-lg-4 col-md-6">
                        <div class="card promo-card p-3 h-100">
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title mb-2">🎟 ${p.promoCode}</h5>
                                <p class="mb-1">
                                    Giảm: <strong>${p.discountPercent}%</strong>
                                </p>
                                <p class="mb-1">
                                    Hết hạn: 
                                    <fmt:formatDate value="${p.expirationDate}" pattern="dd-MM-yyyy"/>
                                </p>
                                <p class="promo-status ${p.isActive ? 'active' : 'inactive'}">
                                    ${p.isActive ? 'Đang áp dụng' : 'Đã khóa'}
                                </p>

                                <div class="mt-auto d-flex gap-2">
                                    <a href="promotion?action=edit-form&id=${p.promoID}" class="btn btn-sm btn-warning">✏ Sửa</a>
                                    <a href="promotion?action=delete&id=${p.promoID}" class="btn btn-sm btn-danger">🗑 Xóa</a>
                                    <a href="promotion?action=toggle&id=${p.promoID}&active=${!p.isActive}" 
                                       class="btn btn-sm ${p.isActive ? 'btn-secondary' : 'btn-success'}">
                                        ${p.isActive ? '🔒 Khóa' : '✅ Mở'}
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
