<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%@ include file="../shared/header.jsp" %>

<div class="container mt-4 mb-5">
    <div class="row align-items-start">
        
        <div class="col-lg-4 col-md-12 mb-5">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0">Cím módosítása / hozzáadása</h5>
                </div>
                <div class="card-body">
                    <div class="alert alert-info py-2 small">
                        <i class="bi bi-info-circle me-1"></i> Új cím mentése felülírja a korábbit.
                    </div>

                    <form action="<c:url value='/add-address'/>" method="post" class="needs-validation">
                        
                        <div class="form-check mb-4 p-3 border rounded bg-light shadow-sm transition-all">
                            <input class="form-check-input ms-1" type="checkbox" name="sameAsShipping" id="sameAsShipping">
                            <label class="form-check-label small fw-bold ms-2" for="sameAsShipping">
                                🏠 A számlázási cím megegyezik a szállításival
                            </label>
                        </div>
                    
                        <div id="categoryContainer" class="mb-3">
                            <label class="form-label small fw-bold text-muted text-uppercase" style="font-size: 0.75rem;">Melyik címet módosítod?</label>
                            <select id="addressCategory" name="addressCategory" class="form-select shadow-sm border-primary-subtle">
                                <option value="SHIPPING">🚚 Szállítási cím</option>
                                <option value="BILLING">💳 Számlázási cím</option>
                            </select>
                        </div>
                    
                        <div class="row g-2 mb-3">
                            <div class="col-4">
                                <label class="form-label small fw-bold">Irsz.</label>
                                <input type="text" id="zipCode" name="zipCode" class="form-control shadow-sm" list="zipOptions" placeholder="1234" 
                                 pattern="^[0-9]{4}$" title="Az irányítószám pontosan 4 számjegy lehet" maxlength="4" required>
                                <datalist id="zipOptions"></datalist>
                            </div>
                            <div class="col-8">
                                <label class="form-label small fw-bold">Város</label>
                                <input type="text" id="city" name="city" class="form-control shadow-sm" 
                                       placeholder="Város neve" 
                                       pattern="^[a-zA-ZáéíóöőúüűÁÉÍÓÖŐÚÜŰ\s\-\.]+$"
                                       title="Csak betűket, szóközt, pontot és kötőjelet használhat!" 
                                       required>
                            </div>
                        </div>
                    
                        <div class="mb-3">
                            <label class="form-label small fw-bold">Utca / Közterület</label>
                            <input type="text" name="street" class="form-control shadow-sm" placeholder="Fő utca" required>
                        </div>
                    
                        <div class="row g-2 mb-3">
                            <div class="col-6">
                                <label class="form-label small fw-bold">Házszám</label>
                                <input type="text" name="houseNumber" class="form-control shadow-sm" placeholder="12/A" required>
                            </div>
                            <div class="col-4">
                                <label class="form-label small fw-bold">Épület</label>
                                <input type="text" name="building" class="form-control shadow-sm" placeholder="A ép.">
                            </div>
                            <div class="col-4">
                                <label class="form-label small fw-bold">Lépcsőház</label>
                                <input type="text" name="apartment" class="form-control shadow-sm" placeholder="2. lh.">
                            </div>
                            <div class="col-6">
                                <label class="form-label small fw-bold">Emelet</label>
                                <input type="text" name="floor" class="form-control shadow-sm" placeholder="3.">
                            </div>
                        </div>                        
                        
                        <div class="row g-2 mb-4">
                            <div class="col-4">
                                <label class="form-label small fw-bold">Ajtó</label>
                                <input type="text" name="door" class="form-control shadow-sm" placeholder="13">
                            </div>
                        </div> <button type="submit" class="btn btn-primary w-100 py-2 shadow-sm fw-bold text-uppercase" style="letter-spacing: 1px;">
                            <i class="bi bi-check-circle me-2"></i> Cím mentése
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-8 col-md-12">
            <h3 class="mb-4">Mentett címeim</h3>
            
            <c:if test="${empty shippingAddresses && empty billingAddresses}">
                <div class="alert alert-light border text-center py-5 shadow-sm">
                    <p class="text-muted mb-0">Még nincs mentett címed. Adj meg egyet a bal oldali űrlapon!</p>
                </div>
            </c:if>

            <div class="row">
                <div class="col-md-6 border-end">
                    <h5 class="text-primary mb-3"><i class="bi bi-truck"></i> Szállítási cím</h5>
                    <c:forEach var="addr" items="${shippingAddresses}">
                        <div class="card mb-3 shadow-sm border-0 position-relative">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start">
                                    <h6 class="card-title mb-1">
                                        <c:out value="${addr.zipCode}"/> <c:out value="${addr.city}" />
                                    </h6>
                                    <c:if test="${addr.billing && addr.shipping}">
                                        <span class="badge rounded-pill bg-light text-primary border border-primary-subtle" 
                                              title="Ez a cím szállítási és számlázási is" style="font-size: 0.6rem;">
                                            <i class="bi bi-shield-check"></i> Kombinált
                                        </span>
                                    </c:if>
                                </div>
                                <p class="card-text text-muted small mb-2">
                                    <c:out value="${addr.street}"/> <c:out value="${addr.houseNumber}."/>
                                    <c:if test="${not empty addr.building}"> <br>Ép: ${addr.building}</c:if>
                                    <c:if test="${not empty addr.apartment}"> Lh: ${addr.apartment}</c:if>
                                    <c:if test="${not empty addr.floor}"> Em: ${addr.floor}</c:if>
                                    <c:if test="${not empty addr.door}"> Ajtó: ${addr.door}</c:if>
                                </p>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="col-md-6 ps-md-4">
                    <h5 class="text-success mb-3"><i class="bi bi-receipt"></i> Számlázási cím</h5>
                    <c:forEach var="addr" items="${billingAddresses}">
				    <div class="card mb-3 shadow-sm border-0 position-relative">
				        <div class="card-body">
				            <div class="d-flex justify-content-between align-items-start">
				                <h6 class="card-title mb-1">
				                    <c:out value="${addr.zipCode}"/> <c:out value="${addr.city}"/>
				                </h6>
				                <c:if test="${addr.billing && addr.shipping}">
				                    <span class="badge rounded-pill bg-light text-primary border border-primary-subtle" 
				                          title="Ez a cím szállítási és számlázási is" style="font-size: 0.6rem;">
				                        <i class="bi bi-shield-check"></i> Kombinált
				                    </span>
				                </c:if>
				            </div>
				            <p class="card-text text-muted small mb-2">
				                <c:out value="${addr.street}"/> <c:out value="${addr.houseNumber}."/>
				                <c:if test="${not empty addr.building}"> <br>Ép: ${addr.building}</c:if>
                                <c:if test="${not empty addr.apartment}"> Lh: ${addr.apartment}</c:if>
				                <c:if test="${not empty addr.floor}"> Em: ${addr.floor}</c:if>
				                <c:if test="${not empty addr.door}"> Ajtó: ${addr.door}</c:if>
				            </p>
				            <form action="<c:url value='/delete-address'/>" method="post" 
				                  onsubmit="return confirm('Biztosan törlöd ezt a címet?');">
				                <input type="hidden" name="addressId" value="${addr.id}">
				                <button type="submit" class="btn btn-link text-danger p-0 small">
				                    <i class="bi bi-trash3 me-1"></i>Törlés
				                </button>
				            </form>
				        </div>
				    </div>
				</c:forEach>
                </div>
            </div> 
		</div>	
	</div> 
