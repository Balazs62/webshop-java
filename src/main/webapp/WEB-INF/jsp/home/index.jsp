<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page isELIgnored="false" %>

<%@ include file="../shared/header.jsp" %>

<div class="text-center mb-5 mt-4">
    <h1 class="display-4 fw-bold">Termékeink</h1>
</div>

<div class="row row-cols-1 row-cols-md-3 g-4">
    <c:forEach items="${products}" var="p">
        <div class="col">
            <div class="card h-100 shadow-sm border-0 p-2">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title fw-bold">${p.name}</h5>
                    <p class="card-text text-muted small">${p.description}</p>
                    
                    <div class="mt-auto">
                        <p class="fs-5 fw-bold text-primary">
                            <fmt:formatNumber value="${p.basePrice}" type="currency" currencySymbol="Ft" maxFractionDigits="0"/>
                        </p>
						<div class="cart-container">
                            <label class="small text-muted mb-1">Méret választása:</label>
                            
                            <select class="form-select form-select-sm mb-3 size-select">
                                <c:forEach items="${p.productVariants}" var="v">
                                    <option value="${v.size}">${v.size} (${v.stockQuantity} db)</option>
                                </c:forEach>
                            </select>
                            
                            <button type="button" class="btn btn-dark w-100" onclick="ajaxAddToCart(${p.id}, this)">
                                <i class="bi bi-cart-plus"></i> Kosárba
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
<script type="text/javascript">
function ajaxAddToCart(productId, button) {
    const container = button.closest('.cart-container');
    const sizeSelect = container.querySelector('.size-select');
    const selectedSize = sizeSelect.value;
    
    // Eredeti gomb tartalom mentése
    const originalContent = button.innerHTML;
    button.disabled = true;
    button.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Töltés...';

    // Kérés küldése a szervernek
    fetch('/cart/api/add', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
            'productId': productId,
            'size': selectedSize
        })
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            const badge = document.getElementById('cart-count-badge');
            if (badge) {
                badge.innerText = data.cartCount;
                
                badge.style.display = 'inline-block';
                
             
                badge.style.transform = 'translate(-50%, -50%) scale(1.4)';
                setTimeout(() => {
                    badge.style.transform = 'translate(-50%, -50%) scale(1)';
                }, 200);
            }

            button.classList.remove('btn-dark');
            button.classList.add('btn-success');
            button.innerHTML = '<i class="bi bi-check2-circle"></i> Hozzáadva!';

            setTimeout(() => {
                button.classList.remove('btn-success');
                button.classList.add('btn-dark');
                button.innerHTML = originalContent;
                button.disabled = false;
            }, 2000);

        } else {
            alert(data.message);
            button.disabled = false;
            button.innerHTML = originalContent;
        }
    })
    .catch(err => {
        console.error("Hiba történt:", err);
        alert("Hálózati hiba történt a kosárba rakás során.");
        button.disabled = false;
        button.innerHTML = originalContent;
    });
}
</script>
<%@ include file="../shared/footer.jsp" %>