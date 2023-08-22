<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<html>
<head>
<title>Upload Image</title>
</head>
<body>

<form action="upload" method="post" enctype="multipart/form-data">
<input type="hidden" name="mode" value="createfood" />
<input type="file" name="file">
<input type="submit" value="Upload">
</form>


</body>
</html>