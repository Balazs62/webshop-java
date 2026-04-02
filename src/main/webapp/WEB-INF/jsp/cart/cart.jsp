<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page isELIgnored="false" %>

<%@ include file="../shared/header.jsp" %>

<head>
    <title>Kosár - Webshop</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        /* Sima átmenet a sorok törléséhez */
        .cart-row {
            transition: all 0.3s ease;
        }
    </style>
</head>

<div class="container mt-5">
    <h2 class="mb-4"><i class="bi bi-cart3"></i> Kosarad tartalma</h2>
    
    <c:choose>
        <c:when test="${not empty cart}">
            <div class="table-responsive">
                <table class="table table-hover mt-2">
                    <thead class="table-dark">
                        <tr>
                            <th>Termék</th>
                            <th>Méret</th>
                            <th>Ár</th>
                            <th>Mennyiség</th>
                            <th>Összesen</th>
                            <th class="text-center">Törlés</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${cart}" var="item">
                            <tr class="cart-row align-middle">
                                <td>${item.name}</td>
                                <td><span class="badge bg-secondary">${item.size}</span></td>
                                <td><fmt:formatNumber value="${item.price}" type="number" /> Ft</td>
                                <td style="min-width: 130px;">
                                    <div class="d-flex align-items-center gap-2">
                                        <form action="<c:url value='/cart/update'/>" method="post" class="m-0">
                                            <input type="hidden" name="productId" value="${item.productId}">
                                            <input type="hidden" name="size" value="${item.size}">
                                            <input type="hidden" name="action" value="decrease">
                                            <button type="submit" class="btn btn-outline-secondary btn-sm" 
                                                    ${item.quantity <= 1 ? 'disabled' : ''}>-</button>
                                        </form>
                                
                                        <span class="fw-bold px-2">${item.quantity}</span>
                                
                                        <form action="<c:url value='/cart/update'/>" method="post" class="m-0">
                                            <input type="hidden" name="productId" value="${item.productId}">
                                            <input type="hidden" name="size" value="${item.size}">
                                            <input type="hidden" name="action" value="increase">
                                            <button type="submit" class="btn btn-outline-secondary btn-sm">+</button>
                                        </form>
                                    </div>
                                </td>
                                <td class="fw-bold">
                                    <fmt:formatNumber value="${item.price * item.quantity}" type="number" /> Ft
                                </td>
                                <td class="text-center">
                                    <button type="button" class="btn btn-outline-danger btn-sm border-0" 
                                            onclick="ajaxRemove(${item.productId}, '${item.size}', this)">
                                        <i class="bi bi-trash3 fs-5"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="text-end mt-4 p-3 bg-light rounded shadow-sm">
                <h4 class="mb-3">Fizetendő: <span id="grand-total" class="text-primary"><fmt:formatNumber value="${totalPrice}" type="number" /></span> Ft</h4>
                <div class="d-flex justify-content-end gap-2">
                    <a href="<c:url value='/' />" class="btn btn-outline-primary">
                        <i class="bi bi-arrow-left"></i> Vásárlás folytatása
                    </a>
                    <a href="<c:url value='/cart/checkout'/>" class="btn btn-success btn-lg px-5">
                        Pénztárhoz <i class="bi bi-arrow-right-short"></i>
                    </a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info mt-4 py-5 text-center">
                <i class="bi bi-cart-x fs-1 d-block mb-3"></i>
                <h4>A kosarad jelenleg üres.</h4>
                <p class="text-muted">Nézz szét termékeink között!</p>
                <a href="<c:url value='/' />" class="btn btn-primary mt-3">Vissza a főoldalra</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script type="text/javascript">
function ajaxRemove(productId, size, button) {
    if (!confirm("Biztosan törlöd ezt a terméket a kosárból?")) return;

    const row = button.closest('tr');

    fetch('/cart/api/remove?productId=' + productId + '&size=' + size, {
        method: 'POST'
    })
    .then(res => {
        if (!res.ok) throw new Error("Hálózati hiba történt");
        return res.json();
    })
    .then(data => {
        if (data.success) {
            row.style.opacity = '0';
            row.style.transform = "translateX(30px)";
            
            setTimeout(() => {
                row.remove();
                
                const totalElem = document.getElementById('grand-total');
                if (totalElem) {
                    totalElem.innerText = data.totalPrice;
                }

                if (data.isEmpty) {
                    location.reload();
                }
            }, 300);

            const badge = document.getElementById('cart-count-badge');
            if (badge) {
                badge.innerText = data.cartCount;
            }
        } else {
            alert("Hiba: Nem sikerült a törlés a szerveren.");
        }
    })
    .catch(err => {
        console.error("Hiba részletei:", err);
        alert("Hiba történt a törlés során! Ellenőrizd az internetkapcsolatot.");
    });
}
</script>

<%@ include file="../shared/footer.jsp" %>