<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>책추천</title>
<style type="text/css">

</style>
<script type="text/javascript">

</script>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
//절대경로 확인
String path = request.getContextPath();

String coverLargeUrl = request.getParameter("coverLargeUrl");
String title = request.getParameter("title");
String isbn = request.getParameter("isbn");
String author = request.getParameter("author");

%>    
	<div id="book">
		<b>책정보</b><br/>
		<img src="<%=coverLargeUrl %>"><br/>
		<%=title %>&nbsp;<%=author %><br/>
		<%=isbn %>
	</div><br/>
	
	<div id="star">
		<b>별점</b>

	</div><br/>
	
	<div id="tts">
		<b>한줄낭독</b>
	</div>

</body>
</html>