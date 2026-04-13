<%-- 
    Document   : logout
    Created on : 15 Mar 2026, 8:32:46 pm
    Author     : SUJITHRA
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate the session to log the user out
    session.invalidate();

    // Redirect to the login page
    response.sendRedirect("login.jsp");
%>
