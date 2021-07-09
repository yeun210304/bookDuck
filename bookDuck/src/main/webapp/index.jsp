<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<script type="text/javascript">
	function submit() {
		document.getElementById("bookduck").click(); // Simulates button click
		document.submitForm.submit(); // Submits the form without the button
	}
</script>
<style>
.container{
	margin-top: 19;
}
body{
	background-color: #FDF7DD;
}
</style>
<body onload="submit()" >
	<div class="container">
		<h3>북덕 BookDck 사이트에 접속중입니다     <div class="spinner-border text-primary"></div></h3>
		<br/><br/><br/>
		<form action="goHome.do"  id="submitForm">
			<input type="submit" id="bookduck" value="이동중입니다" class="btn btn-primary"/>
		</form>
	</div>
</body>
</html>