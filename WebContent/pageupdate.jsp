<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.sql.*"%>
<%@page session="true" %>
<%@ page import="javax.swing.JOptionPane" %>
<%@ page import ="javax.swing.JDialog" %>

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
				<td colspan=2><input type=submit value="Update Info" /></td>
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
				boolean status=false;
				
				String oldName="",oldDOB="",oldSurname="";
				try (PreparedStatement preparedStatement = connection.prepareStatement("select * from users where username = ? ")) {
					preparedStatement.setString(1, username);
					//preparedStatement.setString(2, password);
					System.out.println(preparedStatement);
					ResultSet rs = preparedStatement.executeQuery();
					status = rs.next();
					oldName= rs.getString(2);
					oldDOB= rs.getString(3);
					oldSurname= rs.getString(5);
					System.out.println(rs.getString(5));
				} catch (SQLException e) {
					System.out.println("ERROR");
				}
				if (status!=false) {    // CHECK IF THERE IS AN ACTUAL USER
					if ((name == null && surname == null && birthday == null) ) {
					System.out.println("GOTHERE");
					
					}
					else if ((name != "") || (surname !="") || (birthday != "")) {
						String newName,newSurname,newBirthday;
						if (name =="") newName=oldName; 
						else 	newName=name;
						if (surname =="") newSurname=oldSurname; 
						else 	newSurname=surname;
						if (birthday =="") newBirthday=oldDOB; 
						else 	newBirthday=birthday;
			
						PreparedStatement preparedStatement =  connection.prepareStatement( "update users set name = ?, date_of_birth = ?, surname = ? where username = ?;");
						preparedStatement.setString(1, newName);
						preparedStatement.setString(3,newSurname);
						preparedStatement.setString(2,newBirthday);
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
					JOptionPane optionPane = new JOptionPane("Error You are not Registered Redirecting to signup page",JOptionPane.WARNING_MESSAGE);
					JDialog dialog = optionPane.createDialog("Username Not Found");
					dialog.setAlwaysOnTop(true); // to show top of all other application
					dialog.setVisible(true); 
					response.sendRedirect("newuser.jsp");
				}
				
			}
			else {
				response.sendRedirect("login.jsp");
			}
		 
%>
</body>
</html>