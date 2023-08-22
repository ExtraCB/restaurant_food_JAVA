<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
<link rel="stylesheet" href="./style/login_register.css">

</head>

<body>
	<div class="container-wrapper">
		<div class="container">
			<div class="row">
				<div class="col-2"></div>
				<div class="col-8">
					<div class="fading-box">
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


						<div class="card shadow" style="border-radius: 8px;">
							<div class="row">

								<div class="col-8">
									<form action="res_controller" method="post">
										<div class="form-container m-4">

											<h3 class="text-center mb-4 fw-bold">Login Page</h3>
											<input type="text" placeholder="Username" name="username"
												class="form-control mb-3 shadow-sm"
												style="border-radius: 28px" id="">

											<hr>
											<input type="text" placeholder="Password" name="password"
												class="form-control mb-3 shadow-sm"
												style="border-radius: 20px" id="">
											<div class="row">
												<div class="col">
													<button class="btn btn-outline-primary" type="submit"
														name="mode" value="login_submit" style="border-radius: 20px">เข้าสู่ระบบ</button>
												</div>
												<div class="col mt-auto text-center">
													<a href="res_controller?mode=register" class="link-primary">ยังไม่มีบัญชีผู้ใช้งาน</a>
												</div>
											</div>
										</div>
									</form>

								</div>
								<div class="col-4">
									<img src="./style/image/food2.jpg"
										class="img-fluid h-100 w-100" alt="..."
										style="border-radius: 8px;">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
	</div>
</body>

</html>