package contorller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import DAO.CartDAO;
import DAO.FoodsDAO;
import DAO.OrderDAO;
import Model.Cart;
import Model.Menu;
import Model.Orders;
import Model.Users;

/**
 * Servlet implementation class res_controller
 */
public class res_controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public res_controller() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();

		if (request.getParameter("mode") != null) {
			String mode = request.getParameter("mode");

			System.out.println("Mode: " + mode);
			if (mode.equals("register")) {
				request.getRequestDispatcher("register.jsp").forward(request, response);
			} else if (mode.equals("register_submit")) {
				String username = request.getParameter("username");
				String password = request.getParameter("password");
				String email = request.getParameter("email");

				Users usrs = new Users(username, email, password);

				DAO.Users usrdao = new DAO.Users();

				boolean status = usrdao.Register(usrs);

				if (status) {
					session.setAttribute("success", "สมัครสมาชิกสำเร็จ !");
					request.getRequestDispatcher("index.jsp").forward(request, response);
				} else {
					session.setAttribute("error", "ชื่อผู้ใช้งานมีอยู่ในระบบแล้ว !");
					request.getRequestDispatcher("register.jsp").forward(request, response);
				}
			} else if (mode.equals("login")) {
				request.getRequestDispatcher("index.jsp").forward(request, response);
			} else if (mode.equals("login_submit")) {
				String username = request.getParameter("username");
				String password = request.getParameter("password");

				DAO.Users usrdao = new DAO.Users();

				Model.Users usrmdl = usrdao.Login(username, password);

				if (usrmdl != null) {
					session.setAttribute("userid", String.valueOf(usrmdl.getId_u()));
					if (usrmdl.getStatus_u().equals("admin")) {
						request.getRequestDispatcher("admin_homepage.jsp").forward(request, response);
					} else {
						request.getRequestDispatcher("res_controller?mode=user_homepage").forward(request, response);
					}
				} else {
					session.setAttribute("error", "ชื่อผู้ใช้งานหรือรหัสผ่านผิด !");
					request.getRequestDispatcher("index.jsp").forward(request, response);
				}
			} else if (mode.equals("logout")) {
				session.invalidate();
				request.getRequestDispatcher("index.jsp").forward(request, response);
			} else if (mode.equals("admin_homepage")) {
				request.getRequestDispatcher("admin_homepage.jsp").forward(request, response);
			} else if (mode.equals("create_food")) {
				request.getRequestDispatcher("admin_createfood.jsp").forward(request, response);
			} else if (mode.equals("edit_food")) {
				FoodsDAO fdao = new FoodsDAO();

				ArrayList<Menu> menus = fdao.findAll();
				request.setAttribute("menu_array", menus);
				request.getRequestDispatcher("admin_editfood.jsp").forward(request, response);
			} else if (mode.equals("user_homepage")) {
				FoodsDAO fdao = new FoodsDAO();

				ArrayList<Menu> menus = fdao.findAll();
				request.setAttribute("menu_array", menus);
				request.getRequestDispatcher("user_homepage.jsp").forward(request, response);
			} else if (mode.equals("add_to_cart")) {
				CartDAO cdao = new CartDAO();

				String id = request.getParameter("id");
				String quan = request.getParameter("quan");

				String own = request.getParameter("own");

				Menu menus = new Menu(Integer.parseInt(id));

				boolean status = cdao.addToCart(menus, own, quan);

				if (status) {
					session.setAttribute("success", "เพิ่มเข้าตระกร้าสินค้าสำเร็จ !");
					request.getRequestDispatcher("res_controller?mode=user_homepage").forward(request, response);
				} else {
					session.setAttribute("error", "อาจจะมีสินค้าอยู่ในตระกร้าแล้ว !");
					request.getRequestDispatcher("res_controller?mode=user_homepage").forward(request, response);
				}
			} else if (mode.equals("cart")) {
				CartDAO cdao = new CartDAO();
//			    String own = (String) ;

				String userid = String.valueOf(session.getAttribute("userid"));

				ArrayList<Cart> cart_array = cdao.GetAllMenu(userid);

				request.setAttribute("cart_array", cart_array);

				request.getRequestDispatcher("user_cart.jsp").forward(request, response);
			} else if (mode.equals("admin_history")) {
				OrderDAO odao = new OrderDAO();

				ArrayList<Orders> order_array = odao.findAll();

				request.setAttribute("order_array", order_array);
				request.getRequestDispatcher("admin_history.jsp").forward(request, response);
			} else if (mode.equals("plusCart")) {
				CartDAO cdao = new CartDAO();

				String id = request.getParameter("idc");

				boolean status = cdao.PlusItem(id);

				if (status) {
					session.setAttribute("success", "เพิ่มจำนวนสินค้าสำเร็จ !");
					request.getRequestDispatcher("res_controller?mode=cart").forward(request, response);
				} else {
					session.setAttribute("error", "เพิ่มจำนวนไม่สินค้าสำเร็จ !");
					request.getRequestDispatcher("res_controller?mode=cart").forward(request, response);
				}
			} else if (mode.equals("delCart")) {
				CartDAO cdao = new CartDAO();

				String id = request.getParameter("idc");

				boolean status = cdao.DelItem(id);

				if (status) {
					session.setAttribute("success", "ลดจำนวนสินค้าสำเร็จ !");
					request.getRequestDispatcher("res_controller?mode=cart").forward(request, response);
				} else {
					session.setAttribute("error", "ลดจำนวนไม่สินค้าสำเร็จ !");
					request.getRequestDispatcher("res_controller?mode=cart").forward(request, response);
				}
			}else if(mode.equals("submit_pay")) {
				String userid = String.valueOf(session.getAttribute("userid"));
				
				OrderDAO odao = new OrderDAO();
				
				boolean status = odao.SubmitOrder(userid);
				

				if (status) {
					session.setAttribute("success", "สั่งซื้อสำเร็จ !");
					request.getRequestDispatcher("res_controller?mode=user_homepage").forward(request, response);
				} else {
					session.setAttribute("error", "สั่งซื้อไม่สำเร็จ !");
					request.getRequestDispatcher("res_controller?mode=user_homepage").forward(request, response);
				}
			}else if(mode.equals("user_history")) {
				String userid = String.valueOf(session.getAttribute("userid"));
				
				OrderDAO odao = new OrderDAO();
				
				ArrayList<Orders> order_array = odao.findMe(userid);
				
				request.setAttribute("order_array", order_array);
				
				request.getRequestDispatcher("user_history.jsp").forward(request, response);
				
			}
		} else {
//			request.getRequestDispatcher("index.jsp").forward(request, response);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);

	}

}
