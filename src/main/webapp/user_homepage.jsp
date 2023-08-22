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
		<div class="container">
			<div class="row">
				<div class="col-12">
					<h3>เมนูอาหารทั้งหมด</h3>
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
					
					<div class="row text-center">
						<%
						ArrayList<Menu> menu_array = (ArrayList<Menu>) request.getAttribute("menu_array");
						for (Menu menu : menu_array) {
						%>
						
							<div class="col-xl-3 col-sm-6 mb-5">
							<form action="res_controller" method="post">
								<div class="bg-white rounded shadow-sm py-5 px-4"
									style="height: 275px;">
									<img src="uploads/<%=menu.getImg()%>" alt="" width="100"  class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm" style="height:100px; object-fit:cover">
									<h5 class="mb-0"><%=menu.getName()%></h5>
									<span class="small text-uppercase text-muted">ราคา : <%=menu.getPrice()%>
										<div class="input-group">
											<input type="number" class="form-control" id="quan" min="1"
												value="1" name="quan" id="">
												<input type="hidden" name="id" value="<%= menu.getId() %>" />
												<input type="hidden" name="own" value="<%= session.getAttribute("userid") %>" />
												
											<button class="btn btn-outline-secondary" type="submit" name="mode" value="add_to_cart">เพิ่ม</button>
										</div>
								</div>
								</form>
							</div>
						
						<%
						}
						%>
					</div>
					
				</div>
			</div>
		</div>
	</main>
</body>

</html>