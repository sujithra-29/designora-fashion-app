<%@ page import="java.sql.*" %>
<%@ include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String designerName = (String) session.getAttribute("user_name");
if (designerName == null || designerName.trim().equals("")) {
    designerName = "Designer";
}
String firstLetter = designerName.substring(0,1).toUpperCase();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Designer Orders - Designora</title>

<style>
/* ✅ SAME CSS (UNCHANGED) */
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:system-ui,-apple-system,sans-serif;background:#0f172a;color:#fff}
a{text-decoration:none}
.nav-menu{display:flex;gap:2rem}
.nav-menu a{color:#9ca3af;transition:.3s}
.nav-menu a:hover{color:#fbbf24}

.header{background:linear-gradient(90deg,#1e293b,#1e3a52,#1e293b);border-bottom:1px solid rgba(71,85,105,.5);padding:1rem 2rem}
.header-content{max-width:1400px;margin:0 auto;display:flex;justify-content:space-between;align-items:center}
.logo{font-size:1.5rem;font-weight:700;background:linear-gradient(90deg,#fbbf24,#fb7185);-webkit-background-clip:text;-webkit-text-fill-color:transparent}
.user-info{display:flex;align-items:center;gap:1rem}
.avatar{width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,#f59e0b,#fb7185);display:flex;align-items:center;justify-content:center}
.container{max-width:1400px;margin:0 auto;padding:2rem}
.order-card{background:rgba(30,41,59,.5);border:1px solid rgba(71,85,105,.5);border-radius:1rem;padding:1.5rem;margin-bottom:1rem}
.order-id{color:#fbbf24;font-weight:bold}
.badge{padding:.3rem .8rem;border-radius:1rem;font-size:.8rem}
.badge-pending{background:#fbbf2422;color:#fbbf24}
.badge-progress{background:#3b82f622;color:#3b82f6}
.badge-completed{background:#10b98122;color:#10b981}
.badge-cancelled{background:#ef444422;color:#ef4444}
.btn{padding:.5rem 1rem;border:none;border-radius:.5rem;cursor:pointer}
.btn-primary{background:#f59e0b;color:#fff}
.btn-secondary{background:#475569;color:#fff}
</style>
</head>

<body>

<div class="header">
    <div class="header-content">
        <div class="logo">✨ Designora</div>
        <div class="nav-menu">
            <a href="home.jsp">Home</a>
            <a href="add-design.jsp">Add Designs</a>
            <a href="designer-dashboard.jsp">Dashboard</a>
        </div>
        <div class="user-info">
            <div class="avatar"><%= firstLetter %></div>
            <span><%= designerName %></span>
        </div>
    </div>
</div>

<div class="container">

<h2>📦 Orders</h2>

<div class="orders-list">

<%
try {

PreparedStatement ps = conn.prepareStatement(
    "SELECT o.*, d.name, u.full_name AS customer_name " +
    "FROM orders o " +
    "JOIN designs d ON o.design_id = d.design_id " +
    "JOIN users u ON o.user_id = u.user_id " +
    "WHERE d.designer_name = ? " +
    "ORDER BY o.order_date DESC"
);

ps.setString(1, designerName);

ResultSet rs = ps.executeQuery();

while(rs.next()){

String status = rs.getString("status");
if(status == null) status = "pending";

String badgeClass = "badge-pending";
if(status.equals("progress")) badgeClass="badge-progress";
if(status.equals("completed")) badgeClass="badge-completed";
if(status.equals("cancelled")) badgeClass="badge-cancelled";
%>

<div class="order-card">

    <div class="order-id">
        Order #<%= rs.getInt("order_id") %>
    </div>

    <p>Design: <%= rs.getString("name") %></p>
    <p>Customer: <%= rs.getString("customer_name") %></p>
    <p>Quantity: <%= rs.getInt("quantity") %></p>
    <p>Total: ₹<%= rs.getDouble("price") %></p>
    <p>Date: <%= rs.getTimestamp("order_date") %></p>

    <p>Status:
        <span class="badge <%= badgeClass %>">
            <%= status %>
        </span>
    </p>

    <br>

    <a href="update-order-status.jsp?id=<%= rs.getInt("order_id") %>&status=progress" class="btn btn-primary">Start</a>

    <a href="update-order-status.jsp?id=<%= rs.getInt("order_id") %>&status=completed" class="btn btn-secondary">Complete</a>

</div>

<%
}
} catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>

</div>

</div>

</body>
</html>