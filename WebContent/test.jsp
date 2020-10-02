<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.sql.*"%>
<%@page session="true" %>
<%@ page import="java.util.*"%>
<%@ page import="models.Product"%>

<html>
<head>
<%String username = (String)session.getAttribute("username"); %>
<meta charset="ISO-8859-1">
<title>TEST</title>
</head>
<body>

 <h1> YOU GOT HERE <%=username%></h1>
</body>
<% 
ArrayList<Product> test = null;
session.invalidate();
%>

</html>