</div> 

<script>
// A JS kódod érintetlenül maradhat...
const zipInput = document.getElementById('zipCode');
const cityInput = document.getElementById('city');
const zipOptions = document.getElementById('zipOptions');

const sameAsCheck = document.getElementById('sameAsShipping');
const categoryContainer = document.getElementById('categoryContainer');
const categorySelect = document.querySelector('select[name="addressCategory"]');

zipInput.addEventListener('input', function(e) {
    let zip = e.target.value;
    if (zip.length === 4) {
        fetch('https://api.zippopotam.us/hu/' + zip)
            .then(response => response.json())
            .then(data => {
                if (data.places && data.places.length > 0) {
                    cityInput.value = data.places[0]['place name'];
                }
            }).catch(err => console.log("Hiba az irányítószám lekérésekor"));
    }
});

cityInput.addEventListener('blur', function(e) {
    let city = e.target.value.trim();
    if (city.length > 2) {
        fetch('https://api.zippopotam.us/hu/bw/' + city)
            .then(response => response.json())
            .then(data => {
                zipOptions.innerHTML = "";
                if (data.places && data.places.length > 0) {
                    if (data.places.length === 1) {
                        zipInput.value = data.places[0]['post code'];
                    } else {
                        data.places.forEach(place => {
                            let option = document.createElement('option');
                            option.value = place['post code'];
                            option.textContent = place['place name'];
                            zipOptions.appendChild(option);
                        });
                        console.log("Több irányítószám elérhető.");
                    }
                }
            }).catch(err => console.log("Város alapú keresés hiba"));
    }
});

if (sameAsCheck) {
    sameAsCheck.addEventListener('change', function() {
        if (this.checked) {
            categoryContainer.style.opacity = '0.4';
            categoryContainer.style.pointerEvents = 'none'; 
            categorySelect.tabIndex = -1;
        } else {
            categoryContainer.style.opacity = '1';
            categoryContainer.style.pointerEvents = 'auto';
            categorySelect.tabIndex = 0;
        }
    });
}
</script>

<%@ include file="../shared/footer.jsp" %>