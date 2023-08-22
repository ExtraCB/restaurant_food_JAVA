<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@page import="java.util.ArrayList"%>
<%@page import="Model.Menu"%>

<%
String success = (String) session.getAttribute("success");
String error = (String) session.getAttribute("error");
%>


<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login Page</title>
<link rel="stylesheet"
	href="webjars/bootstrap/5.3.0/css/bootstrap.min.css">
<script src="webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./style/standard.css">
<link rel="stylesheet" href="./style/admin.css">

</head>

<body>
	<header>
		<!-- Sidebar -->
		<nav id="sidebarMenu"
			class="collapse d-lg-block sidebar collapse bg-white">
			<div class="position-sticky">
				<div class="list-group list-group-flush mx-3 mt-4">
					<a href="res_controller?mode=admin_homepage"
						class="list-group-item list-group-item-action py-2 ripple "
						aria-current="true"> <i
						class="fas fa-tachometer-alt fa-fw me-3"></i><span>หน้าหลัก</span>
					</a> <a href="res_controller?mode=create_food"
						class="list-group-item list-group-item-action py-2 ripple "> <i
						class="fas fa-chart-area fa-fw me-3"></i><span>เพิ่มเมนูอาหาร</span>
					</a> <a href="res_controller?mode=edit_food"
						class="list-group-item list-group-item-action py-2 ripple active "><i
						class="fas fa-lock fa-fw me-3"></i><span>จัดการเมนูอาหาร</span></a> <a
						href="res_controller?mode=admin_history"
						class="list-group-item list-group-item-action py-2 ripple"><i
						class="fas fa-chart-line fa-fw me-3"></i><span>ประวัติการสั่งซื้อทั้งหมด</span></a>
				</div>
			</div>
		</nav>
		<!-- Sidebar -->

		<!-- Navbar -->
		<nav id="main-navbar"
			class="navbar navbar-expand-lg navbar-light bg-white fixed-top shadow">
			<!-- Container wrapper -->
			<div class="container-fluid">
				<!-- Toggle button -->
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#sidebarMenu"
					aria-controls="sidebarMenu" aria-expanded="false"
					aria-label="Toggle navigation">
					<i class="fas fa-bars"></i>
				</button>

				<!-- Brand -->
				<a class="navbar-brand" href="#"> <img
					src="./style/image/logo.png" height="25" alt="MDB Logo"
					loading="lazy" /> Restaurant
				</a>

				<!-- Right links -->
				<ul class="navbar-nav ms-auto d-flex flex-row">
					<!-- Notification dropdown -->

					<!-- Avatar -->
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle hidden-arrow d-flex align-items-center"
						href="#" id="navbarDropdownMenuLink" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> Settings </a>
						<ul class="dropdown-menu dropdown-menu-end"
							aria-labelledby="navbarDropdownMenuLink">
							<li><a class="dropdown-item" href="#">My profile</a></li>
							<li><a class="dropdown-item"
								href="res_controller?mode=logout">Logout</a></li>
						</ul></li>
				</ul>
			</div>
			<!-- Container wrapper -->
		</nav>
		<!-- Navbar -->
	</header>
	<main style="margin-top: 58px;">
		<div class="container pt-4">
			<h3>จัดการอาหาร</h3>
			<div class="row">
				<div class="col-3"></div>
				<div class="col-6">
					<%
					if (success != null && !success.isEmpty()) {
					%>
					<div class="alert alert-success alert-dismissible fade show"
						role="alert">
						<strong><%=success%> <%
 session.removeAttribute("success");
 %></strong>
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
					<%
					} else if (error != null && !error.isEmpty()) {
					%>
					<div class="alert alert-danger alert-dismissible fade show"
						role="alert">
						<strong><%=error%> <%
 session.removeAttribute("error");
 %></strong>
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
					<%
					}
					%>
					<div class="row">
						<%
						ArrayList<Menu> menu_array = (ArrayList<Menu>) request.getAttribute("menu_array");
						for (Menu menus : menu_array) {
						%>
						<div class="col">
							<div class="card" style="width: 18rem;">
								<img src="uploads/<%=menus.getImg()%>" class="img-fluid card-img-top"
									alt="..." style=" max-height:170px; object-fit: cover;" >
								<div class="card-body">
									<h5 class="card-title">
										<%=menus.getName()%>
									</h5>
									<p class="card-text">
										ราคา :
										<%=menus.getPrice()%></p>
									<button type="button" class="btn btn-primary"
										data-bs-toggle="modal"
										data-bs-target="#exampleModal<%=menus.getId()%>">
										แก้ไข</button>

									<!-- Modal -->
									<div class="modal fade static"
										id="exampleModal<%=menus.getId()%>" tabindex="-1"
										aria-labelledby="exampleModalLabel" aria-hidden="true">
										<div class="modal-dialog">
											<form action="upload" method="post"
												enctype="multipart/form-data">
												<div class="modal-content">
													<div class="modal-header">
														<h1 class="modal-title fs-5" id="exampleModalLabel">จัดการ</h1>
														<button type="button" class="btn-close"
															data-bs-dismiss="modal" aria-label="Close"></button>
													</div>
													<div class="modal-body">

														<input type="text" name="foodname"
															class="form-control mb-3" placeholder="ชื่อเมนู" id=""
															value="<%=menus.getName()%>" required /> <input
															type="hidden" name="id" value="<%=menus.getId()%>" />
														<input type="hidden" name="imgold"
															value="<%=menus.getImg()%>" /> <input type="text"
															name="foodprice" value="<%=menus.getPrice()%>"
															class="form-control mb-3" placeholder="ราคาเมนูอาหาร"
															id="" required /> <input type="file" id="img_upload"
															name="file" onchange="PreviewImage()"
															class="form-control mb-3" id="" /> <input type="hidden"
															name="mode" value="edit_food" />

													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-secondary"
															data-bs-dismiss="modal">Close</button>
														<button type="submit" class="btn btn-primary">Save
															changes</button>
													</div>
												</div>
											</form>
										</div>
									</div>

									<button class="btn btn-danger" onClick=""> ลบ </a>
								</div>
							</div>
						</div>
						<%
						}
						%>
					</div>
				</div>
				<div class="col-3"></div>
			</div>


			<script type="text/javascript">
				function PreviewImage() {
					var oFReader = new FileReader();

					oFReader.readAsDataURL(document
							.getElementById("img_upload").files[0]);
					oFReader.onload = function(event) {
						document.getElementById("previewImg").src = event.target.result;
					}
				}
			</script>
		</div>
	</main>
</body>

</html>