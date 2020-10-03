<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.sql.*"%>
<%@page session="true" %>
<%@ page import="javax.swing.JOptionPane" %>
<%@ page import ="javax.swing.JDialog" %>
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
		//System.out.println("Connected Successfully");
	}
%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New User SignUp</title>
</head>
<body>
	<h3>Register new User</h3>
	<%
		String username= (String)session.getAttribute("username");
	%>
	
	<form method="get" action="newuser.jsp">
		<table>
			<tr>
				<td>Username:</td>
				<td><input type="text" value= <%=username%> name="username" size=12 /></td>
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
				<td colspan=2><input type=submit value="Sign Up" /></td>
			</tr>
		</table>
	</form>
	<%  
		if (request.getParameter("username") != null && request.getParameter("password") != "" && request.getParameter("name") != ""  && request.getParameter("surname") != "" && request.getParameter("birthday") != "" ) {
		 String destination= "login.jsp";
		 username=request.getParameter("username");
		//CHECK FOR EXISTING USER
		try {	connection = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","password");
			} catch (SQLException e) {
				System.out.println("ERROR");
			}
			if (connection!=null) {
				boolean status=false;
				try (PreparedStatement preparedStatement = connection.prepareStatement("select * from users where username = ?")) {
					preparedStatement.setString(1, username);
					ResultSet rs = preparedStatement.executeQuery();
					status = rs.next();
				} catch (SQLException e) {
					System.out.println("ERROR");
				}
				if (status) {
					session.setAttribute("username",null);
					JOptionPane optionPane = new JOptionPane("Error You are already Registered,Redirecting to login",JOptionPane.WARNING_MESSAGE);
					JDialog dialog = optionPane.createDialog("Username Already used");
					dialog.setAlwaysOnTop(true); // to show top of all other application
					dialog.setVisible(true); 
					destination= "newuser.jsp";
				}
				else {
					String name = request.getParameter("name");
					String surname = request.getParameter("surname");
					String date_of_birth=request.getParameter("birthday");
					String password = request.getParameter("password");
					statement = connection.createStatement();
					String sql = "INSERT INTO users (username, name,date_of_birth,password,surname) VALUES( \"" + username  + "\" ,\"" + name + "\"  ,\"" + date_of_birth + "\",\"" + password + "\",\"" + surname + "\") ;";
					int result = statement.executeUpdate(sql);
					session.setAttribute("username",username);
					destination= "myhomepage.jsp";
					%>
					<h1> Thank you for your registration <%=username%></h1>
					<%
				}
			} 
				response.sendRedirect(destination);
			%>
	 <% 
	 }
     %>
     
</body>
</html>