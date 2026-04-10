<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
        
        </main> <%-- A fejlécben megnyitott <main> bezárása --%>
    </div> <%-- A fejlécben megnyitott <div class="container-fluid"> bezárása --%>

    <footer class="footer mt-auto py-4 bg-white border-top shadow-sm">
        <div class="container-fluid px-4">
            <div class="row align-items-center">
                <div class="col-md-6 text-center text-md-start">
                    <span class="text-muted small">
                        &copy; 2024 <span class="fw-bold text-primary">Webshop Admin</span>. 
                        Minden jog fenntartva.
                    </span>
                </div>
                <div class="col-md-6 text-center text-md-end mt-2 mt-md-0">
                    <span class="badge rounded-pill bg-light text-dark border px-3 py-2">
                        <i class="bi bi-cpu me-1 text-danger"></i> Rendszerverzió: v1.0.4
                    </span>
                    <span class="ms-2 text-muted small">
                        Kapcsolat: <a href="mailto:admin@webshop.hu" class="text-decoration-none text-secondary">Support</a>
                    </span>
                </div>
            </div>
        </div>
    </footer>

    <%-- Bootstrap Bundle JS (tartalmazza a Poppert a dropdown menükhöz) --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <%-- Saját admin szkriptek (opcionális) --%>
    <script src="<c:url value='/js/admin-main.js'/>"></script>

    <style>
        html, body {
            height: 100%;
        }
        body {
            display: flex;
            flex-direction: column;
        }
        main {
            flex: 1 0 auto;
        }
    </style>
</body>
</html>