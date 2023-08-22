package contorller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import DAO.FoodsDAO;
import Model.Menu;

@WebServlet("/uploads")
@MultipartConfig

/**
 * Servlet implementation class upload
 */
public class upload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public upload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		
		
		String mode = req.getParameter("mode");
		HttpSession session = req.getSession();
		
		if(!mode.isEmpty() && mode != null) {
			
			System.out.println("Mode : " + mode);
			
			if(mode.equals("createfood")) {
				
				Part p = req.getPart("file");
				String fileName = p.getSubmittedFileName();
				String newFileName = UUID.randomUUID().toString()+"-"+fileName;
				String path = getServletContext().getRealPath("")+"uploads";
				File file = new File(path);
				
				String foodname = req.getParameter("foodname");
				Double foodprice = Double.parseDouble(req.getParameter("foodprice"));
				
				Menu mnu = new Menu(foodname,foodprice,newFileName);
				FoodsDAO fdao = new FoodsDAO();
				
				boolean status = fdao.create(mnu);
				
				if(status) {
					if (!file.exists()) {
					    file.mkdirs();
					}

					try {
						p.write(path + File.separator + newFileName);
					} catch (IOException e) {
					    System.out.println("Error uploading file: " + e);
					    res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					    return;
					}
					
					System.out.println("Path : " + path);
					System.out.println("Filename : " + newFileName);
					
					session.setAttribute("success", "เพิ่มเมนูสำเร็จ !");
					req.getRequestDispatcher("res_controller?mode=create_food").forward(req, res);
				}else {
					session.setAttribute("error", "เพิ่มเมนูไม่สำเร็จ !");
					req.getRequestDispatcher("res_controller?mode=create_food").forward(req, res);
				}
			}else if(mode.equals("edit_food")) {
				String id = req.getParameter("id");
				String imgold = req.getParameter("imgold");
				String foodname = req.getParameter("foodname");
				Double foodprice = Double.parseDouble(req.getParameter("foodprice"));
				
				
				Part p = req.getPart("file");
				String fileName = p.getSubmittedFileName();
				String newFileName = "";
				
				if (fileName != null && !fileName.isEmpty()) {
					newFileName = UUID.randomUUID().toString() + "-" + fileName;
				    String path = getServletContext().getRealPath("") + "uploads";
				    File file = new File(path);
				    
				    if (!file.exists()) {
					    file.mkdirs();
					}

					try {
						p.write(path + File.separator + newFileName);
					} catch (IOException e) {
					    System.out.println("Error uploading file: " + e);
					    res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					    return;
					}
					
				} else {
				    newFileName = imgold;
				}
				
				
				Menu mnu = new Menu(Integer.parseInt(id),foodname,foodprice,newFileName);
				FoodsDAO fdao = new FoodsDAO();
				
				
				boolean status = fdao.Edit(mnu);
				
				if(status) {
					session.setAttribute("success", "แก้ไขเมนูสำเร็จ !");
					req.getRequestDispatcher("res_controller?mode=edit_food").forward(req, res);
				}else {
					session.setAttribute("success", "แก้ไขเมนูไม่สำเร็จ !");
					req.getRequestDispatcher("res_controller?mode=edit_food").forward(req, res);
				}
				
			}
		}else {
			res.sendRedirect("admin_homepage.jsp");
		}
		
		
		
		
		
		
		
	}

}
