package Model;

public class Cart {
	private Menu menus;
	private int count;
	private String id;
	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Cart(Menu menus, int count) {
		super();
		this.menus = menus;
		this.count = count;
	}
	
	public Cart(Menu menus, String id) {
		super();
		this.menus = menus;
		this.id = id;
	}
	
	public Menu getMenus() {
		return menus;
	}
	public void setMenus(Menu menus) {
		this.menus = menus;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
}
