<%@ page import="java.sql.*" %>
<%@ include file="config.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Integer userId = (Integer) session.getAttribute("user_id");

if(userId == null){
    response.sendRedirect("login.jsp");
    return;
}

boolean buyNow = "true".equals(request.getParameter("buy_now"));

if(buyNow){

    int designId = Integer.parseInt(request.getParameter("design_id"));
    double price = Double.parseDouble(request.getParameter("price"));

    PreparedStatement ps = conn.prepareStatement(
        "INSERT INTO orders(user_id, design_id, quantity, price, order_date) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)"
    );

    ps.setInt(1, userId);
    ps.setInt(2, designId);
    ps.setInt(3, 1);
    ps.setDouble(4, price);

    ps.executeUpdate();
    ps.close();

}else{

    PreparedStatement psCart = conn.prepareStatement(
        "SELECT c.design_id, c.quantity, d.price FROM cart c JOIN designs d ON c.design_id=d.design_id WHERE c.user_id=?"
    );

    psCart.setInt(1, userId);
    ResultSet rs = psCart.executeQuery();

    while(rs.next()){

        int designId = rs.getInt("design_id");
        int quantity = rs.getInt("quantity");
        double price = rs.getDouble("price");

        double totalPrice = price * quantity; 

        PreparedStatement psOrder = conn.prepareStatement(
            "INSERT INTO orders(user_id, design_id, quantity, price, order_date) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)"
        );

        psOrder.setInt(1, userId);
        psOrder.setInt(2, designId);
        psOrder.setInt(3, quantity);
        psOrder.setDouble(4, totalPrice);

        psOrder.executeUpdate();
        psOrder.close();
    }

    rs.close();
    psCart.close();

    PreparedStatement clear = conn.prepareStatement("DELETE FROM cart WHERE user_id=?");
    clear.setInt(1, userId);
    clear.executeUpdate();
    clear.close();
}
%>

<script>
alert("Order placed successfully!");
window.location.href="user-dashboard.jsp";
</script>