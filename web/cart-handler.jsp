<%@ page import="java.sql.*" %>
<%@ include file="config.jsp" %>
<%
Integer userId = (Integer) session.getAttribute("user_id");
if(userId == null){
    response.sendRedirect("login.jsp");
    return;
}

String action = request.getParameter("action");

PreparedStatement ps = null;
ResultSet rs = null;

try {
    if("add".equals(action)){
        int designId = Integer.parseInt(request.getParameter("design_id"));

        // Check if item already in cart
        ps = conn.prepareStatement("SELECT quantity FROM cart WHERE user_id=? AND design_id=?");
        ps.setInt(1, userId);
        ps.setInt(2, designId);
        rs = ps.executeQuery();

        if(rs.next()){
            int qty = rs.getInt("quantity");
            rs.close();
            ps.close();

            ps = conn.prepareStatement("UPDATE cart SET quantity=? WHERE user_id=? AND design_id=?");
            ps.setInt(1, qty + 1);
            ps.setInt(2, userId);
            ps.setInt(3, designId);
            ps.executeUpdate();
            ps.close();
        } else {
            rs.close();
            ps.close();

            ps = conn.prepareStatement("INSERT INTO cart(user_id, design_id, quantity) VALUES (?, ?, ?)");
            ps.setInt(1, userId);
            ps.setInt(2, designId);
            ps.setInt(3, 1);
            ps.executeUpdate();
            ps.close();
        }

        response.sendRedirect("view-cart.jsp");

    } else if("remove".equals(action)){
        int cartId = Integer.parseInt(request.getParameter("cart_id"));
        ps = conn.prepareStatement("DELETE FROM cart WHERE cart_id=?");
        ps.setInt(1, cartId);
        ps.executeUpdate();
        ps.close();

        response.sendRedirect("view-cart.jsp");

    } else {
        response.sendRedirect("view-cart.jsp");
    }

} catch(Exception e){
    out.println("Error: " + e.getMessage());
} finally {
    try { if(rs != null) rs.close(); } catch(Exception e){}
    try { if(ps != null) ps.close(); } catch(Exception e){}
}
%>