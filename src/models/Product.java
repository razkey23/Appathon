package models;

public class Product {
	protected String id;
	protected String name;
	protected String image;
	protected String price;
	
	public Product() {
	}
	
	public Product(String id ,String name,String image,String price) { //Constructor
		super();
		this.id=id;
		this.image=image;
		this.price=price;
		this.name=name;
	}
	//GETTERS 
	public String getId() {
		return id;
	}
	public String getImage() {
		return image;
	}
	public String getName() {
		return name;
	}
	public String getPrice() {
		return price;
	}
	//SETTERS
	public void setId(String id) {
		this.id=id;
	}
	public void setImage(String image) {
		this.image=image;
	}
	public void setName(String name) {
		this.name=name;
	}
	public void setPrice(String price) {
		this.price=price;
	}
}
	
	
