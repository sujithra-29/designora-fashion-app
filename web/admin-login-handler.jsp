<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    String adminEmail = "admin@designora.com";
    String adminPassword = "Admin@123";

    if(adminEmail.equals(email) && adminPassword.equals(password)){
        session.setAttribute("admin_name", "Administrator");
        session.setAttribute("admin_email", adminEmail);
        session.setAttribute("admin_logged_in", "true");
        response.sendRedirect("admin-dashboard.jsp");
    } else {
        session.setAttribute("error", "Invalid admin credentials");
        response.sendRedirect("admin-login.jsp");
    }
%>