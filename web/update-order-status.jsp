<%@ page import="java.sql.*" %>
<%@ include file="config.jsp" %>

<%
String id = request.getParameter("id");
String status = request.getParameter("status");

PreparedStatement ps = conn.prepareStatement(
    "UPDATE orders SET status=? WHERE order_id=?"
);

ps.setString(1, status);
ps.setInt(2, Integer.parseInt(id));

ps.executeUpdate();

response.sendRedirect("view-orders.jsp");
%>