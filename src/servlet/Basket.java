package servlet;
import java.io.IOException;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.io.File;
import java.io.FileWriter;
import java.util.*;

import javax.swing.JDialog;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import models.Product;

@WebServlet("/basket")
public class Basket extends HttpServlet {

	/**
	 * 
	 */
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	private static final long serialVersionUID = 1L;
	public Basket() {
		super();
	}
	
	protected void doGet(HttpServletRequest request,HttpServletResponse response)
		throws ServletException,IOException {
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request,HttpServletResponse response)
				throws ServletException,IOException {
		
		
		String countries[][]= {
				{"Greece","USA","China","Germany","Spain"},
				{"0.24","0.20","0.15","0.12","0.10"}};
		HttpSession session = request.getSession();
		//session.setAttribute("message","N");
		//String sum= request.getParameter("sum");
		//double sum=0;
		double sum=(double)session.getAttribute("sum");
		if (request.getParameter("continueBuying")!=null) {
			System.out.println("GOT IN HERE");
		
			response.sendRedirect("products.jsp");
		}
		else if (request.getParameter("Clear Basket")!=null) {
			session.removeAttribute("cart");
			response.sendRedirect("basket.jsp");
		}
		else if (request.getParameter("checkVoucher")!=null) {
			String voucher = request.getParameter("voucher");
			System.out.println(voucher);
			if (voucher.equals("studentdiscount")) {
				session.setAttribute("discountApplied","Y");
			}
			else {session.setAttribute("discountApplied", "N"); }
			
			String temp= (String)session.getAttribute("discountApplied");
			session.setAttribute("discountApplied", temp);
			response.sendRedirect("basket.jsp");
		}
		else if (request.getParameter("checkCountry") != null) {
			String check1 = request.getParameter("country").toString();
			if (check1.equals( "0")) {
				session.setAttribute("vat", countries[1][0]);
			}
			else if (check1.equals("1")) {
				
				session.setAttribute("vat", countries[1][1]);
			}
			else if (check1.equals("2")) {
				
				session.setAttribute("vat", countries[1][2]);
			}
			else if (check1.equals("3")) {
			
				session.setAttribute("vat", countries[1][3]);
			}
			else if (check1.equals("4")) {
				
				session.setAttribute("vat", countries[1][4]);
			}
			else {session.setAttribute("vat", "0.24"); }

			response.sendRedirect("basket.jsp");
			String temp= (String)session.getAttribute("discountApplied");
			session.setAttribute("discountApplied", temp);
		}
		else if (request.getParameter("buy") != null ) {
			List<Product> cart = new ArrayList<Product>();
				Object currentCart = session.getAttribute("cart");
				if ( currentCart!=null) {
					cart = (ArrayList<Product>) currentCart;
				}
				else {
					cart=new ArrayList<Product>();
				}
				StringBuffer ret = new StringBuffer();
				for (int i=0;i<cart.size();i++) {
					String id = cart.get(i).getId();
					if (ret.length() > 0 && ret.length() !=cart.size()-1) ret.append(",");
					ret.append(id);
					System.out.println(id);
					
				}
				
				String ordersid=ret.toString();
				System.out.println(ordersid);
				
				String username=(String)session.getAttribute("username");
				if (username != null) {
					
					if (cart.size() !=0 ) {
						//***************INSERT INTO MY DATABASE 
						double totalSum = (Double)session.getAttribute("sum");
						try {
							Connection conn = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","password");
							Statement statement = conn.createStatement();
							String sql = "INSERT INTO orders (username, idproducts,sum) VALUES( \"" + username  + "\" ,\"" + ordersid + "\"  , \"" + totalSum + "\") ;";
							statement.executeUpdate(sql);
						
						} catch (SQLException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						} 
						//GET THE LAST INSERTED ELEMENT INTO MY DB, SO THAT I CAN INSERT THOSE DATA INTO THE FOLLOWING FILE
						String id= null;
						try {
							Connection connection = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","password");
							if(connection!=null) {
								PreparedStatement preparedStatement= connection.prepareStatement("SELECT idorders FROM orders  ORDER BY idorders DESC LIMIT 1;");						
								System.out.println(preparedStatement);
								ResultSet rs1=preparedStatement.executeQuery();
								
								while (rs1.next()) {
									 id = rs1.getString("idorders");
								}
								System.out.println(id);
						   }
						}
						catch (SQLException e2) {
							e2.printStackTrace();
						}
	                    //***********ΝOW INSERT INTO A FILE 
						
						String folder = getServletContext().getRealPath(File.separator + "orders");
						System.out.println(folder);
						Path path = Paths.get(folder);
						if (!Files.exists(path)) {
							Files.createDirectory(path);
						}
						FileWriter myWriter = new FileWriter(
								folder + File.separator + "order" +"_"+ String.valueOf(id) +"_"+ username + ".txt");
						myWriter.write(
								"Orderid:" + id + System.lineSeparator()+ "User: " + username + System.lineSeparator() +"Products_ID = " +ordersid + System.lineSeparator() + "Cost: "
										+ String.valueOf(totalSum) + System.lineSeparator());
						
						myWriter.close();
					}
					else {
						response.sendRedirect("products.jsp");
					}
					response.sendRedirect("basket.jsp");
				}
				else {
					JOptionPane optionPane = new JOptionPane("Error You are not Registered",JOptionPane.WARNING_MESSAGE);
					JDialog dialog = optionPane.createDialog("Username Error");
					dialog.setAlwaysOnTop(true); // to show top of all other application
					dialog.setVisible(true); // to visible the dialog
					//JOptionPane.showMessageDialog(null, "My Goodness, this is so concise");
					System.out.println("CHECKME");
					response.sendRedirect("login.jsp");
				}
				
		}
		else {
			String temp= (String)session.getAttribute("discountApplied");
			session.setAttribute("discountApplied", temp);
			//String temp1= (String) session.getAttribute("vat");
			//System.out.println(temp1);
			//session.setAttribute("vat", temp1);
			response.sendRedirect("basket.jsp");
		}
	}
}
