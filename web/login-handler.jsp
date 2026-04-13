<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
String DB_URL = "jdbc:derby://localhost:1527/designora";
String DB_USER = "app";
String DB_PASS = "app";

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

// Allow only POST
if (!"POST".equalsIgnoreCase(request.getMethod())) {
    response.sendRedirect("login.jsp");
    return;
}

String email = request.getParameter("email");
String password = request.getParameter("password");
String role = request.getParameter("role");

// Default role
if (role == null || role.trim().isEmpty()) {
    role = "user";
}

// Validation
if (email == null || email.trim().isEmpty() ||
    password == null || password.trim().isEmpty()) {

    session.setAttribute("error", "Please fill in all fields");
    response.sendRedirect("login.jsp");
    return;
}

try {
    // Connect DB
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

    // Check user
    ps = conn.prepareStatement(
        "SELECT user_id, full_name, email, password, role, is_active FROM users WHERE email=? AND role=?"
    );

    ps.setString(1, email.trim());
    ps.setString(2, role.trim());

    rs = ps.executeQuery();

    if (rs.next()) {

        int isActive = rs.getInt("is_active");
        String dbPassword = rs.getString("password");

        if (isActive != 1) {
            session.setAttribute("error", "Account is inactive");
            response.sendRedirect("login.jsp");
            return;
        }

        if (!password.equals(dbPassword)) {
            session.setAttribute("error", "Invalid email or password");
            response.sendRedirect("login.jsp");
            return;
        }

        // ✅ SESSION SETUP
        session.setAttribute("user_id", rs.getInt("user_id"));
        session.setAttribute("user_name", rs.getString("full_name"));
        session.setAttribute("user_email", rs.getString("email"));
        session.setAttribute("user_role", rs.getString("role"));

        // ✅ ROLE-BASED REDIRECT
        String userRole = rs.getString("role");

        if ("admin".equalsIgnoreCase(userRole)) {
            response.sendRedirect("admin-dashboard.jsp");
        } 
        else if ("designer".equalsIgnoreCase(userRole)) {
            response.sendRedirect("designer-dashboard.jsp");
        } 
        else {
            response.sendRedirect("user-dashboard.jsp");
        }

    } else {
        session.setAttribute("error", "Invalid email or password");
        response.sendRedirect("login.jsp");
    }

} catch (Exception e) {
    session.setAttribute("error", "Login failed: " + e.getMessage());
    response.sendRedirect("login.jsp");
} finally {
    if (rs != null) try { rs.close(); } catch(Exception e) {}
    if (ps != null) try { ps.close(); } catch(Exception e) {}
    if (conn != null) try { conn.close(); } catch(Exception e) {}
}
%>