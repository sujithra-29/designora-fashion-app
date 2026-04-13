<%@ page import="java.sql.*" %>

<%
Connection conn = null;

try {
    String DB_URL = "jdbc:derby://localhost:1527/Designora";
    String DB_USER = "app";
    String DB_PASS = "app";

    Class.forName("org.apache.derby.jdbc.ClientDriver");
    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

} catch (Exception e) {
    out.println("Database Connection Failed: " + e.getMessage());
}
%>