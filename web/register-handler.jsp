<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>

<%
PreparedStatement check = null;
PreparedStatement insertUser = null;
ResultSet rs = null;

try {
    String full_name = request.getParameter("full_name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String password = request.getParameter("password");
    String confirm_password = request.getParameter("confirm_password");
    String role = request.getParameter("role");

    // Clean input
    full_name = (full_name != null) ? full_name.trim() : "";
    email = (email != null) ? email.trim().toLowerCase() : "";
    phone = (phone != null) ? phone.trim() : "";
    password = (password != null) ? password.trim() : "";
    confirm_password = (confirm_password != null) ? confirm_password.trim() : "";
    role = (role != null && !role.trim().isEmpty()) ? role.trim().toLowerCase() : "user";

    // Validation
    if (full_name.isEmpty() || email.isEmpty() || phone.isEmpty() || password.isEmpty() || confirm_password.isEmpty()) {
        session.setAttribute("error", "All fields are required");
        response.sendRedirect("register.jsp");
        return;
    }

    if (!password.equals(confirm_password)) {
        session.setAttribute("error", "Passwords do not match");
        response.sendRedirect("register.jsp");
        return;
    }

    if (conn == null) {
        session.setAttribute("error", "Database connection error");
        response.sendRedirect("register.jsp");
        return;
    }

    // Check existing email
    check = conn.prepareStatement("SELECT email FROM users WHERE email = ?");
    check.setString(1, email);
    rs = check.executeQuery();

    if (rs.next()) {
        session.setAttribute("error", "Email already registered");
        response.sendRedirect("register.jsp");
        return;
    }

    // Insert user
    insertUser = conn.prepareStatement(
        "INSERT INTO users (full_name, email, phone, password, role, is_active) VALUES (?, ?, ?, ?, ?, ?)"
    );

    insertUser.setString(1, full_name);
    insertUser.setString(2, email);
    insertUser.setString(3, phone);
    insertUser.setString(4, password);
    insertUser.setString(5, role);
    insertUser.setInt(6, 1);

    int result = insertUser.executeUpdate();

    if (result > 0) {
        session.setAttribute("success", "Registration successful! Please login.");
        response.sendRedirect("login.jsp");
    } else {
        session.setAttribute("error", "Registration failed");
        response.sendRedirect("register.jsp");
    }

} catch (Exception e) {
    session.setAttribute("error", "Error: " + e.getMessage());
    response.sendRedirect("register.jsp");
} finally {
    if (rs != null) try { rs.close(); } catch(Exception e) {}
    if (check != null) try { check.close(); } catch(Exception e) {}
    if (insertUser != null) try { insertUser.close(); } catch(Exception e) {}
}
%>