<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.sql.*"%>
<%@page session="true" %>
<%
 Connection conn = null ;
 Connection connection = null;
 Statement statement = null;	
	try {
		conn = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","password");
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		System.out.println("ERROR");
		//e.printStackTrace();
	}
	if (conn!=null) {
		System.out.println("Connected Successfully");
		
	}
%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>looooogin</title>
</head>
<body>
	<h3>Welcome. Login to your profile.</h3>
	


	<br /> Please Register!
	<form method="get" action="login1.jsp">
		<table>
			<tr>
				<td>Username:</td>
				<td><input type="text" name="username" size=12 /></td>
			</tr>
			<tr>
				<td>Name:</td>
				<td><input type="text" name="name" size=12 /></td>
			</tr>
			<tr>
				<td>Surname:</td>
				<td><input type="text" name="surname" size=12 /></td>
			</tr>
			<tr>
				<td>Date Of Birth:</td>
				<td><input type="text" id= "birthday" name="birthday" size=12 /></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password" name="password" size=12 /></td>
			</tr>
			<tr>
				<td colspan=2><input type=submit /></td>
			</tr>
		</table>
	</form>
                <% 
                
				String test= (String)session.getAttribute("username");
                
				
				System.out.println(test);
				%>
				<h1> Thank you for loging in user <%=test%></h1>
			<!--String username=null;
				if (test!=null) {
					 username=test;
				}
				else {
					 username = request.getParameter("username");
				}
				//String username = request.getParameter("username");
				String name = request.getParameter("name");
				String surname = request.getParameter("surname");
				String date_of_birth=request.getParameter("birthday");
				String password = request.getParameter("password");
				String testme = "TESTME1";
				session.setAttribute("message",testme);
				
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				try {
					connection = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","password");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					System.out.println("ERROR");
					//e.printStackTrace();
				}
				if (connection!=null) {
					statement = connection.createStatement();
					String sql = "INSERT INTO users (username, name,date_of_birth,password,surname) VALUES( \"" + username  + "\" ,\"" + name + "\"  ,\"" + date_of_birth + "\",\"" + password + "\",\"" + surname + "\") ;";
					int result = statement.executeUpdate(sql);
				} 
				%> -->
 

</body>
</html>