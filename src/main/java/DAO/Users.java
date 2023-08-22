package DAO;

import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import database.db;

public class Users {
	public boolean Register(Model.Users uModel) {
		boolean status = false;
		db Con = new db();

		String checkIfExistsSQL = "SELECT username_u FROM users WHERE username_u = ?";
		String insertSQL = "INSERT INTO users (username_u, email_u, password_u) VALUES (?, ?, ?)";

		try {
			PreparedStatement checkStmt = Con.getCon().prepareStatement(checkIfExistsSQL);
			checkStmt.setString(1, uModel.getUsername_u());
			ResultSet resultSet = checkStmt.executeQuery();

			if (!resultSet.next()) {
				PreparedStatement insertStmt = Con.getCon().prepareStatement(insertSQL);
				insertStmt.setString(1, uModel.getUsername_u());
				insertStmt.setString(2, uModel.getEmail_u());
				insertStmt.setString(3, uModel.getPassword_u());

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

	public Model.Users Login(String username, String password) {

		db Con = new db();

		String sql = "SELECT * FROM users WHERE username_u = ? AND password_u = ? LIMIT 1";

		try {
			PreparedStatement stmt = db.getCon().prepareStatement(sql);
			stmt.setString(1, username);
			stmt.setString(2, password);

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				int id = Integer.parseInt(rs.getString("id_u"));
				String username_u = rs.getString("username_u");
				String status_u = rs.getString("status_u");

				Model.Users usrmdl = new Model.Users(id, username_u, status_u);
				return usrmdl;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}
}
