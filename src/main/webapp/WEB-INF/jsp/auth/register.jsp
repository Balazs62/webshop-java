<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../shared/header.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow">
                <div class="card-body">
                    <h3 class="card-title text-center mb-4">Fiók létrehozása</h3>
				                   <form id="registerForm" action="<c:url value='/register'/>" method="post">
					<div class="mb-3">
					    <label class="form-label">Felhasználónév</label>
					    <input type="text" name="username" class="form-control" value="${user.username}" required>
					    
					    <%-- Hibák a Hibernate Validator-tól (@Size stb.) --%>
					    <form:errors path="user.username" cssClass="text-danger small" />
					    
					    <%-- Manuális hibaüzenet a foglalt névre --%>
					    <c:if test="${not empty usernameError}">
					        <small class="text-danger">${usernameError}</small>
					    </c:if>
					</div>
				    
				    <div class="mb-3">
				        <label class="form-label">Email cím</label>
				        <input type="email" name="email" class="form-control" value="${user.email}" required>
				        <form:errors path="user.email" cssClass="text-danger small" />
				        <%-- Itt jelenik meg a manuális "már létezik" hiba --%>
				        <c:if test="${not empty emailError}">
				            <small class="text-danger">${emailError}</small>
				        </c:if>
				    </div>
				    
				    <div class="mb-3">
				        <label class="form-label">Jelszó</label>
				        <input type="password" name="password" class="form-control" required>
				        <form:errors path="user.password" cssClass="text-danger small" />
				    </div>
				
				    <div class="mb-3">
				        <label class="form-label">Jelszó újra</label>
				        <input type="password" name="confirmPassword" class="form-control" required>
				        <c:if test="${not empty passwordError}">
				            <small class="text-danger">${passwordError}</small>
				        </c:if>
				    </div>
				
				    <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response">
				    <c:if test="${not empty captchaError}">
				        <div class="alert alert-danger mt-2">${captchaError}</div>
				    </c:if>
				
				    <button type="submit" class="btn btn-primary w-100 ">Regisztráció</button>
				</form>
				
				<script src="https://www.google.com/recaptcha/api.js?render=6LebRposAAAAAE8nuDJ1rknYH0msDiSJmFoITJDm"></script>

				<script>
				    function loadCaptcha() {
				        grecaptcha.ready(function() {
				            grecaptcha.execute('6LebRposAAAAAE8nuDJ1rknYH0msDiSJmFoITJDm', {action: 'render'})
				            .then(function(token) {
				                console.log("Captcha betöltve, token kész.");
				            });
				        });
				    }
				    loadCaptcha();
				</script>
                    
                    <div class="text-center mt-3">
                        <span>Már van fiókod? </span>
                        <a href="<c:url value='/login'/>">Jelentkezz be!</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../shared/footer.jsp" %>