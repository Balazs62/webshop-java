<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="../shared/header.jsp" %>

<div class="container mt-5 mb-5">
    <div class="row align-items-start">
        
        <div class="col-lg-8 col-md-12 mb-4">
            <h2 class="mb-4"><i class="bi bi-shield-check text-success"></i> Pénztár</h2>
            
            <div class="card shadow-sm border-0">
                <div id="quickAddressArea" class="p-4">
                    
                    <div class="row">
                        <div class="col-md-6 border-end pe-md-4">
                            <h5 class="mb-3 text-primary"><i class="bi bi-truck me-2"></i>Szállítási cím</h5>
                            <div class="row g-2">
                                <div class="col-4"><input type="text" id="s_zipCode" class="form-control" placeholder="Irsz." required></div>
                                <div class="col-8"><input type="text" id="s_city" class="form-control" placeholder="Város" required></div>
                                <div class="col-12"><input type="text" id="s_street" class="form-control" placeholder="Utca, házszám" required></div>
                                <div class="col-12"><input type="text" id="s_houseNumber" class="form-control" placeholder="Emelet, ajtó (opcionális)"></div>
                            </div>
                            
                            <div class="form-check form-switch mt-4 p-3 bg-light rounded border">
                                <input class="form-check-input ms-0 me-2" type="checkbox" id="sameAsShip" checked onchange="toggleBillingSection()">
                                <label class="form-check-label fw-bold" for="sameAsShip">A számlázási cím megegyezik</label>
                            </div>
                        </div>
            
                        <div class="col-md-6 ps-md-4 d-none" id="billingSection">
                            <h5 class="mb-3 text-secondary"><i class="bi bi-receipt me-2"></i>Számlázási cím</h5>
                            <div class="row g-2">
                                <div class="col-4"><input type="text" id="b_zipCode" class="form-control" placeholder="Irsz."></div>
                                <div class="col-8"><input type="text" id="b_city" class="form-control" placeholder="Város"></div>
                                <div class="col-12"><input type="text" id="b_street" class="form-control" placeholder="Utca, házszám"></div>
                                <div class="col-12"><input type="text" id="b_houseNumber" class="form-control" placeholder="Adószám (ha céges)"></div>
                            </div>
                        </div>
                    </div> <div class="mt-4 pt-3 border-top">
                        <button type="button" onclick="saveAddressAjax()" class="btn btn-primary btn-lg w-100 shadow-sm fw-bold">
                            <span id="btnText">ADATOK MENTÉSE ÉS FOLYTATÁS</span>
                            <span id="btnLoader" class="spinner-border spinner-border-sm d-none"></span>
                        </button>
                    </div>
                    
                </div>
            </div>
        </div> 
        <div class="col-lg-4 col-md-12">
            <div class="card shadow-sm sticky-top mt-6" style="top: 20px; border: none;">
                <div class="card-header bg-primary text-white fw-bold py-3">Rendelésed</div>
                <div class="card-body">
                    <c:forEach var="item" items="${cart}">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="small">${item.name} x ${item.quantity}</span>
                            <span class="small fw-bold">
                                <fmt:formatNumber value="${item.price * item.quantity}" type="number" /> Ft
                            </span>
                        </div>
                    </c:forEach>
                    <hr>
                    <div class="d-flex justify-content-between h5 fw-bold text-primary">
                        <span>Fizetendő:</span>
                        <span><fmt:formatNumber value="${totalPrice}" type="number" /> Ft</span>
                    </div>
                </div>
            </div>
        </div> </div> </div> <script>
// JAVÍTOTT JS: A Bootstrap saját 'd-none' osztályát kapcsolgatjuk a style módosítása helyett
function toggleBillingSection() {
    const isSame = document.getElementById('sameAsShip').checked;
    const section = document.getElementById('billingSection');
    
    if (isSame) {
        section.classList.add('d-none'); // Elrejtés
    } else {
        section.classList.remove('d-none'); // Megjelenítés
    }
}

function saveAddressAjax() {
    const isSame = document.getElementById('sameAsShip').checked;
    
    const params = new URLSearchParams();
    params.append('s_zipCode', document.getElementById('s_zipCode').value);
    params.append('s_city', document.getElementById('s_city').value);
    params.append('s_street', document.getElementById('s_street').value);
    params.append('s_houseNumber', document.getElementById('s_houseNumber').value);
    params.append('sameAsShipping', isSame ? 'on' : 'off');

    if (!isSame) {
        params.append('b_zipCode', document.getElementById('b_zipCode').value);
        params.append('b_city', document.getElementById('b_city').value);
        params.append('b_street', document.getElementById('b_street').value);
        params.append('b_houseNumber', document.getElementById('b_houseNumber').value);
    }

    document.getElementById('btnText').innerText = 'Mentés...';
    document.getElementById('btnLoader').classList.remove('d-none');

    fetch('<c:url value="/cart/add-quick-address"/>', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params
    })
    .then(response => {
        if (response.ok) {
            window.location.reload(); 
        } else {
            alert("Hiba történt! Ellenőrizze a megadott adatokat.");
            document.getElementById('btnText').innerText = 'ADATOK MENTÉSE ÉS FOLYTATÁS';
            document.getElementById('btnLoader').classList.add('d-none');
        }
    })
    .catch(err => {
        console.error("Hálózati hiba:", err);
        document.getElementById('btnText').innerText = 'ADATOK MENTÉSE ÉS FOLYTATÁS';
        document.getElementById('btnLoader').classList.add('d-none');
    });
}
</script>

<%@ include file="../shared/footer.jsp" %>