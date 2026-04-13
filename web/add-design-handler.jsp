<%@ page import="java.sql.*" %>
<%@ include file="config.jsp" %>
<%
Integer userId = (Integer) session.getAttribute("user_id");
String designerName = (String) session.getAttribute("user_name");

if (userId == null) {
    response.sendRedirect("login.jsp");
    return;
}

// Form fields
String name = request.getParameter("name");
String description = request.getParameter("description");
String category = request.getParameter("category");
String material = request.getParameter("material");
String size = request.getParameter("size");
String color = request.getParameter("color");
String imageUrl = request.getParameter("image_url"); // <-- URL input

double price = 0;
try { 
    price = Double.parseDouble(request.getParameter("price")); 
} catch(Exception e){}

// ===== Insert into DB =====
try {
    PreparedStatement ps = conn.prepareStatement(
        "INSERT INTO designs (name, designer_name, image_url, description, category, material, size, color, price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"
    );
    ps.setString(1, name);
    ps.setString(2, designerName);
    ps.setString(3, imageUrl); // store the URL directly
    ps.setString(4, description);
    ps.setString(5, category);
    ps.setString(6, material);
    ps.setString(7, size);
    ps.setString(8, color);
    ps.setDouble(9, price);
    ps.executeUpdate();
    ps.close();

    response.sendRedirect("designer-dashboard.jsp?success=1");

} catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>