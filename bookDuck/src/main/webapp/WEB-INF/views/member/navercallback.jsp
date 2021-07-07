<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
	<script type="text/javascript">
	  var naver_id_login = new naver_id_login("Hft3mSmHcCpHqnsB7j3E", "http://localhost:8787/bookduck/navercallback.jsp");
	  
	  // 접근 토큰 값 출력
	  const token = naver_id_login.oauthParams.access_token;
	  alert(token);
	  // 네이버 사용자 프로필 조회
	  naver_id_login.get_naver_userprofile("naverSignInCallback()");
	  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	  function naverSignInCallback() {
		const member_email = naver_id_login.getProfileData('email');
	    alert(member_email);
	    console.log("console.log:"+member_email+token)
	    
	    window.opener.location.href = '/naverlogin.do?member_email='
	    		+member_email+"&token="+token;
	   	window.close();
	   
	  }
</script>
</body>
</html>