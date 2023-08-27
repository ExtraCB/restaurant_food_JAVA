<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList"%>
<%@page import="Model.Cart"%>
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
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="container mt-5 p-3 rounded cart">
						<div class="row no-gutters text-center">
							<div class="col-md-12">
								<div class="card">
									<div class="card-body">
										<form action="./service/cart.php" method="post">
											<div class="product-details mr-2">
												<h6 class="mb-0">Shopping cart</h6>


												<div class="d-flex justify-content-between">
													<span>สินค้าในตระกร้าทั้งหมด</span>
													<hr />
													<div class="d-flex flex-row align-items-center">
														<span class="text-black-50">Sort by:</span>
														<div class="price ml-2">
															<span class="mr-1">price</span><i
																class="fa fa-angle-down"></i>
														</div>
													</div>
												</div>
												<%
												ArrayList<Cart> cart_array = (ArrayList<Cart>) request.getAttribute("cart_array");

												for (Cart mnu : cart_array) {
												%>


												<div class="row">
													<div class="col-1">
														<img class="rounded"
															src="uploads/<%=mnu.getMenus().getImg()%>"
															width="50px; object-fit:cover;">
													</div>
													<div class="col-1">
														<div class="ml-2">
															<span class="font-weight-bold d-block"><%=mnu.getMenus().getName()%></span>
															<span class="spec"> <%=mnu.getMenus().getPrice()%></span>
														</div>
													</div>
													<div class="col-7"></div>
													<div class="col-2">
														<div class="input-group">
															<%
															if (Integer.parseInt(mnu.getMenus().getCount()) > 1) {
															%>
															<a
																href="res_controller?mode=delCart&idc=<%=mnu.getId()%>"
																class="nav-link"><button type="button"
																	class="btn btn-outline-primary">-</button></a>
															<%
															}
															%>
															<input type="text"
																value="<%=mnu.getMenus().getCount()%>"
																class="form-control input-sm" disabled> <a
																href="res_controller?mode=plusCart&idc=<%=mnu.getId()%>"
																class="nav-link"><button type="button"
																	class="btn btn-outline-primary">+</button></a>
														</div>
														<a href="res_controller?mode=DeleteItemInCart&idc=<%= mnu.getId() %>" class="btn btn-danger">Delete</a>
													</div>
													<div class="col-1">
														<span class=""><%=Integer.parseInt(mnu.getMenus().getCount()) * mnu.getMenus().getPrice()%></span>
													</div>
												</div>
												<div
													class="d-flex justify-content-between align-items-center mt-3 p-2 items rounded">
													<div class="d-flex flex-row"></div>
													<div class="d-flex flex-row align-items-center"></div>
												</div>
												<%
												}
												%>

											</div>

											<a href="res_controller?mode=submit_pay"><button type="button" class="btn btn-outline-success">Pay</button></a>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
</body>

</html>