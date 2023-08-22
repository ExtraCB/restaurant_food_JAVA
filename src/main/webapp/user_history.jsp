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
<link rel="stylesheet" href="./style/food_card.css">

</head>

<body>
	<header>
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark p-3">
			<div class="container-fluid">
				<a class="navbar-brand" href="#">Navbar</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
					aria-controls="navbarNavDropdown" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class=" collapse navbar-collapse" id="navbarNavDropdown">
					<ul class="navbar-nav ms-auto ">
						<li class="nav-item"><a class="nav-link mx-2 active"
							aria-current="page" href="res_controller?mode=user_homepage">Home</a>
						</li>
						<li class="nav-item"><a class="nav-link mx-2"
							href="res_controller?mode=user_history">History</a></li>
						<li class="nav-item"><a class="nav-link mx-2"
							href="res_controller?mode=cart">Cart</a></li>
						<li class="nav-item dropdown"><a
							class="nav-link mx-2 dropdown-toggle" href="#"
							id="navbarDropdownMenuLink" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"> Settings </a>
							<ul class="dropdown-menu"
								aria-labelledby="navbarDropdownMenuLink">
								<li><a class="dropdown-item"
									href="res_controller?mode=logout">Logout</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
		</nav>

	</header>
	<main>
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
						<div class="accordion" id="accordionExample<%= ord.getId() %>">

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingOne">
									<button class="accordion-button" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseOne<%= ord.getId() %>"
										aria-expanded="true" aria-controls="collapseOne">
										<%="ออร์เดอร์รหัสที่ " + ord.getId()%>
									</button>
								</h2>
								<div id="collapseOne<%= ord.getId() %>" class="accordion-collapse collapse show"
									aria-labelledby="headingOne" data-bs-parent="#accordionExample<%= ord.getId() %>">
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
											<div class="col-10"></div>
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