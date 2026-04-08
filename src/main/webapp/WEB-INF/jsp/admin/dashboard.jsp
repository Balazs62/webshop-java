<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="shared/admin-header.jsp" %> <div class="container-fluid p-0">
    <div class="row g-0">
        <div class="col-md-3 col-lg-2">
            <%@ include file="shared/sidebar.jsp" %>
        </div>

        <main class="col-md-9 col-lg-10 p-4">
            <h1 class="h2 border-bottom pb-2">Üdvözlünk az Admin felületen!</h1>
            
            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="card border-primary mb-3">
                        <div class="card-body text-center">
                            <h5 class="card-title text-muted">Összes rendelés</h5>
                            <p class="card-text h2 fw-bold text-primary">${totalOrders}</p>
                        </div>
                    </div>
                </div>
                </div>
        </main>
    </div>
</div>

<%@ include file="shared/admin-footer.jsp" %>