<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.sql.*"%>
<%@page session="true" %>

<html>
<head>
<meta charset="ISO-8859-1">
<%
String username= (String)session.getAttribute("username");
 %>
<title>Home Page </title>
</head>
<body>
	<h1>Welcome to your Home Page <%=username %></h1>
	<form method="post" action="myhomepage.jsp">
		<div class="horizontal" style="width: 100%">
			<button style="width: 50%" name="pageupdate">Update your Info</button>
			<button style="width: 50%" name="products">Products</button>
			<button style="width: 50%" name="basket">Basket</button>
			<button style="width: 50%" name="logout">Logout</button>
		</div>
	</form>
	<%
	if (request.getParameter("logout") != null) {
		session.invalidate();
		response.sendRedirect("login.jsp");	
	}
	else if (request.getParameter("pageupdate")!=null) {
		response.sendRedirect("pageupdate.jsp");
	}
	else if (request.getParameter("basket")!=null) {
		response.sendRedirect("basket.jsp");
	}
	else if (request.getParameter("products")!=null) {
		response.sendRedirect("products.jsp");
	}
	%>
</body>
</html>