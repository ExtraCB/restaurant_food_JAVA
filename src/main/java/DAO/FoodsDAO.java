package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Model.Menu;
import database.db;

public class FoodsDAO {
	
	public boolean create(Menu food) {
		boolean status = false;
		db Con = new db();

		String checkIfExistsSQL = "SELECT name_m FROM restaurant_menu WHERE name_m = ?";
		String insertSQL = "INSERT INTO restaurant_menu (name_m, img_m, price_m) VALUES (?, ?, ?)";

		try {
			PreparedStatement checkStmt = Con.getCon().prepareStatement(checkIfExistsSQL);
			checkStmt.setString(1, food.getName());
			ResultSet resultSet = checkStmt.executeQuery();

			if (!resultSet.next()) {
				PreparedStatement insertStmt = Con.getCon().prepareStatement(insertSQL);
				insertStmt.setString(1, food.getName());
				insertStmt.setString(2, food.getImg());
				insertStmt.setString(3, String.valueOf(food.getPrice()));

				int rowsInserted = insertStmt.executeUpdate();

				if (rowsInserted > 0) {
					status = true;
				}
			} else {
				status = false;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return status;
	}
	
	
	public ArrayList<Menu>  findAll(){
		ArrayList<Menu> menus = new ArrayList<Menu>();
		
		db Con = new db();
		
		String sql = "SELECT * FROM restaurant_menu";
		
		
		
		try {
			PreparedStatement stmt = db.getCon().prepareStatement(sql);
			ResultSet rs =  stmt.executeQuery();
			
			while(rs.next()) {
				Menu mns = new Menu(Integer.parseInt(rs.getString("id_m")),rs.getString("name_m"),Double.parseDouble(rs.getString("price_m")),rs.getString("img_m"));
				
				menus.add(mns);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return menus;
		
	}
	
	public boolean Edit(Menu food) {
		boolean status = false;
		db Con = new db();

		String updateSql = "UPDATE  restaurant_menu SET name_m = ? , price_m  = ? ,img_m = ? WHERE id_m = ?";

		try {
			PreparedStatement checkStmt = Con.getCon().prepareStatement(updateSql);
			checkStmt.setString(1, food.getName());
			checkStmt.setString(2, String.valueOf(food.getPrice()));
			checkStmt.setString(3, food.getImg());
			checkStmt.setString(4, String.valueOf(food.getId()));
			
			
			int resultSet = checkStmt.executeUpdate();

			if(resultSet > 0) {
				status = true;
			}else {
				status = false;
				
			}
			
			return status;
			

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return status;
	}
	
	
	
}
