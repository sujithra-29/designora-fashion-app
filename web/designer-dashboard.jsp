<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String userName = "Designer";
    String userInitial = "D";
    Integer userId = (Integer) session.getAttribute("user_id");

    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String DB_URL = "jdbc:derby://localhost:1527/designora";
    String DB_USER = "app";
    String DB_PASS = "app";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    int totalDesigns = 0;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

        // ✅ Get user info
        ps = conn.prepareStatement("SELECT full_name, role FROM users WHERE user_id=?");
        ps.setInt(1, userId);
        rs = ps.executeQuery();

        if (rs.next()) {
            String fetchedName = rs.getString("full_name");
            String role = rs.getString("role");

            if (role == null || !role.equalsIgnoreCase("designer")) {
                response.sendRedirect("login.jsp");
                return;
            }

            if (fetchedName != null && !fetchedName.trim().isEmpty()) {
                userName = fetchedName;
                userInitial = fetchedName.substring(0, 1).toUpperCase();
            }
        } else {
            response.sendRedirect("login.jsp");
            return;
        }

        rs.close();
        ps.close();

        // ✅ Count designs
        ps = conn.prepareStatement("SELECT COUNT(*) FROM designs WHERE designer_name=?");
        ps.setString(1, userName);
        rs = ps.executeQuery();

        if (rs.next()) {
            totalDesigns = rs.getInt(1);
        }

    } catch (Exception e) {
        out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Designer Dashboard</title>

<!-- KEEP YOUR EXISTING CSS (NO CHANGE) -->
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:system-ui,-apple-system,sans-serif;background:#0f172a;color:#fff}
a{text-decoration:none}
.header{background:linear-gradient(90deg,#1e293b,#1e3a52,#1e293b);border-bottom:1px solid rgba(71,85,105,.5);padding:1rem 2rem}
.header-content{max-width:1400px;margin:0 auto;display:flex;justify-content:space-between;align-items:center}
.logo{font-size:1.5rem;background:linear-gradient(90deg,#fbbf24,#fb7185);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent}
.user-menu{display:flex;align-items:center;gap:2rem}
.user-menu a{color:#9ca3af;font-size:.9rem;transition:.3s}
.user-menu a:hover{color:#fbbf24}
.user-info{display:flex;align-items:center;gap:1rem}
.avatar{width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,#f59e0b,#fb7185);display:flex;align-items:center;justify-content:center;font-size:1.2rem;border:2px solid rgba(251,191,36,.5)}
.badge-designer{background:rgba(251,191,36,.2);color:#fbbf24;padding:.25rem .75rem;border-radius:1rem;font-size:.8rem}
.main{display:flex;max-width:1400px;margin:0 auto}
.sidebar{width:260px;background:rgba(30,41,59,.5);border-right:1px solid rgba(71,85,105,.5);min-height:calc(100vh - 70px);padding:2rem 0}
.sidebar-menu{list-style:none}
.sidebar-menu li{margin-bottom:.5rem}
.sidebar-menu a{display:flex;align-items:center;gap:1rem;padding:1rem 2rem;color:#9ca3af;transition:.3s}
.sidebar-menu a:hover,.sidebar-menu a.active{background:rgba(251,191,36,.1);color:#fbbf24;border-left:3px solid #fbbf24}
.content{flex:1;padding:2rem}
.page-header{margin-bottom:2rem}
.page-header h1{font-size:2rem;margin-bottom:.5rem}
.page-header p{color:#9ca3af}
.stats{display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:1.5rem;margin-bottom:2rem}
.stat-card{background:rgba(30,41,59,.5);border:1px solid rgba(71,85,105,.5);border-radius:1rem;padding:1.5rem;transition:.3s}
.stat-card:hover{border-color:rgba(251,191,36,.5);transform:translateY(-2px)}
.stat-icon{width:3rem;height:3rem;border-radius:.5rem;display:flex;align-items:center;justify-content:center;font-size:1.5rem;margin-bottom:1rem}
.stat-value{font-size:2rem;font-weight:700;margin-bottom:.25rem;background:linear-gradient(90deg,#fbbf24,#fb7185);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent}
.stat-label{color:#9ca3af;font-size:.9rem}
.stat-change{font-size:.85rem;margin-top:.5rem}
.stat-up{color:#10b981}
.section{background:rgba(30,41,59,.5);border:1px solid rgba(71,85,105,.5);border-radius:1rem;padding:2rem;margin-bottom:2rem}
.section-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:1.5rem}
.section-header h2{font-size:1.5rem}
.btn{padding:.75rem 1.5rem;background:linear-gradient(90deg,#f59e0b,#fb7185);border:none;border-radius:.5rem;color:#fff;font-size:.9rem;cursor:pointer;transition:.3s;display:inline-flex;align-items:center;gap:.5rem}
.btn:hover{box-shadow:0 10px 20px rgba(251,191,36,.3);transform:translateY(-2px)}
.btn-secondary{background:rgba(71,85,105,.5);border:1px solid rgba(71,85,105,.5)}
.table{width:100%;border-collapse:collapse}
.table th{text-align:left;padding:1rem;border-bottom:1px solid rgba(71,85,105,.5);color:#9ca3af;font-size:.9rem}
.table td{padding:1rem;border-bottom:1px solid rgba(71,85,105,.5)}
.badge{display:inline-block;padding:.25rem .75rem;border-radius:1rem;font-size:.85rem}
.badge-pending{background:rgba(251,191,36,.2);color:#fbbf24}
.badge-completed{background:rgba(16,185,129,.2);color:#10b981}
.badge-progress{background:rgba(59,130,246,.2);color:#3b82f6}
.action-btns{display:flex;gap:.5rem}
.action-btn{padding:.5rem .75rem;background:rgba(71,85,105,.5);border:none;border-radius:.375rem;color:#fff;font-size:.85rem;cursor:pointer;transition:.3s}
.action-btn:hover{background:rgba(251,191,36,.3)}
.designs-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:1rem}
.design-item{border-radius:.5rem;overflow:hidden;cursor:pointer;transition:.3s;border:1px solid rgba(71,85,105,.5);position:relative}
.design-item:hover{border-color:rgba(251,191,36,.5);transform:scale(1.05)}
.design-thumb{height:200px;background:linear-gradient(135deg,#312e81,#1e293b);display:flex;align-items:center;justify-content:center;font-size:3rem;position:relative}
.design-stats{position:absolute;top:.5rem;right:.5rem;background:rgba(0,0,0,.7);backdrop-filter:blur(10px);padding:.25rem .5rem;border-radius:.25rem;font-size:.75rem;display:flex;align-items:center;gap:.25rem}
.design-name{padding:1rem;font-size:.9rem;text-align:center}
.design-thumb img{width:100%;height:100%;object-fit:cover}
@media(max-width:968px){
.sidebar{width:70px}
.sidebar-menu a span{display:none}
.sidebar-menu a{justify-content:center}
.main{flex-direction:column}
.sidebar{width:100%;min-height:auto;border-right:none;border-bottom:1px solid rgba(71,85,105,.5)}
.sidebar-menu{display:flex;justify-content:space-around}
.stats{grid-template-columns:1fr}
}
</style>
</head>

<body>

<!-- HEADER (UNCHANGED) -->
<div class="header">
    <div class="header-content">
        <div class="logo">✨ Designora</div>
        <div class="user-menu">
            <a href="home.jsp">Home</a>
            <div class="user-info">
                <span class="badge-designer">Designer</span>
                <div class="avatar"><%= userInitial %></div>
                <span><%= userName %></span>
            </div>
        </div>
    </div>
</div>

<div class="main">

<!-- SIDEBAR (UNCHANGED) -->
<aside class="sidebar">
    <ul class="sidebar-menu">
        <li><a href="designer-dashboard.jsp" class="active">📊 <span>Dashboard</span></a></li>
        <li><a href="add-design.jsp">➕ <span>Add Design</span></a></li>
        <li><a href="view-orders.jsp">📦 <span>Orders</span></a></li>
        <li><a href="login.jsp">🚪 <span>Logout</span></a></li>
    </ul>
</aside>

<div class="content">

<!-- HEADER -->
<div class="page-header">
    <h1>Welcome back, <%= userName %>! 👋</h1>
    <p>Your real-time dashboard</p>
</div>

<!-- STATS -->
<div class="stats">
    <div class="stat-card">
        <div class="stat-icon">🎨</div>
        <div class="stat-value"><%= totalDesigns %></div>
        <div class="stat-label">Your Designs</div>
    </div>
</div>

<!-- DESIGNS -->
<div class="section">
    <div class="section-header">
        <h2>Your Designs</h2>
        <a href="add-design.jsp" class="btn">➕ Add New Design</a>
    </div>

    <div class="designs-grid">

    <%
        PreparedStatement ps2 = null;
        ResultSet rs2 = null;

        try {
            ps2 = conn.prepareStatement(
                "SELECT * FROM designs WHERE designer_name=?"
            );
            ps2.setString(1, userName);
            rs2 = ps2.executeQuery();

            while (rs2.next()) {
    %>

        <div class="design-item">
            <div class="design-thumb">
                <img src="<%= rs2.getString("image_url") %>" alt="Design">
                <div class="design-stats">₹ <%= rs2.getDouble("price") %></div>
            </div>
            <div class="design-name">
                <%= rs2.getString("name") %>
            </div>
        </div>

    <%
            }
        } catch (Exception e) {
            out.println("Error loading designs: " + e.getMessage());
        } finally {
            try { if (rs2 != null) rs2.close(); } catch (Exception e) {}
            try { if (ps2 != null) ps2.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    %>

    </div>
</div>

</div>
</div>

</body>
</html>