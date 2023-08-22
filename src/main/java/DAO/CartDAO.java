package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Model.Cart;
import Model.Menu;
import database.db;

public class CartDAO {

	public boolean addToCart(Menu menu, String own, String quan) {
		boolean status = false;

		db con = new db();

		String sql = "INSERT INTO restaurant_cart (id_own,id_f,c_count) SELECT ?,?,? WHERE NOT EXISTS (SELECT id_f FROM restaurant_cart WHERE id_own = ? AND id_f = ?)";

		try {
			PreparedStatement stmt = db.getCon().prepareStatement(sql);
			stmt.setString(1, own);
			stmt.setString(2, String.valueOf(menu.getId()));
			stmt.setString(3, quan);
			stmt.setString(4, own);
			stmt.setString(5, String.valueOf(menu.getId()));

			int rowsInserted = stmt.executeUpdate();

			if (rowsInserted > 0) {
				status = true;
			} else {
				status = false;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return status;
	}

	public ArrayList<Cart> GetAllMenu(String own) {
		ArrayList<Cart> cart_list = new ArrayList<>();

		db db = new db();

		String sql = "SELECT id_c,id_m,price_m,name_m,img_m,c_count FROM restaurant_cart INNER JOIN restaurant_menu ON id_f = id_m WHERE id_own = ?";

		try {
			PreparedStatement stmt = db.getCon().prepareStatement(sql);
			stmt.setString(1, own);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Menu mnu = new Menu(Integer.parseInt(rs.getString("id_m")), rs.getString("name_m"),
						Double.parseDouble(rs.getString("price_m")), rs.getString("img_m"), rs.getString("c_count"));
				Cart cart = new Cart(mnu, rs.getString("id_c"));

				cart_list.add(cart);
			}

			return cart_list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return cart_list;
	}

	public boolean DeleteItem(String id) {
		boolean status = false;

		db db = new db();

		String sql = "DELETE FROM restaurant_cart WHERE id_c = ?";

		try {
			PreparedStatement stmt = db.getCon().prepareStatement(sql);
			stmt.setString(1, id);

			int rowsInserted = stmt.executeUpdate();

			if (rowsInserted > 0) {
				status = true;

			} else {
				status = false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return status;
	}
	
	public boolean PlusItem(String id) {
		boolean status = false;

		db db = new db();

		String sql = "UPDATE restaurant_cart SET c_count = c_count + 1 WHERE id_c = ?";

		try {
			PreparedStatement stmt = db.getCon().prepareStatement(sql);
			stmt.setString(1, id);

			int rowsInserted = stmt.executeUpdate();

			if (rowsInserted > 0) {
				status = true;

			} else {
				status = false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return status;
	}
	
	public boolean DelItem(String id) {
		boolean status = false;

		db db = new db();

		String sql = "UPDATE restaurant_cart SET c_count = c_count - 1 WHERE id_c = ?";

		try {
			PreparedStatement stmt = db.getCon().prepareStatement(sql);
			stmt.setString(1, id);

			int rowsInserted = stmt.executeUpdate();

			if (rowsInserted > 0) {
				status = true;

			} else {
				status = false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return status;
	}
}
