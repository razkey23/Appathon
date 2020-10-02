<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.sql.*"%>
<%@page session="true" %>

<html>
<head>
<meta charset="ISO-8859-1">
<%
String username=(String) session.getAttribute("username");
%>

      <% //https://www.tutorialspoint.com/jqueryui/jqueryui_datepicker.htm %>

     <link href = "https://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css"
         rel = "stylesheet">
      <script src = "https://code.jquery.com/jquery-1.10.2.js"></script>
      <script src = "https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
      
      <!-- Javascript -->
      <script>
         $(function() {
            $( "#datepicker-13" ).datepicker();
            $( "#datepicker-13" ).datepicker("show");
         });
      </script>
<title>Page Update</title>
</head>
<body>
	<h1>Update your data <%=username %></h1>
<!-- <form method="post" action="pageupdate"> -->
<form method="post" action="pageupdate.jsp">
	<table>
		
		<tr>
		 	<td>Update Name</td>
		<!--  <td><input type="text" onfocus="myFocusFunction()" onblur="myBlurFunction()" id="myInput"></td> -->
			<td><input type="text" id="name" name="name" size=12 /></td>
		</tr>
		<tr>
			<td>Update Surname</td>
			<td><input type="text" id="surname" name="surname" size=12 /></td>
		</tr>
		<tr>
			<td>Update Birthday</td>
			<td><input type="text" id="datepicker-13" name="birthday" size=12 /></td>
		</tr>
		<tr>
				<td colspan=2><input type=submit /></td>
		</tr>
	</table>
</form>
<% 
		
		Connection connection = null;
		//String username = (String) session.getAttribute("username");
		String name = request.getParameter("name");
		String surname = request.getParameter("surname");
		String birthday = request.getParameter("birthday");
			//Class.forName("com.mysql.jdbc.Driver").newInstance();
			try {
				connection = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","password");
			} catch (SQLException e) {
				System.out.println("ERROR_ERROR");
			}
			if (connection!=null) {
				
				if ((name == null && surname == null && birthday == null) ) {
					System.out.println("GOTHERE");
					//request.setAttribute("message", "Empty Attributes");
					//response.sendRedirect("pageupdate.jsp");
				}
				else if ((name != null) && (username !=null) && (birthday != null)) {
						PreparedStatement preparedStatement =  connection.prepareStatement( "update users set name = ?, date_of_birth = ?, surname = ? where username = ?;");
						preparedStatement.setString(1, name);
						preparedStatement.setString(3,surname);
						preparedStatement.setString(2,birthday);
						preparedStatement.setString(4,username);
						System.out.println(preparedStatement);
						try {
							 preparedStatement.executeUpdate();
							
							response.sendRedirect("myhomepage.jsp");
						}
						 catch (SQLException e) {
							
							response.sendRedirect("login.jsp");
							System.out.println("ERROR");
						} 
				}
			 } 
			else {
				response.sendRedirect("login.jsp");
			}
%>
</body>
</html>