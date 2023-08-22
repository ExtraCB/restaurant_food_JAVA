package Model;

public class Menu {
	private int id;
	private String name;
	private double price;
	private String img;
	private String count;
	
	
	
	
	
	public String getCount() {
		return count;
	}


	public void setCount(String count) {
		this.count = count;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public Menu(int id, String name, double price, String img) {
		super();
		this.id = id;
		this.name = name;
		this.price = price;
		this.img = img;
	}


	public Menu(String name, double price, String img) {
		super();
		this.name = name;
		this.price = price;
		this.img = img;
	}
	
	public Menu(int id) {
		this.id = id;
	}
	
	public Menu(int id,String name,double price,String img,String count) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.img = img;
		this.count = count;
	}
	
	public Menu(int id,String count) {
		this.id = id;
		this.count = count;
	}
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	
	
	
	
	
}
