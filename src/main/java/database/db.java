package database;
import java.sql.*;


public class db {
	private static Connection con;
	
	public db() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String dbURL = "jdbc:mysql://localhost/restaurant_db?characterEncoding=utf-8";
			
				con = DriverManager.getConnection(dbURL,"root","");
				System.out.println("Connect DB ok");
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static Connection getCon() {
		return con;
	}

	public static void setCon(Connection con) {
		db.con = con;
	}
	
	public void closeConnect() {
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
}
