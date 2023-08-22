<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@page import="java.util.ArrayList"%>
<%@page import="Model.Orders"%>
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
						class="list-group-item list-group-item-action py-2 ripple  "><i
						class="fas fa-lock fa-fw me-3"></i><span>จัดการเมนูอาหาร</span></a> <a
						href="res_controller?mode=admin_history"
						class="list-group-item list-group-item-action py-2 ripple active"><i
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
			<h3>ประวัติการสั่งซื้อทั้งหมดในระบบ</h3>
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
				</div>
				<div class="row">
					<div class="col-2"></div>
					<div class="col-8">
						<%
							ArrayList<Orders> order_array = (ArrayList<Orders>) request.getAttribute("order_array");
							for (Orders ord : order_array) {
							%>
						<div class="accordion" id="accordionExample<%=ord.getId()%>">
							
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingOne">
									<button class="accordion-button" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseOne<%=ord.getId()%>"
										aria-expanded="true" aria-controls="collapseOne">
										<%="ออร์เดอร์รหัสที่ " + ord.getId()%>
									</button>
								</h2>
								<div id="collapseOne<%=ord.getId()%>" class="accordion-collapse collapse show"
									aria-labelledby="headingOne" data-bs-parent="#accordionExample<%=ord.getId()%>">
									<div class="accordion-body">
										<%
										Double pricesum = 0.0;

										for (Menu mnu : ord.getMenus()) {

											int count = Integer.parseInt(mnu.getCount());
											double price = mnu.getPrice();
											double totalPrice = count * price;

											pricesum += totalPrice;
										%>
										<div
											class="d-flex justify-content-between align-items-center mt-3 p-2 items rounded">
											<div class="d-flex flex-row">
												<img class="rounded m-3" src="uploads/<%=mnu.getImg()%>"
													width="40">
												<div class="ml-2">
													<span class="font-weight-bold d-block"><%=mnu.getName()%></span><span
														class="spec"><%="Per Unit  : " + price%></span>
												</div>
											</div>
											<div class="d-flex flex-row align-items-center">
												<span class="d-block"><%=count%> : </span><span
													class="d-block ml-5 font-weight-bold"> <%=totalPrice%></span><i
													class="fa fa-trash-o ml-3 text-black-50"></i>
											</div>
										</div>
										<%
										}
										%>
										<div class="row">
											<div class="col-10">
											</div>
											<div class="col-2 text-end">
												<h5>
													รวม :
													<%=pricesum%></h5>
											</div>
										</div>
									</div>
								</div>
							</div>
							
						</div>
						<%
							}
							%>
					</div>
					<div class="col-2"></div>
				</div>
			</div>
		</div>
		<div class="col-3"></div>
		</div>
	</main>
</body>

</html>