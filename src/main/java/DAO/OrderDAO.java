package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.UUID;

import Model.Menu;
import Model.Orders;
import database.db;

public class OrderDAO {

	public ArrayList<Orders> findAll() {
	    ArrayList<Orders> orderList = new ArrayList<>();

	    db db = new db();
	    String SQL = "SELECT * FROM restaurant_order ";
	    String SQL2 = "SELECT count_d,id_m,name_m,price_m,img_m FROM restaurant_detail INNSER JOIN restaurant_menu ON id_f = id_m WHERE id_o = ?";
	    try {
	        PreparedStatement stmt = db.getCon().prepareStatement(SQL);
	        ResultSet rs1 = stmt.executeQuery();

	        while (rs1.next()) {
	            ArrayList<Menu> menus = new ArrayList<>(); // เคลียร์รายการสินค้าสำหรับแต่ละคำสั่งซื้อใหม่
	            System.out.println("ID order : " + rs1.getString("id_o"));
	            PreparedStatement stmt2 = db.getCon().prepareStatement(SQL2);
	            stmt2.setString(1, rs1.getString("id_o"));

	            ResultSet rs2 = stmt2.executeQuery();
	            while (rs2.next()) {
	                Menu mnu = new Menu(Integer.parseInt(rs2.getString("id_m")), rs2.getString("name_m"),
	                        Double.parseDouble(rs2.getString("price_m")), rs2.getString("img_m"), rs2.getString("count_d"));

	                menus.add(mnu);
	            }
	            Orders ord = new Orders(rs1.getString("id_o"), rs1.getString("id_own"), menus);

	            orderList.add(ord);
	        }

	        return orderList;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return orderList;
	}

	
	public ArrayList<Orders> findMe(String own) {
		ArrayList<Orders> orderList = new ArrayList<>();

		db db = new db();
		String SQL = "SELECT * FROM restaurant_order WHERE id_own = ?";
		String SQL2 = "SELECT count_d,id_m,name_m,price_m,img_m FROM restaurant_detail INNSER JOIN restaurant_menu ON id_f = id_m WHERE id_o = ?";
		try {
			PreparedStatement stmt = db.getCon().prepareStatement(SQL);
			
			stmt.setString(1, own);
			ResultSet rs1 = stmt.executeQuery();

			
			while (rs1.next()) {
				ArrayList<Menu> menus = new ArrayList<>();
				System.out.println("ID order : " + rs1.getString("id_o"));
				PreparedStatement stmt2 = db.getCon().prepareStatement(SQL2);
				stmt2.setString(1, rs1.getString("id_o"));

				ResultSet rs2 = stmt2.executeQuery();
				while (rs2.next()) {
					Menu mnu = new Menu(Integer.parseInt(rs2.getString("id_m")), rs2.getString("name_m"),
							Double.parseDouble(rs2.getString("price_m")), rs2.getString("img_m"),rs2.getString("count_d"));

					menus.add(mnu);
				}
				Orders ord = new Orders(rs1.getString("id_o"), rs1.getString("id_own"), menus);
				
				orderList.add(ord);
			}
			
			return orderList;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return orderList;
	}
	
	
	public boolean SubmitOrder(String own) {
		boolean status = false;
		db db = new db();
		
		
		
		
		String selectF = "SELECT * FROM restaurant_cart WHERE id_own = ?";
		String InsertOrder = "INSERT INTO restaurant_order (`id_o`, `id_own`) VALUES (?,?)";
		String InsertDetail = "INSERT INTO `restaurant_detail`(`id_o`, `id_f`, `count_d`) VALUES (?,?,?)";
		
		String DeleteCart = "DELETE FROM restaurant_cart WHERE id_own = ?";
		
		String idGen = UUID.randomUUID().toString();
		
		
		try {
			PreparedStatement stmt = db.getCon().prepareStatement(selectF);
			stmt.setString(1, own);
			
			PreparedStatement stmt2 = db.getCon().prepareStatement(InsertOrder);
			stmt2.setString(1, idGen);
			stmt2.setString(2, own);
			
			PreparedStatement delstmt = db.getCon().prepareStatement(selectF);
			stmt.setString(1, own);
			
			int insertRow = stmt2.executeUpdate();
			
			if(insertRow > 0) {
				
				ResultSet rs1 = stmt.executeQuery();
				while(rs1.next()) {
					PreparedStatement stmt3 = db.getCon().prepareStatement(InsertDetail);
					stmt3.setString(1, idGen);
					stmt3.setString(2, rs1.getString("id_f"));
					stmt3.setString(3, rs1.getString("c_count"));
					
					int insertRow3 = stmt3.executeUpdate();
					
					if(insertRow3 > 0) {
						status = true;
					}else {
						status = false;
						break;
					}
				}
				
				if(status) {
					delstmt.setString(1, own);
					delstmt.executeUpdate();
					
					return status;
				}else {
					status = false;
				}

			}else {
				return false;
			}
			
			
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return status;
	}
}
