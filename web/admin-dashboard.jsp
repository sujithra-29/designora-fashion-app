<%@ page import="java.sql.*" %>
<%@ include file="config.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String adminLoggedIn = (String) session.getAttribute("admin_logged_in");
if(adminLoggedIn == null || !adminLoggedIn.equals("true")){
    response.sendRedirect("admin-login.jsp");
    return;
}

/* ================= ACTION HANDLER ================= */
String action = request.getParameter("action");

if(action != null){
    try{
        if(action.equals("deleteUser")){
            int uid = Integer.parseInt(request.getParameter("id"));
            PreparedStatement ps = conn.prepareStatement(
                "DELETE FROM users WHERE user_id=? AND role!='admin'"
            );
            ps.setInt(1, uid);
            ps.executeUpdate();
        }

        if(action.equals("deleteOrder")){
            int oid = Integer.parseInt(request.getParameter("id"));
            PreparedStatement ps = conn.prepareStatement(
                "DELETE FROM orders WHERE order_id=?"
            );
            ps.setInt(1, oid);
            ps.executeUpdate();
        }

        if(action.equals("updateOrder")){
            int oid = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");

            PreparedStatement ps = conn.prepareStatement(
                "UPDATE orders SET status=? WHERE order_id=?"
            );
            ps.setString(1, status);
            ps.setInt(2, oid);
            ps.executeUpdate();
        }
    } catch(Exception e){
        out.println("Error: "+e.getMessage());
    }
}

/* ================= STATS ================= */
int totalUsers=0,totalDesigners=0,totalOrders=0;
double totalEarnings=0;
int pending=0,progress=0,completed=0,cancelled=0;

