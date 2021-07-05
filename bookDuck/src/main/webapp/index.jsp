<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
    function submit()
    {
        document.getElementById("bookduck").click(); // Simulates button click
        document.submitForm.submit(); // Submits the form without the button
    }
</script>
<body onload="submit()">

	<p>북덕 BookDck 사이트에 접속중입니다</p>
	<form action="goHome.do"  id="submitForm">
		<input type="submit" id="bookduck"/>
	</form>
	
</body>
</html>