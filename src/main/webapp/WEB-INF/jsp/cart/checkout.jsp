<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="../shared/header.jsp" %>

<div class="container mt-5 mb-5">
    <div class="row align-items-start">

        <div class="col-lg-8 col-md-12 mb-4">
            <h2 class="mb-4"><i class="bi bi-shield-check text-success"></i> Pénztár</h2>

            <div class="card shadow-sm border-0 mb-3" id="addressInputCard">
                <div class="card-body p-4">
                    <h5 class="mb-3 text-primary"><i class="bi bi-truck me-2"></i>Szállítási cím</h5>
                    <div class="row g-2">
                        <div class="col-4"><input type="number" id="s_zipCode" class="form-control" placeholder="Irányítószám" required></div>
                        <div class="col-8"><input type="text" id="s_city" class="form-control" placeholder="Város" required></div>
                        <div class="col-12"><input type="text" id="s_street" class="form-control" placeholder="Utca neve" required></div>
                        <div class="col-6"><input type="text" id="s_houseNumber" class="form-control" placeholder="Házszám"></div>
                        <div class="col-6"><input type="text" id="s_building" class="form-control" placeholder="Épület"></div>
                        <div class="col-4"><input type="text" id="s_apartment" class="form-control" placeholder="Lépcsőház"></div>
                        <div class="col-4"><input type="text" id="s_floor" class="form-control" placeholder="Emelet"></div>
                        <div class="col-4"><input type="text" id="s_door" class="form-control" placeholder="Ajtó"></div>
                    </div>

                    <div class="form-check form-switch mt-3 p-3 bg-light rounded border">
                        <input class="form-check-input ms-0 me-2" type="checkbox" id="sameAsShip" checked onchange="toggleBillingSection()">
                        <label class="form-check-label fw-bold" for="sameAsShip">A számlázási cím megegyezik a szállítási címmel</label>
                    </div>

                    <div class="d-none mt-3" id="billingSection">
                        <h5 class="mb-3 text-secondary"><i class="bi bi-receipt me-2"></i>Számlázási cím</h5>
                        <div class="row g-2">
                            <div class="col-4"><input type="number" id="b_zipCode" class="form-control" placeholder="Irányítószám"></div>
                            <div class="col-8"><input type="text" id="b_city" class="form-control" placeholder="Város"></div>
                            <div class="col-12"><input type="text" id="b_street" class="form-control" placeholder="Utca neve"></div>
                            <div class="col-6"><input type="text" id="b_houseNumber" class="form-control" placeholder="Házszám"></div>
                            <div class="col-6"><input type="text" id="b_building" class="form-control" placeholder="Épület"></div>
                            <div class="col-4"><input type="text" id="b_apartment" class="form-control" placeholder="Lépcsőház"></div>
                            <div class="col-4"><input type="text" id="b_floor" class="form-control" placeholder="Emelet"></div>
                            <div class="col-4"><input type="text" id="b_door" class="form-control" placeholder="Ajtó"></div>
                        </div>
                    </div>

                    <button type="button" onclick="saveAddressAjax()" class="btn btn-primary btn-lg w-100 mt-4 fw-bold">
                        <span id="btnText"><i class="bi bi-floppy me-2"></i>Cím mentése / Módosítása</span>
                        <span id="btnLoader" class="spinner-border spinner-border-sm d-none"></span>
                    </button>

                    <div id="addressSuccess" class="alert alert-success mt-3 d-none">
                        <i class="bi bi-check-circle me-2"></i>Cím sikeresen mentve!
                    </div>
                    <div id="addressError" class="alert alert-danger mt-3 d-none"></div>
                </div>
            </div>


            <div class="card shadow-sm border-0 d-none" id="paymentCard">
                <div class="card-body p-4">
                    <h5 class="mb-3"><i class="bi bi-credit-card me-2 text-success"></i>Fizetési mód</h5>
                    <div class="d-flex gap-3 flex-wrap mb-4">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="COD" checked>
                            <label class="form-check-label" for="cod"><i class="bi bi-cash me-1"></i>Utánvét</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="transfer" value="TRANSFER">
                            <label class="form-check-label" for="transfer"><i class="bi bi-bank me-1"></i>Banki átutalás</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="card" value="CARD">
                            <label class="form-check-label" for="card"><i class="bi bi-credit-card me-1"></i>Bankkártya</label>
                        </div>
                    </div>

                    <button type="button" onclick="placeOrderAjax()" class="btn btn-success btn-lg w-100 fw-bold">
                        <i class="bi bi-bag-check me-2"></i>Rendelés leadása
                    </button>
                    <div id="orderError" class="alert alert-danger mt-3 d-none"></div>
                </div>
            </div>

            <c:if test="${not empty shippingAddresses}" >
                <script type="text/javascript">
                document.addEventListener('DOMContentLoaded', function() {
                    const firstShipping = {
                        id: ${shippingAddresses[0].id},
                        zipCode: '${shippingAddresses[0].zipCode != null ? shippingAddresses[0].zipCode : ""}',
                        city: '${shippingAddresses[0].city != null ? shippingAddresses[0].city : ""}',
                        street: '${shippingAddresses[0].street != null ? shippingAddresses[0].street : ""}',
                        houseNumber: '${shippingAddresses[0].houseNumber != null ? shippingAddresses[0].houseNumber : ""}',
                        building: '${shippingAddresses[0].building != null ? shippingAddresses[0].building : ""}',
                        apartment: '${shippingAddresses[0].apartment != null ? shippingAddresses[0].apartment : ""}',
                        floor: '${shippingAddresses[0].floor != null ? shippingAddresses[0].floor : ""}',
                        door: '${shippingAddresses[0].door != null ? shippingAddresses[0].door : ""}'
                    };

                    document.getElementById('s_zipCode').value = firstShipping.zipCode;
                    document.getElementById('s_city').value = firstShipping.city;
                    document.getElementById('s_street').value = firstShipping.street;
                    document.getElementById('s_houseNumber').value = firstShipping.houseNumber !== '-' ? firstShipping.houseNumber : '';
                    document.getElementById('s_building').value = firstShipping.building;
                    document.getElementById('s_apartment').value = firstShipping.apartment;
                    document.getElementById('s_floor').value = firstShipping.floor;
                    document.getElementById('s_door').value = firstShipping.door;

                    // Alapértelmezett mentett ID-k beállítása
                    savedShippingId = firstShipping.id;
                    
                    // Védelem: Ha van külön számlázási cím, azt használjuk, ha nincs, a szállításit
                    <c:choose>
                        <c:when test="${not empty billingAddresses}">
                            savedBillingId = ${billingAddresses[0].id};
                        </c:when>
                        <c:otherwise>
                            savedBillingId = firstShipping.id;
                        </c:otherwise>
                    </c:choose>

                    // Fizetési kártya azonnali megjelenítése
                    document.getElementById('paymentCard').classList.remove('d-none');
                    
                    // Zöld pipás visszajelzés
                    const successAlert = document.getElementById('addressSuccess');
                    successAlert.innerHTML = '<i class="bi bi-info-circle me-2"></i>Korábban mentett címeidet betöltöttük!';
                    successAlert.classList.remove('alert-success');
                    successAlert.classList.add('alert-info');
                    successAlert.classList.remove('d-none');
                });
                </script>
            </c:if>
            
        </div>

        <div class="col-lg-4 col-md-12">
            <div class="card shadow-sm sticky-top mt-4" style="top: 100px; border: none;">
                <div class="card-header bg-primary text-white fw-bold py-3">Rendelésed összegzése</div>
                <div class="card-body">
                    <c:forEach var="item" items="${cart}">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="small">${item.name} × ${item.quantity}</span>
                            <span class="small fw-bold">
                                <fmt:formatNumber value="${item.price * item.quantity}" type="number" /> Ft
                            </span>
                        </div>
                    </c:forEach>
                    <hr>
                    <div class="d-flex justify-content-between small text-muted mb-1">
                        <span>Szállítás:</span>
                        <span><fmt:formatNumber value="${shippingCost}" type="number" /> Ft</span>
                    </div>
                    <div class="d-flex justify-content-between h5 fw-bold text-primary mt-2">
                        <span>Fizetendő:</span>
                        <span><fmt:formatNumber value="${totalPrice}" type="number" /> Ft</span>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script>
