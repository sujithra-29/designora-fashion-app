<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="config.jsp" %>

<%
String userName = (String) session.getAttribute("user_name");
Integer userId = (Integer) session.getAttribute("user_id");

if(userName == null || userId == null){
    response.sendRedirect("login.jsp");
    return;
}

String firstName = userName.contains(" ") ? userName.substring(0,userName.indexOf(" ")) : userName;

// Stats calculation
int total=0, completed=0, pending=0;
PreparedStatement psStats = conn.prepareStatement(
    "SELECT status, COUNT(*) AS count FROM orders WHERE user_id=? GROUP BY status"
);
psStats.setInt(1, userId);
ResultSet rsStats = psStats.executeQuery();

while(rsStats.next()){
    String status = rsStats.getString("status");
    int count = rsStats.getInt("count");
    total += count;
    if("completed".equalsIgnoreCase(status)) completed = count;
    else if("pending".equalsIgnoreCase(status)) pending = count;
}
rsStats.close();
psStats.close();

// Fetch orders for table
PreparedStatement psOrders = conn.prepareStatement(
    "SELECT o.order_id, d.name, o.status, o.price " +
    "FROM orders o JOIN designs d ON o.design_id=d.design_id " +
    "WHERE o.user_id=? ORDER BY o.order_id DESC"
);
psOrders.setInt(1, userId);
ResultSet rs = psOrders.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard - Designora</title>

<style>
body{
    font-family: system-ui, sans-serif;
    background:#0f172a;
    color:#fff;
    margin:0;
}
.header{
    padding:1rem 2rem;
    background:#1e293b;
    display:flex;
    justify-content:space-between;
    align-items:center;
}
.logo{
    font-size:1.5rem;
    color:#fbbf24;
}
.profile{
    display:flex;
    align-items:center;
    gap:0.5rem;
}
.profile img{
    width:40px;
    height:40px;
    border-radius:50%;
    object-fit:cover;
    border:2px solid #fbbf24;
}
.main{
    display:flex;
}
.sidebar{
    width:220px;
    background:#1e293b;
    padding:1rem;
    display:flex;
    flex-direction:column;
    gap:0.75rem;
}
.sidebar a{
    display:block;
    color:#9ca3af;
    text-decoration:none;
    padding:0.5rem 0.75rem;
    border-radius:0.5rem;
}
.sidebar a:hover{
    color:#fbbf24;
    background:rgba(251,191,36,0.1);
}
.content{
    flex:1;
    padding:2rem;
}
.stats{
    display:flex;
    gap:20px;
    margin-bottom:30px;
}
.stat{
    flex:1;
    background:rgba(30,41,59,0.9);
    padding:20px;
    border-radius:10px;
    text-align:center;
}
.stat h2{
    margin-top:10px;
    font-size:2rem;
    color:#fbbf24;
}
.table{
    width:100%;
    border-collapse:collapse;
    margin-top:20px;
}
.table th, .table td{
    padding:12px;
    border-bottom:1px solid #333;
    text-align:center;
}
.badge{
    padding:5px 10px;
    border-radius:10px;
    color:#fff;
    font-weight:600;
    text-transform:capitalize;
}
.completed{
    background:green;
}
.pending{
    background:orange;
}
.profile-circle{
    width:40px;
    height:40px;
    border-radius:50%;
    background: linear-gradient(135deg, #fbbf24, #f97316); /* attractive gradient */
    display:flex;
    align-items:center;
    justify-content:center;
    font-weight:bold;
    color:#fff;
    font-size:1.2rem;
    border:2px solid #fff;
}
</style>
</head>

<body>

<div class="header">
    <div class="logo">✨ Designora</div>
    <div class="profile">
    <div class="profile-circle">
        <%= firstName.substring(0,1).toUpperCase() %>
    </div>
    <span><%= firstName %></span>
</div>
</div>

<div class="main">

    <div class="sidebar">
        <a href="user-dashboard.jsp">Dashboard</a>
        <a href="view-designs.jsp">Browse Designs</a>
        <a href="view-cart.jsp">🛒 My Cart</a>
        <a href="logout.jsp">Logout</a>
    </div>

    <div class="content">

        <h2>Welcome, <span style="color:#fbbf24;"><%= firstName %></span> 👋</h2>

        <div class="stats">
            <div class="stat">Total<br><h2><%= total %></h2></div>
            <div class="stat">Completed<br><h2><%= completed %></h2></div>
            <div class="stat">Pending<br><h2><%= pending %></h2></div>
        </div>

        <table class="table">
            <tr>
                <th>ID</th>
                <th>Design</th>
                <th>Status</th>
                <th>Amount</th>
            </tr>
            <%
            while(rs.next()){
            %>
            <tr>
                <td><%= rs.getInt("order_id") %></td>
                <td><%= rs.getString("name") %></td>
                <td>
                    <span class="badge <%= rs.getString("status").equalsIgnoreCase("completed")?"completed":"pending" %>">
                        <%= rs.getString("status") %>
                    </span>
                </td>
                <td>₹<%= rs.getDouble("price") %></td>
            </tr>
            <% } 
            rs.close();
            psOrders.close();
            %>
        </table>

    </div>
</div>

</body>
</html>