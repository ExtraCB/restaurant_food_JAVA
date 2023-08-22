package Model;

import java.util.ArrayList;

public class Orders {
	private String id;
	private String own;
	private ArrayList<Menu> menus;
	
	
	
	
	
	public Orders(String id, String own, ArrayList<Menu> menus) {
		super();
		this.id = id;
		this.own = own;
		this.menus = menus;
	}
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOwn() {
		return own;
	}
	public void setOwn(String own) {
		this.own = own;
	}
	public ArrayList<Menu> getMenus() {
		return menus;
	}
	public void setMenus(ArrayList<Menu> menus) {
		this.menus = menus;
	}
	
	
	
}
