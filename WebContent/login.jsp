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
		System.out.println("Connected Successfully");
		
	}
%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
	<h3>Welcome. Login to your profile.</h3>
	<form method="get" action="login.jsp">
	<table>
		<tr>
			<td>Username:</td>
			<td><input type="text" name="username" size=12 /></td>
		</tr>
		<tr>
			<td>Password:</td>
			<td><input type="password" name="password" size=12 /></td>
		</tr>
		<tr>
				<td colspan=2><input type=submit value="Login"/></td>
		</tr>
	</table>
	</form>
	<%
	if (request.getParameter("username") != null && request.getParameter("password") != null ) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
			//Class.forName("com.mysql.jdbc.Driver").newInstance();
			try {
				connection = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","password");
			} catch (SQLException e) {
				System.out.println("ERROR");
			}
			if (connection!=null) {
				
			//HERE CHECK IF USERNAME AND PASS MATCHES MY DB
				boolean status=false;
				try (PreparedStatement preparedStatement = connection.prepareStatement("select * from users where username = ? and password = ?")) {
					preparedStatement.setString(1, username);
					preparedStatement.setString(2, password);
					//System.out.println(preparedStatement);
					ResultSet rs = preparedStatement.executeQuery();
					status = rs.next();
				} catch (SQLException e) {
					System.out.println("ERROR");
				}
				if (status != false) {
					session.setAttribute("username",username);
					response.sendRedirect("myhomepage.jsp");            //SWITCH TO MYHOMEPAGE
					System.out.println(username);
				}
				else {
					try (PreparedStatement preparedStatement = connection.prepareStatement("select * from users where username = ? ")) {
						preparedStatement.setString(1, username);
						//preparedStatement.setString(2, password);
						//System.out.println(preparedStatement);
						ResultSet rs = preparedStatement.executeQuery();
						status = rs.next();
					} catch (SQLException e) {
						System.out.println("ERROR");
					}
					if (status != false) {
						JOptionPane optionPane = new JOptionPane("Error Wrong Password",JOptionPane.WARNING_MESSAGE);
						JDialog dialog = optionPane.createDialog("Incorrect Password");
						dialog.setAlwaysOnTop(true); // to show top of all other application
						dialog.setVisible(true); 
						response.sendRedirect("login.jsp");
					}
					else {
					JOptionPane optionPane = new JOptionPane("Error You are not Registered Redirecting to signup page",JOptionPane.WARNING_MESSAGE);
					JDialog dialog = optionPane.createDialog("Username Not Found");
					dialog.setAlwaysOnTop(true); // to show top of all other application
					dialog.setVisible(true); 
					session.setAttribute("username",username);
					response.sendRedirect("newuser.jsp");
					}
				}
		}
		String test=(String)session.getAttribute("username");
	
	%>
    <h1> Thank you for logging in user <%=test%></h1>
	<%
	}
	%>


</body>
</html>