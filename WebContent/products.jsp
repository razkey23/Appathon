<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.sql.*"%>
<%@page session="true" %>
<%@ page import="java.util.*"%>
<%@ page import="models.Product"%>

<html>
<style>
table, th, td {
  border: 1px solid black;
  border-spacing: 4px;
}
h1 {
	display: table;
	width: 100%;
	margin: 0;
}
h1>span {
	text-align: left;
	display: table-cell;
}
h1>a {
	text-align: right;
	display: table-cell;
}


/*https://www.w3schools.com/css/css_tooltip.asp */
.tooltip {
  position: relative;
  display: inline-block;
  border-bottom: 1px dotted black; /* If you want dots under the hoverable text */
}
.tooltip .tooltiptext {
  visibility: hidden;
  width: 120px;
  background-color: black;
  color: #fff;
  text-align: center;
  padding: 5px 0;
  border-radius: 6px;
 
  /* Position the tooltip text - see examples below! */
  position: absolute;
  z-index: 1;
}

/* Show the tooltip text when you mouse over the tooltip container */
.tooltip:hover .tooltiptext {
  visibility: visible;
}

</style>


<head>
<meta charset="ISO-8859-1">
<%
String username= (String)session.getAttribute("username");
 %>
 
<title>Product List</title>
</head>
<body>
	<form method="post" action="products.jsp">
		<h1>
			<span>Products</span> <a><button name="basket">Basket</button></a>
		</h1>
		<%
		
		if( request.getParameter("basket") != null) {
			response.sendRedirect("basket.jsp");
			
		}
		%>
		
		<table>
			<tr>
				<th width ="25%">Image</th>
				<th width ="25%">Name</th>
				<th width ="15%">Price</th>
			</tr>
			<% 
					
					List<Product> products=new ArrayList<Product>();
					
					//SELECT PRODUCTS AND INSERT THEM INTO THE ARRAYLIST
					try
					{
						Connection conn =(Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","password");
						try (PreparedStatement preparedStatement = conn.prepareStatement("select idproducts, name, image, price from products")){
						ResultSet resultset=preparedStatement.executeQuery();
						while(resultset.next()) {
							Product product = new Product(resultset.getString("idproducts"),resultset.getString("name"),resultset.getString("image"),resultset.getString("price"));	
							products.add(product);
						}
						}
						catch (SQLException e) {
							System.out.println("ERROR");
						}
					 }
					 catch (SQLException e) {
						System.out.println("ERROR");
						
					}
					System.out.println(products.size());
					for(int i=0;i<products.size();i++) {
						String idproducts=products.get(i).getId();
						String name=products.get(i).getName();
						String image=products.get(i).getImage();
						String price=products.get(i).getPrice();
						String vax= String.valueOf((Double.parseDouble(price)*124)/100);
					%>
					<tr> 
						<td style="text-align: center"><img
					src="C:\Users\razkey\eclipse-workspace\dke\WebContent\images/<%=image%>.jpg" width="100" height="100"></td>
						<td><%=name%></td>
						<td style="text-align: center"><div class="tooltip">
						<%=price%> <span class="tooltiptext"><%="with 24% VAT "+vax%> </span></div></td>
						
						<td><input type="submit" name="<%=name %>"  value="Add To Cart" id="tocart" /> </td>
					
					<%
						
					 	String check_submit_form = request.getParameter(name);
						ArrayList<Product> cart = null;
						boolean flag=true;
					 	if (check_submit_form != null) {
					 	//CHECK IF ITEM ALREADY EXISTS IN CART
					 		Object currentCart= session.getAttribute("cart");
						if (currentCart != null) {
								cart = (ArrayList<Product>) currentCart;

						}
						else 
						{
								cart = new ArrayList<Product>();
						}
						cart.add(new Product(idproducts,name,image,price));
						session.setAttribute("cart",cart);
						
					 	}
					}
					%>
		
					</tr>
		</table>	
	</form>
	
	
</body>
</html>