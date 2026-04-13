<%@ page import="java.sql.*" %>
<%@ include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String userName = (String) session.getAttribute("user_name");
Integer userId = (Integer) session.getAttribute("user_id");

if(userName == null || userId == null){
    response.sendRedirect("login.jsp");
    return;
}
String firstLetter = userName.substring(0, 1).toUpperCase();
boolean buyNow = "true".equals(request.getParameter("buy_now"));
%>

<!DOCTYPE html>
<html>
<head>
<title>Order Confirmation</title>

<style>
body{background:#0f172a;color:white;font-family:sans-serif;}
.container{width:90%;margin:auto;}
.card{display:flex;background:#1e293b;margin:20px 0;padding:20px;border-radius:12px;}
.image-box img{width:250px;height:300px;object-fit:cover;border-radius:10px;}
.details{margin-left:20px;}
.price{color:#22c55e;font-size:18px;font-weight:bold;}
.total{font-size:22px;margin-top:20px;text-align:right;}
.btn{padding:10px 20px;background:orange;border:none;border-radius:6px;color:white;cursor:pointer;}
.header{background:linear-gradient(90deg,#1e293b,#1e3a52,#1e293b);border-bottom:1px solid rgba(71,85,105,.5);padding:1rem 2rem;position:sticky;top:0;z-index:999}
.header-content{max-width:1400px;margin:0 auto;display:flex;justify-content:space-between;align-items:center}
.logo{font-size:1.5rem;background:linear-gradient(90deg,#fbbf24,#fb7185);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent}
.nav-menu{display:flex;gap:2rem}
.nav-menu a{color:#9ca3af;transition:.3s}
.nav-menu a:hover{color:#fbbf24}
.user-info{display:flex;align-items:center;gap:1rem}
.avatar{width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,#f59e0b,#fb7185);display:flex;align-items:center;justify-content:center;font-size:1.2rem;border:2px solid rgba(251,191,36,.5)}
a{text-decoration:none}

</style>

</head>
<body>
<div class="header">
    <div class="header-content">
        <div class="logo">✨ Designora</div>
        <div class="nav-menu">
            <a href="home.jsp">Home</a>
            <a href="view-designs.jsp">Designs</a>
            <a href="user-dashboard.jsp">Dashboard</a>
        </div>
        <div class="user-info">
            <div class="avatar"><%= firstLetter %></div>
            <span><%= userName %></span>
        </div>
    </div>
</div>
<div class="container">

<h1>Order Confirmation</h1>

<%
if(buyNow){

    int designId = Integer.parseInt(request.getParameter("design_id"));

    PreparedStatement ps = conn.prepareStatement("SELECT * FROM designs WHERE design_id=?");
    ps.setInt(1, designId);
    ResultSet rs = ps.executeQuery();

    if(rs.next()){
%>

<div class="card">
    <div class="image-box">
        <img src="<%= rs.getString("image_url") %>">
    </div>

    <div class="details">
        <h2><%= rs.getString("name") %></h2>
        <p>Designer: <%= rs.getString("designer_name") %></p>
        <p>Category: <%= rs.getString("category") %></p>
        <p>Fabric: <%= rs.getString("material") %></p>
        <p>Sizes: <%= rs.getString("size") %></p>
        <p>Color: <%= rs.getString("color") %></p>

        <div class="price">₹ <%= rs.getDouble("price") %></div>

        <form action="place-order.jsp" method="post">
            <input type="hidden" name="buy_now" value="true">
            <input type="hidden" name="design_id" value="<%= designId %>">
            <input type="hidden" name="price" value="<%= rs.getDouble("price") %>">
            <button class="btn">Confirm Order</button>
        </form>
    </div>
</div>

<%
    }

}else{

    PreparedStatement psCart = conn.prepareStatement(
        "SELECT d.design_id,d.name,d.designer_name,d.image_url,d.category,d.material,d.size,d.color,d.price,SUM(c.quantity) as quantity " +
        "FROM cart c JOIN designs d ON c.design_id=d.design_id WHERE c.user_id=? " +
        "GROUP BY d.design_id,d.name,d.designer_name,d.image_url,d.category,d.material,d.size,d.color,d.price"
    );

    psCart.setInt(1, userId);
    ResultSet rsCart = psCart.executeQuery();

    double total = 0;
    boolean hasItems = false;

    while(rsCart.next()){
        hasItems = true;

        double price = rsCart.getDouble("price");
        int qty = rsCart.getInt("quantity");
        double subtotal = price * qty;
        total += subtotal;
%>

<div class="card">
    <div class="image-box">
        <img src="<%= rsCart.getString("image_url") %>">
    </div>

    <div class="details">
        <h2><%= rsCart.getString("name") %></h2>
        <p>Designer: <%= rsCart.getString("designer_name") %></p>
        <p>Category: <%= rsCart.getString("category") %></p>
        <p>Fabric: <%= rsCart.getString("material") %></p>
        <p>Sizes: <%= rsCart.getString("size") %></p>
        <p>Color: <%= rsCart.getString("color") %></p>

        <p>Quantity: <%= qty %></p>

        <div class="price">
            ₹ <%= price %> × <%= qty %> = ₹ <%= subtotal %>
        </div>
    </div>
</div>

<%
    }

    if(hasItems){
%>

<div class="total">Grand Total: ₹ <%= total %></div>

<form action="place-order.jsp" method="post">
    <input type="hidden" name="buy_now" value="false">
    <button class="btn">Place Order</button>
</form>

<%
    } else {
%>

<p>Your cart is empty.</p>

<%
    }

}
%>

</div>
</body>
</html>