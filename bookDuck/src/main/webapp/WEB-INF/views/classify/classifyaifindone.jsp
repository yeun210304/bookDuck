<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>    
<% response.setContentType("text/html; charset=UTF-8"); %>      
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>
</head>
<body>

${aidto.recommend_no}
${aidto.recommend_id}
${aidto.recommend_age}
${aidto.recommend_genre}
${aidto.recommend_favor}
${aidto.recommend_date}



</body>
</html>