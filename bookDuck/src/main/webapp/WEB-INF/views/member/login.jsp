<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>
<style type="text/css">
	@font-face{
		font-family: 'NanumSquareRoundEB';
		src: url("webapp/font/NanumSquareRoundEB.ttf");
		}
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<script type="text/javascript">

	$(function(){
		$("#loginChk").hide();
	});
	
	function login(){
		var member_id = $("#member_id").val().trim();
		var member_pw = $("#member_pw").val().trim();
		var loginVal = {
				"member_id": member_id,
				"member_pw": member_pw
		}
		
		if(member_id == null || member_id == "" || member_pw == null || member_pw == "" ){
			alert("ID 및 PW를 입력해 주세요");
		}else{
			$.ajax({
				type:"post",
				url:"login.do",
				data:JSON.stringify(loginVal),
				contentType:"application/json",
				dataType:"json",
				success: function(msg){
					if(msg.check == true){
						location.href='index.jsp';
					}else{
						alert("ID 및 PW를 확인해 주세요");
					}
				},
				error:function(){
					alert("통신 실패");
				}
			});
		}
	}
</script>
  
<jsp:include page="../header.jsp"/>
<link href="css/login.css" rel="stylesheet">
<body>
<div id="loginform">
<br/>
<br/>
<br/>
<br/>
	<div class="general-login">
		<div id="login-title" style="text-align: center;">
		<img src="resources/img/bookduckLogo.png" width="200" height="49" id="loginlogo">
		</div>
		<br/>
		<table id="logintable">
			<colgroup>
				<col width="15%">
			</colgroup>
			<tr id="idForm">
				<th>ID</th>
				<td>&nbsp;<input type="text" class="text_box" placeholder="ID" id="member_id"/></td>
			</tr>
			<tr id="pwForm">
				<th>PW</th>
				<td>&nbsp;<input type="password" class="text_box" placeholder="Password" id="member_pw"/></td>
			</tr>
			<tr id="login-button">
				<td id="login-button" colspan="2"><input type="button" value="로그인" id="login" onclick="login();"/></td>
			</tr>
			<tr>
				<td colspan="2" align="center" id="loginChk"></td>
			</tr>

		</table>
		</div><!-- general login 끝 -->

		<div class="SNSButton" id="SNSButton">
			<h4 align="center" style="font-family:'NanumSquareRoundEB';">SNS로 로그인하기</h4>
			<div class="card">
				<!-- 카카오 아이콘 -->
	  			<div><img src="resources/img/kakao.png" 
	  				onclick="document.getElementById('kakao-login-btn').click();" width="72" height="36" id="kakao-login-btn"></div>
				<!-- 네이버 아이콘 -->
				<div id="naver_id_login" class="SNSButton" ></div>
				<!-- 구글 아이콘 -->
				<div><img src="resources/img/google.png" id="glogin" width="150"></div>
			</div>
		</div><!-- SNSButton 끝 -->
<br/>
		<hr style="border:1px color= silver;" width="30%">
		<div class="login-footer">
			<h4 align="center">BookDuck의 
			<a onclick="location.href='joinform.do'" id="join_link">식구</a>되기</h4>
		</div>
</div>


	<div class="sns-login-area">
	<!-- 네이버 로그인 -->
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	
	<!-- kakaoLogin -->
	<script type="text/javascript"src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
	<!-- googleLogin -->
	<script src="https://apis.google.com/js/client:platform.js?onload=init" async defer></script>
	
	<script>
	    function onSubmit(e){
	        console.log("rere")
	        e.preventDefault();
	    }
	</script>
	</div> <!-- sns-login-area 끝 -->
</div> <!-- login-form 끝 -->
</head>

<body>

<div class="card">
  <!-- //네이버아이디로로그인 버튼 노출 영역 -->
  <script type="text/javascript">
      var naver_id_login = new naver_id_login("Hft3mSmHcCpHqnsB7j3E", "http://localhost:8787/bookduck/naverlogin.do");
      var state = naver_id_login.getUniqState();
      naver_id_login.setButton("green", 2,36);
      naver_id_login.setDomain("http://localhost:8787");
      naver_id_login.setState(state);
      naver_id_login.setPopup();
      naver_id_login.init_naver_id_login();
  </script>
  
  <!-- googleLogin -->
</div><!-- snsloginarea -->
         <!-- 이곳에서 동일하게 키값을 통해서 전달받은 정보를 onsingup함수 를통해 location.href로 로그인컨트롤러에 보내주게됩니다.-->
    <script>
         function init() {
                gapi.load('auth2', function() {
                    auth2 = gapi.auth2.init({
                        client_id: '409001703950-2aoh9f52ta7827mps5porjeknt3104mk.apps.googleusercontent.com',
                        cookiepolicy: 'single_host_origin',
                        scope: 'profile email'
                    });
                    element = document.getElementById('glogin');
                    auth2.attachClickHandler(element, {}, onSignUp, onFailure);
                });
            }
            function onSignUp(googleUser) {
              var profile = googleUser.getBasicProfile();
              const member_email = profile.getEmail();
              const member_id = profile.getId();
              location.href = 'googlelogin.do?member_email='+member_email+"&member_id="+member_id;
            }
            function onFailure(err){
                console.log(err)
                return;
            }
    </script>
    <!-- kakaoLogin -->
    <!-- 아래 카카오 init메소드에 키값을 넣어주고 똑같이 카카오에서 진행해주는 api가 팝업으로 실행되면 동의를 한 정보들을 받아오게됩니다.
    그리고 성공 함수를 통해서 받아온 정보가 일치하게되면 href 를통해 컨트롤러에 보내주게되고 네이버와 마찬가지로 이메일중복값에 따라 회원가입과 로그인으로 나뉘게됩니다. -->
    <script type="text/javascript">
        Kakao.init("b4f94ac66d295c885352ddef0bf123d4"); //javascript key
        
        Kakao.Auth.createLoginButton({
			//id값을 설정한 곳에 버튼을 자동생성한다
			container : '#kakao-login-btn',
			success : function(authObj) {
				
				//request함수를 통해 사용자 정보를 얻는다
				Kakao.API.request({
					url : '/v2/user/me',
					success : function(res) {
					//카카오 이메일 정보 가져온 후 컨트롤러로 전송
					location.href = 'kakaologin.do?kakao_email='+res.kakao_account.email+"";
						//window.close();
					}
				})
				console.log(authObj);
				var token = authObj.access_token;
			},
			fail : function(err) {
				alert(JSON.stringify(err));	
			}
		});
    </script>

</body>
</html>