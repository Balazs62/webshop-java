<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="../shared/header.jsp" %>


<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="card shadow">
                <div class="card-body">
                    <h3 class="text-center mb-4">Bejelentkezés</h3>
                    
					<%-- Ellenőrzi a Model-ből érkező hibát (AuthController-ből) --%>
					<c:if test="${not empty loginError}">
					    <div class="alert alert-danger">${loginError}</div>
					</c:if>
					
					<%-- Ellenőrzi az URL paramétert (ha Spring Security-t használnál később) --%>
					<c:if test="${param.error != null}">
					    <div class="alert alert-danger">Sikertelen bejelentkezés!</div>
					</c:if>

                    <form action="<c:url value='/login'/>" method="post">
                        <div class="mb-3">
                            <label>Email</label>
                            <input type="email" name="email" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label>Jelszó</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Belépés</button>
                    </form>
                    <script src="https://www.google.com/recaptcha/api.js?render=6LebRposAAAAAE8nuDJ1rknYH0msDiSJmFoITJDm"></script>

					<script>
					    grecaptcha.ready(function() {
					        grecaptcha.execute('6LebRposAAAAAE8nuDJ1rknYH0msDiSJmFoITJDm', {action: 'login'})
					        .then(function(token) {
					            console.log("Login captcha betöltve.");
					        });
					    });
					</script>
                </div>
            </div>
        </div>
    </div>
</div>