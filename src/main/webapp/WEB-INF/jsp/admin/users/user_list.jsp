<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>


<%@ include file="../shared/admin-header.jsp" %>

<div class="container-fluid p-0">
    <div class="row g-0">
        

        <div class="col-md-3 col-lg-2">
            <%@ include file="../shared/sidebar.jsp" %>
        </div>

    
        <main class="col-md-9 col-lg-10 px-md-4 py-4 bg-light min-vh-100">
            

            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h4 class="fw-bold text-dark mb-1">Felhasználók kezelése</h4>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb small">
                            <li class="breadcrumb-item"><a href="<c:url value='/admin/dashboard'/>" class="text-decoration-none">Vezérlőpult</a></li>
                            <li class="breadcrumb-item active">Felhasználók</li>
                        </ol>
                    </nav>
                </div>
            </div>


            <c:if test="${param.success != null}">
                <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm rounded-3 mb-4" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    <c:choose>
                        <c:when test="${param.success == 'roleUpdated'}">Jogosultság sikeresen frissítve.</c:when>
                        <c:when test="${param.success == 'userDeleted'}">Felhasználó sikeresen eltávolítva.</c:when>
                    </c:choose>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>


            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-white text-muted small uppercase">
                                <tr>
                                    <th class="px-4 py-3">ID</th>
                                    <th class="py-3">Felhasználó</th>
                                    <th class="py-3">Email</th>
                                    <th class="py-3">Szerepkör</th>
                                    <th class="px-4 py-3 text-end">Műveletek</th>
                                </tr>
                            </thead>
                            <tbody class="border-top-0">
                                <c:forEach var="user" items="${users}">
                                    <tr>
                                        <td class="px-4 text-muted">#${user.id}</td>
                                        <td class="fw-bold text-dark">${user.username}</td>
                                        <td>${user.email}</td>
                                        <td>
										    <c:choose>
										        <c:when test="${user.role == 'ADMIN'}">
										            <span class="badge bg-dark rounded-pill px-3 py-2">
										                <i class="bi bi-shield-lock me-1"></i> Adminisztrátor
										            </span>
										        </c:when>
										        
										        <c:otherwise>
										            <form action="<c:url value='/admin/users/updateRole'/>" method="post" class="d-inline-flex">
										                <input type="hidden" name="userId" value="${user.id}">
										                <select name="newRole" class="form-select form-select-sm border-0 bg-light" onchange="this.form.submit()" style="width: auto;">
										                    <option value="ROLE_USER" ${user.role == 'USER' ? 'selected' : ''}>Felhasználó</option>
										                    <option value="ROLE_ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Adminisztrátor</option>
										                </select>
										            </form>
										        </c:otherwise>
										    </c:choose>
										</td>
                                        <td class="px-4 text-end">

                                            <c:choose>
                                                <c:when test="${pageContext.request.userPrincipal.name == user.email}">
                                                    <span class="badge bg-light text-muted rounded-pill px-3 py-2">Önmagát nem törölheti</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <form action="<c:url value='/admin/users/delete'/>" method="post" class="d-inline" onsubmit="return confirm('Biztosan törölni szeretné ezt a felhasználót?')">
                                                        <input type="hidden" name="userId" value="${user.id}">
                                                        <button type="submit" class="btn btn-link text-danger p-0" title="Törlés">
                                                            <i class="bi bi-trash3 fs-5"></i>
                                                        </button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </main>
    </div>
</div>


<%@ include file="../shared/admin-footer.jsp" %>