// Az utoljára mentett cím ID-k
let savedShippingId = null;
let savedBillingId = null;

function toggleBillingSection() {
    const isSame = document.getElementById('sameAsShip').checked;
    document.getElementById('billingSection').classList.toggle('d-none', isSame);
}

function saveAddressAjax() {
    const s_zipCode = document.getElementById('s_zipCode').value.trim();
    const s_city = document.getElementById('s_city').value.trim();
    const s_street = document.getElementById('s_street').value.trim();
    const isSame = document.getElementById('sameAsShip').checked;

    if (!s_zipCode || !s_city || !s_street) {
        document.getElementById('addressError').classList.remove('d-none');
        document.getElementById('addressError').innerText = 'Kérjük töltsd ki a kötelező mezőket!';
        return;
    }

    const params = new URLSearchParams();
    
    params.append('s_zipCode', s_zipCode);
    params.append('s_city', s_city);
    params.append('s_street', s_street);
    params.append('s_houseNumber', document.getElementById('s_houseNumber').value.trim() || '-');
    params.append('s_building', document.getElementById('s_building').value.trim());
    params.append('s_apartment', document.getElementById('s_apartment').value.trim());
    params.append('s_floor', document.getElementById('s_floor').value.trim());
    params.append('s_door', document.getElementById('s_door').value.trim());
    params.append('sameAsShipping', isSame ? 'on' : 'off');

    if (!isSame) {
        params.append('b_zipCode', document.getElementById('b_zipCode').value.trim());
        params.append('b_city', document.getElementById('b_city').value.trim());
        params.append('b_street', document.getElementById('b_street').value.trim());
        params.append('b_houseNumber', document.getElementById('b_houseNumber').value.trim() || '-');
        params.append('b_building', document.getElementById('b_building').value.trim());
        params.append('b_apartment', document.getElementById('b_apartment').value.trim());
        params.append('b_floor', document.getElementById('b_floor').value.trim());
        params.append('b_door', document.getElementById('b_door').value.trim());
    }

    document.getElementById('btnText').innerHTML = 'Mentés...';
    document.getElementById('btnLoader').classList.remove('d-none');
    document.getElementById('addressError').classList.add('d-none');
    document.getElementById('addressSuccess').classList.add('d-none');

    fetch('<c:url value="/cart/api/save-address"/>', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params
    })
    .then(res => res.json())
    .then(data => {
        document.getElementById('btnText').innerHTML = '<i class="bi bi-floppy me-2"></i>Cím mentése / Módosítása';
        document.getElementById('btnLoader').classList.add('d-none');

        if (data.success) {
            // Elmentjük az ID-kat
            savedShippingId = data.shippingAddresses[0].id;
            savedBillingId = data.billingAddresses[0].id;

            const successAlert = document.getElementById('addressSuccess');
            successAlert.innerHTML = '<i class="bi bi-check-circle me-2"></i>Cím sikeresen mentve!';
            successAlert.classList.remove('alert-info');
            successAlert.classList.add('alert-success');
            successAlert.classList.remove('d-none');
            
            document.getElementById('paymentCard').classList.remove('d-none');
            

            document.getElementById('paymentCard').scrollIntoView({ behavior: 'smooth', block: 'start' });
        } else {
            document.getElementById('addressError').classList.remove('d-none');
            document.getElementById('addressError').innerText = data.message || 'Hiba történt!';
        }
    })
    .catch(() => {
        document.getElementById('btnText').innerHTML = '<i class="bi bi-floppy me-2"></i>Cím mentése / Módosítása';
        document.getElementById('btnLoader').classList.add('d-none');
        document.getElementById('addressError').classList.remove('d-none');
        document.getElementById('addressError').innerText = 'Hálózati hiba történt!';
    });
}

function placeOrderAjax() {
    if (!savedShippingId || !savedBillingId) {
        document.getElementById('orderError').classList.remove('d-none');
        document.getElementById('orderError').innerText = 'Kérjük előbb mentsd el a szállítási címet!';
        return;
    }

    const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;

    const params = new URLSearchParams();
    params.append('shippingAddressId', savedShippingId);
    params.append('billingAddressId', savedBillingId);
    params.append('paymentMethod', paymentMethod);

    fetch('<c:url value="/cart/checkout"/>', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params
    })
    .then(res => {
        if (res.redirected) {
            window.location.href = res.url;
        } else {
            throw new Error('Szerverhiba');
        }
    })
    .catch(() => {
        document.getElementById('orderError').classList.remove('d-none');
        document.getElementById('orderError').innerText = 'Hiba történt a rendelés leadásakor!';
    });
}
</script>

<%@ include file="../shared/footer.jsp" %>