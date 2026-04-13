<%@ page import="java.sql.*" %> 
<%@ include file="config.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Integer userId = (Integer) session.getAttribute("user_id");
if(userId == null){
    response.sendRedirect("login.jsp");
    return;
}

PreparedStatement ps = null;
ResultSet rs = null;
double total = 0;
%>
<%
    String userName = (String) session.getAttribute("user_name");
    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String firstLetter = userName.substring(0, 1).toUpperCase();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Your Cart - Designora</title>
    <style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:system-ui,-apple-system,sans-serif;background:#0f172a;color:#fff}
.header{background:linear-gradient(90deg,#1e293b,#1e3a52,#1e293b);border-bottom:1px solid rgba(71,85,105,.5);padding:1rem 2rem;position:sticky;top:0;z-index:999}
.header-content{max-width:1400px;margin:0 auto;display:flex;justify-content:space-between;align-items:center}
.logo{font-size:1.5rem;background:linear-gradient(90deg,#fbbf24,#fb7185);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent}
.nav-menu{display:flex;gap:2rem}
.nav-menu a{color:#9ca3af;transition:.3s}
.nav-menu a:hover{color:#fbbf24}
.user-info{display:flex;align-items:center;gap:1rem}
.avatar{width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,#f59e0b,#fb7185);display:flex;align-items:center;justify-content:center;font-size:1.2rem;border:2px solid rgba(251,191,36,.5)}
a{text-decoration:none}
.container{max-width:900px;margin:auto;margin-top: 50px;}
.title{text-align:center;font-size:2rem;margin-bottom:2rem;background:linear-gradient(90deg,#fbbf24,#fb7185);-webkit-background-clip:text;-webkit-text-fill-color:transparent}
table{width:100%;border-collapse:collapse;background:rgba(30,41,59,.8);border-radius:1rem;overflow:hidden}
th, td{padding:1rem;text-align:center}
th{background:#1e293b;color:#fbbf24}
tr{border-bottom:1px solid rgba(71,85,105,.5)}
img{width:60px;height:60px;object-fit:cover;border-radius:.5rem}
.total{text-align:right;margin-top:1.5rem;font-size:1.3rem}
.btn{margin-top:1rem;padding:.7rem 1.5rem;background:linear-gradient(90deg,#f59e0b,#fb7185);border:none;border-radius:.5rem;color:#fff;font-size:1rem;cursor:pointer}
.btn-remove{background:rgba(255,0,0,0.6);color:#fff;border:none;border-radius:.5rem;padding:.5rem 1rem;cursor:pointer}
.empty{text-align:center;margin-top:2rem;color:#9ca3af}
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
    <div class="title">🛒 Your Cart</div>

<%
try {
    ps = conn.prepareStatement(
        "SELECT c.cart_id, d.design_id, d.name, d.image_url, d.price, c.quantity " +
        "FROM cart c JOIN designs d ON c.design_id = d.design_id " +
        "WHERE c.user_id=?"
    );
    ps.setInt(1, userId);
    rs = ps.executeQuery();

    boolean hasItems = false;
%>

<table>
    <tr>
        <th>Design</th>
        <th>Image</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Subtotal</th>
        <th>Action</th>
    </tr>

<%
    while(rs.next()){
        hasItems = true;

        int cartId = rs.getInt("cart_id");
        String name = rs.getString("name");
        String image = rs.getString("image_url");
        double price = rs.getDouble("price");
        int qty = rs.getInt("quantity");
        double subtotal = price * qty;
        total += subtotal;
%>

<tr>
    <td><%= name %></td>
    <td><img src="<%= rs.getString("image_url") %>" width="200" alt="Design"></td>
    <td>₹<%= price %></td>
    <td><%= qty %></td>
    <td>₹<%= subtotal %></td>
    <td>
        <form action="cart-handler.jsp" method="post">
            <input type="hidden" name="action" value="remove">
            <input type="hidden" name="cart_id" value="<%= cartId %>">
            <button class="btn-remove">Remove</button>
        </form>
    </td>
</tr>

<%
    }
%>
</table>

<%
    if(!hasItems){
%>
    <div class="empty">Your cart is empty</div>
<%
    } else {
%>
    <div class="total">Total: ₹<%= total %></div>

    <form action="order-confirmation.jsp" method="post">
        <button class="btn">Place Order</button>
    </form>
<%
    }

} catch(Exception e){
    out.println("Error: " + e.getMessage());
} finally {
    if(rs != null) try { rs.close(); } catch(Exception e) {}
    if(ps != null) try { ps.close(); } catch(Exception e) {}
}
%>
</div>
</body>
</html>