try {
Statement st = conn.createStatement();

ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM users WHERE role='user'");
if(rs1.next()) totalUsers = rs1.getInt(1);

ResultSet rs2 = st.executeQuery("SELECT COUNT(*) FROM users WHERE role='designer'");
if(rs2.next()) totalDesigners = rs2.getInt(1);

ResultSet rs3 = st.executeQuery("SELECT COUNT(*) FROM orders");
if(rs3.next()) totalOrders = rs3.getInt(1);

ResultSet rs4 = st.executeQuery("SELECT COALESCE(SUM(price),0) FROM orders WHERE status='completed'");
if(rs4.next()) totalEarnings = rs4.getDouble(1);

ResultSet rs5 = st.executeQuery("SELECT status, COUNT(*) FROM orders GROUP BY status");
while(rs5.next()){
String s = rs5.getString(1);
int c = rs5.getInt(2);

if("pending".equals(s)) pending=c;
if("progress".equals(s)) progress=c;
if("completed".equals(s)) completed=c;
if("cancelled".equals(s)) cancelled=c;
}

} catch(Exception e){
out.println("Error: "+e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
*{margin:0;padding:0;box-sizing:border-box}
body{
font-family:system-ui;
background:#0f172a;
color:#fff;
}

a{text-decoration:none;color:#fbbf24}

/* HEADER */
.header{
background:linear-gradient(90deg,#1e293b,#1e3a52,#1e293b);
padding:1rem 2rem;
display:flex;
justify-content:space-between;
align-items:center;
}

/* LAYOUT */
.main{display:flex;max-width:1400px;margin:auto}

/* SIDEBAR */
.sidebar{
width:250px;
background:#111827;
min-height:100vh;
padding-top:2rem;
}

.sidebar a{
display:block;
padding:1rem 2rem;
color:#9ca3af;
transition:.3s;
}

.sidebar a:hover{
color:#fbbf24;
background:rgba(251,191,36,.1);
}

/* CONTENT */
.content{flex:1;padding:2rem}

.stats{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
gap:1.5rem;
margin-bottom:2rem;
}

.card{
padding:1.5rem;
border-radius:15px;
color:#fff;
text-align:center;
box-shadow:0 10px 25px rgba(0,0,0,0.3);
transition:0.3s;
}

.card:hover{
transform:translateY(-5px);
}

/* Individual Colors */
.card-users{
background:linear-gradient(135deg,#3b82f6,#06b6d4);
}

.card-designers{
background:linear-gradient(135deg,#8b5cf6,#ec4899);
}

.card-orders{
background:linear-gradient(135deg,#f59e0b,#ef4444);
}

.card-earnings{
background:linear-gradient(135deg,#10b981,#22c55e);
}

.card h4{
margin-bottom:10px;
font-size:1rem;
opacity:0.9;
}

.card p{
font-size:2rem;
font-weight:bold;
}

/* SECTION */
.section{
background:#1e293b;
padding:1.5rem;
border-radius:10px;
margin-bottom:2rem;
}

/* TABLE */
table{
width:100%;
border-collapse:collapse;
margin-top:1rem;
}

th,td{
padding:10px;
text-align:center;
border-bottom:1px solid #374151;
}

/* BUTTON */
button{
padding:5px 10px;
border:none;
background:#f59e0b;
color:#fff;
border-radius:5px;
cursor:pointer;
}

select{padding:5px}

/* CHART */
canvas{
background:#1e293b;
padding:1rem;
margin-top:1rem;
border-radius:10px;
}
.chart-container{
width:350px;
margin:20px auto;
}

.chart-container canvas{
width:100% !important;
height:300px !important;
}
</style>
</head>

<body>

<div class="header">
<h2>Admin Dashboard</h2>
<a href="logout.jsp">Logout</a>
</div>

<div class="main">

<div class="sidebar">
<a href="#">Dashboard</a>
<a href="#users">Manage Users</a>
<a href="#orders">Manage Orders</a>
<a href="#reports">Reports</a>
</div>

<div class="content">

<!-- STATS -->
<div class="stats">

    <div class="card card-users">
        <h4>Total Users</h4>
        <p><%= totalUsers %></p>
    </div>

    <div class="card card-designers">
        <h4>Designers</h4>
        <p><%= totalDesigners %></p>
    </div>

    <div class="card card-orders">
        <h4>Total Orders</h4>
        <p><%= totalOrders %></p>
    </div>

    <div class="card card-earnings">
        <h4>Earnings</h4>
        <p>₹<%= totalEarnings %></p>
    </div>

</div>

<!-- USERS -->
<div class="section" id="users">
<h2>Manage Users</h2>
<table>
<tr><th>ID</th><th>Name</th><th>Email</th><th>Role</th><th>Delete</th></tr>

<%
Statement st1 = conn.createStatement();
ResultSet rsu = st1.executeQuery("SELECT * FROM users");

while(rsu.next()){
%>

<tr>
<td><%= rsu.getInt("user_id") %></td>
<td><%= rsu.getString("full_name") %></td>
<td><%= rsu.getString("email") %></td>
<td><%= rsu.getString("role") %></td>

<td>
<a href="admin-dashboard.jsp?action=deleteUser&id=<%= rsu.getInt("user_id") %>"
onclick="return confirm('Delete user?')">Delete</a>
</td>
</tr>

<% } %>
</table>
</div>

<!-- ORDERS -->
<div class="section" id="orders">
<h2>Manage Orders</h2>

<table>
<tr>
<th>ID</th>
<th>User</th>
<th>Status</th>
<th>Price</th>
<th>Update</th>
<th>Delete</th>
</tr>

<%
Statement st2 = conn.createStatement();
ResultSet rso = st2.executeQuery("SELECT * FROM orders");

while(rso.next()){
%>

<tr>
<td><%= rso.getInt("order_id") %></td>
<td><%= rso.getInt("user_id") %></td>
<td><%= rso.getString("status") %></td>
<td>₹<%= rso.getDouble("price") %></td>

<td>
<form method="get">
<input type="hidden" name="action" value="updateOrder">
<input type="hidden" name="id" value="<%= rso.getInt("order_id") %>">

<select name="status">
<option>pending</option>
<option>progress</option>
<option>completed</option>
<option>cancelled</option>
</select>

<button>Update</button>
</form>
</td>

<td>
<a href="admin-dashboard.jsp?action=deleteOrder&id=<%= rso.getInt("order_id") %>"
onclick="return confirm('Delete order?')">Delete</a>
</td>

</tr>

<% } %>
</table>
</div>

<!-- CHARTS -->
<div class="section" id="reports">
<h2>Order Analytics</h2>

<div class="chart-container">
    <canvas id="pieChart"></canvas>
</div>

<div class="chart-container">
    <canvas id="barChart"></canvas>
</div>
</div>

</div>
</div>

<script>
// PIE
new Chart(document.getElementById("pieChart"), {
type:'pie',
data:{
labels:["Pending","Progress","Completed","Cancelled"],
datasets:[{
data:[<%= pending %>,<%= progress %>,<%= completed %>,<%= cancelled %>]
}]
}
});

// BAR
new Chart(document.getElementById("barChart"), {
type:'bar',
data:{
labels:["Pending","Progress","Completed","Cancelled"],
datasets:[{
label:"Orders",
data:[<%= pending %>,<%= progress %>,<%= completed %>,<%= cancelled %>]
}]
}
});
</script>

</body>
</html>