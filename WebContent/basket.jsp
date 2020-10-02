<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.sql.*"%>
<%@page session="true" %>
<%@ page import="java.util.*"%>
<%@ page import="models.Product"%>
<%@ page import="servlet.Basket"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Basket</title>
</head>
	<style>
.container {
  position: relative;
}

.bottomright {
  position: absolute;
  bottom: 8px;
  right: 16px;
  font-size: 18px;
}

.redInput {
	text-align: center;
	pointer-events: none;
	color: red;
	font-weight: bold;
}
table tr.separator { height: 50px; }
tr.spaceUnder td{
margin-bottom:15px;
}

 </style>
<body>
 	<form method="post" action="basket">
 		<h1>
 			<span>Your Cart</span>
 			<br />
 				<a> 
 					<button name="continueBuying">Continue Buying</button>
 					<button name="Clear Basket">Clear Basket</button>
 		    	</a>
 		</h1>
 		<table style= "width : 100%;">
 			<tr>
 				<th width="20%"> Image </th>
 				<th width="20%">Name</th>
				<th width="16%">Price</th>
 			</tr>
 			<%
 				List<Product> cart = new ArrayList<Product>();
 				Object currentCart = session.getAttribute("cart");
 				if ( currentCart!=null) {
 					cart = (ArrayList<Product>) currentCart;
 				}
 				else {
 					cart=new ArrayList<Product>();
 				}
 				double sum=0;
 				for (int i=0;i<cart.size();i++) {
 				%>
 				<tr>
 					<td style="text-align: center"><img
					src="C:\Users\razkey\eclipse-workspace\dke\WebContent\images/<%=cart.get(i).getImage()%>.jpg" width="100"
					height="100"></td>
					<td style="text-align: center"><%=cart.get(i).getName()%></td>
					<td style="text-align: center"><%=cart.get(i).getPrice()%></td>
					<% 
					String Price = cart.get(i).getPrice();
					%>
				</tr>
				<tr class="separator" />
 				<%	
 					sum=sum+Double.parseDouble(cart.get(i).getPrice());
 				}
 			    
 				session.setAttribute("sum",sum);
 				//session.setAttribute("vat","0.24");
 				String checkme = (String)session.getAttribute("vat");
 				double vat=0.24;
 				if (checkme != null) {
 					vat = Double.parseDouble(session.getAttribute("vat").toString());
 	 				System.out.println(session.getAttribute("vat").toString());
 	 				System.out.println(vat);
 				}
 				
 				double vatSum=Math.round(sum*vat);
 				double totalSum=0;
 				%>
 					<%
 					  String flag=(String)session.getAttribute("discountApplied");
 					  //System.out.println(flag);
 					  if (flag != null) {
 						 if (flag.equals("Y")) {
 							 double newSum=Math.round(sum*0.8);
 	 						 totalSum=Math.round((vatSum+sum)*0.8);
 	 						session.setAttribute("sum",totalSum);
 					  	 
 					%>
 					<tr> 
 						<td style="text-align: center"> Cost without VAT: </td>
 						<td style="text-align: center"> <%=newSum %> </td>
 					</tr>
 					<tr> 
 						<td style="text-align: center">Cost including VAT: </td>
 						<td  style="text-align: center"><input type="text"
					name="sums" id="sum" style="text-align: center" value="<%=totalSum%>" readonly class="redInput" /></td>
					</tr>
 					<% 
 						}

 					else{
 						totalSum=Math.round(vatSum+sum);
 						double totalSum1=Math.round(sum);
 						session.setAttribute("sum",totalSum);
 					%>
 					<tr> 
 						<td style="text-align: center"> Cost without VAT: </td>
 						<td style="text-align: center"> <%=totalSum1 %> </td>
 					</tr>
 					<tr>
 						<td style="text-align: center" >Cost including VAT: </td>
 						<td style="text-align: center"><input type="text" style="text-align: center"
					name="sums" id="sum" value="<%=totalSum%>"/></td>
					</tr>
 					<%
 						}
 					 }
 					 else {
 						 totalSum=Math.round(vatSum+sum);
 						 double totalSum1=Math.round(sum);
  						session.setAttribute("sum",totalSum);
  					%>
  						<tr> 
 							<td style="text-align: center"> Cost without VAT: </td>
 							<td style="text-align: center"> <%=totalSum1 %> </td>
 						</tr>
  						<tr>
 							<td style="text-align: center">Cost including VAT: </td>
 							<td style="text-align: center"><input type="text"
								name="sums" style="text-align: center" id="sum" value="<%=totalSum%>"/></td>
						</tr>
 					<%
 					  }
 					%>
 					<tr class="separator" />
 				</table>
 				
 			<!-- <tr> -->	
					<td style="text-align: center">Enter Voucher Code Here:</td>
					<td style="text-align: center"><input type="text" name="voucher" ></td>
					<td style="text-align:left"><input type="submit" name="checkVoucher" value="Check" /></td>
			<!-- </tr> -->	
			
 		<!--  </table> -->
 		<h3>
 			<%
 			String countries[][]= {
 					{"Greece","USA","China","Germany","Spain"},
 					{"0.24","0.20","0.15","0.12","0.10"}};
 			
 			%>
 			<label>Choose Country</label>
 			<select name="country">
 				<option value="0"> <%=countries[0][0]%> : <%=countries[1][0] %> VAT </option>
    			<option value="1"> <%=countries[0][1]%> : <%=countries[1][1] %> VAT </option>
    			<option value="2"> <%=countries[0][2]%> : <%=countries[1][2] %> VAT </option>
    			<option value="3"> <%=countries[0][3]%> : <%=countries[1][3] %> VAT </option>
    			<option value="4"> <%=countries[0][4]%> : <%=countries[1][4] %> VAT </option>
  			</select>
 		<input type="submit" name="checkCountry" value="Country" />
 		</h3>
 		<h3>
 		<input type="submit" name="buy" value="Proceed to Checkout" />
 		</h3>
 	</form>
 	
</body>
</html>