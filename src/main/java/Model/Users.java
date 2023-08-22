package Model;

public class Users {
	private int id_u;
	private String username_u;
	private String email_u;
	private String password_u;
	private String status_u;
	
	
	
	public Users(String username_u, String email_u, String password_u) {
		super();
		this.username_u = username_u;
		this.email_u = email_u;
		this.password_u = password_u;
	}
	
	public Users(int id,String username_u, String email_u, String password_u) {
		super();
		this.id_u = id;
		this.username_u = username_u;
		this.email_u = email_u;
		this.password_u = password_u;
	}
	
	public Users(int id,String username_u,String status) {
		super();
		this.id_u = id;
		this.username_u = username_u;
		this.status_u = status;
	}
	
	public String getStatus_u() {
		return status_u;
	}

	public void setStatus_u(String status_u) {
		this.status_u = status_u;
	}

	public int getId_u() {
		return id_u;
	}
	public void setId_u(int id_u) {
		this.id_u = id_u;
	}
	public String getUsername_u() {
		return username_u;
	}
	public void setUsername_u(String username_u) {
		this.username_u = username_u;
	}
	public String getEmail_u() {
		return email_u;
	}
	public void setEmail_u(String email_u) {
		this.email_u = email_u;
	}
	public String getPassword_u() {
		return password_u;
	}
	public void setPassword_u(String password_u) {
		this.password_u = password_u;
	}
	
	
	
}
