<%@page import="com.spring.bookduck.pay.dto.PayDto"%>
<%@page import="com.spring.bookduck.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>    
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String id = "";
	if (session.getAttribute("id") != null) {
		id = (String) session.getAttribute("id");
	}

	String nick = "";
	if (session.getAttribute("nick") != null) {
		nick = (String) session.getAttribute("nick");
	} else {
		nick = "NICK NULL";
	}
	MemberDto Ldto = (MemberDto)session.getAttribute("Ldto");
	PayDto payDto = (PayDto)session.getAttribute("payDto");
%>
	
<html>
<head>
<title>Home</title>
</head>
<body>

<%@ include file="header.jsp" %>

	<div class="RealTimeNovle">
		<h3>모두와 소설</h3>
		<!-- onkeydown을 통해서 엔터키로도 입력되도록 설정. -->
		<div id="messageWindow2" style="padding: 10px 0; height: 20em; overflow: auto; background-color: #a0c0d7;"></div>
		<input id="inputMessage" type="text" onkeydown="if(event.keyCode==13){send();}" /> <input type="submit" value="send" onclick="send();" />

		<script type="text/javascript">
	
			//웹소켓 설정
			var webSocket = new WebSocket('ws://localhost:8787/websockettest/broadcasting');
			//var webSocket = new WebSocket('ws://localhost:8080/프로젝트명/broadcasting');
			var inputMessage = document.getElementById('inputMessage');
			//같은 이가 여러번 보낼때 이름 판별할 변수
			var re_send = "";
		
			webSocket.onerror = function(event) {
				onError(event)
			};
			webSocket.onopen = function(event) {
				onOpen(event)
			};
			webSocket.onmessage = function(event) {
				onMessage(event)
			};
		
			//	OnClose는 웹 소켓이 끊겼을 때 동작하는 함수.
			function onClose(event){
				var div=document.createElement('div');
				
				//접속했을 때 접속자들에게 알릴 내용.
				webSocket.send("<%=nick%> is DisConnected\n");
			}
		
			//	OnMessage는 클라이언트에서 서버 측으로 메시지를 보내면 호출되는 함수.
			function onMessage(event) {
		
				//클라이언트에서 날아온 메시지를 |\| 단위로 분리한다
				var message = event.data.split("|\|");
				
					//금방 보낸 이를 re_send에 저장하고,
					//금방 보낸 이가 다시 보낼경우 보낸이 출력 없도록 함.
					if(message[0] != re_send){
						//messageWindow2에 붙이기
						var who = document.createElement('div');
		
						who.style["padding"]="3px";
						who.style["margin-left"]="3px";
		
						who.innerHTML = message[0];
						document.getElementById('messageWindow2').appendChild(who);
		
						re_send = message[0];
					}
				
					//div는 받은 메시지 출력할 공간.
					var div=document.createElement('div');
				
					div.style["width"]="auto";
					div.style["word-wrap"]="break-word";
					div.style["display"]="inline-block";
					div.style["background-color"]="#fcfcfc";
					div.style["border-radius"]="3px";
					div.style["padding"]="3px";
					div.style["margin-left"]="3px";
		
					div.innerHTML = message[1];
					document.getElementById('messageWindow2').appendChild(div);
				
				//clear div 추가. 줄바꿈용.		
				var clear=document.createElement('div');
				clear.style["clear"]="both";
				document.getElementById('messageWindow2').appendChild(clear);
				
				//div 스크롤 아래로.
				messageWindow2.scrollTop = messageWindow2.scrollHeight;
				
			}
		
			//	OnOpen은 서버 측에서 클라이언트와 웹 소켓 연결이 되었을 때 호출되는 함수.
			function onOpen(event) {
				
				//접속했을 때, 내 영역에 보이는 글.
				var div=document.createElement('div');
				
				div.style["text-align"]="center";
				
				div.innerHTML = "반갑습니다.";
				document.getElementById('messageWindow2').appendChild(div);
				
				var clear=document.createElement('div');
				clear.style["clear"]="both";
				document.getElementById('messageWindow2').appendChild(clear);
				
				//접속했을 때 접속자들에게 알릴 내용.
				webSocket.send("<%=nick%>|\|안녕하세요^^");
			}
		
			//	OnError는 웹 소켓이 에러가 나면 발생을 하는 함수.
			function onError(event) {
				alert("chat_server connecting error " + event.data);
			}
			
			// send 함수를 통해서 웹소켓으로 메시지를 보낸다.
			function send() {
		
				//inputMessage가 있을때만 전송가능
				if(inputMessage.value!=""){
					
					//	서버에 보낼때 날아가는 값.
					webSocket.send("<%=nick%>|\|" + inputMessage.value);
					
					// 채팅화면 div에 붙일 내용
					var div=document.createElement('div');
					
					div.style["width"]="auto";
					div.style["word-wrap"]="break-word";
					div.style["float"]="right";
					div.style["display"]="inline-block";
					div.style["background-color"]="#ffea00";
					div.style["padding"]="3px";
					div.style["border-radius"]="3px";
					div.style["margin-right"]="3px";
		
					//div에 innerHTML로 문자 넣기
					div.innerHTML = inputMessage.value;
					document.getElementById('messageWindow2').appendChild(div);
		
					//clear div 추가
					var clear = document.createElement('div');
					clear.style["clear"] = "both";
					document.getElementById('messageWindow2').appendChild(clear);
					
					//	?
					//inputMessage.value = "";
		
					//	inputMessage의 value값을 지운다.
					inputMessage.value = '';
		
					//	textarea의 스크롤을 맨 밑으로 내린다.
					messageWindow2.scrollTop = messageWindow2.scrollHeight;
					
					//	금방 보낸 사람을 임시 저장한다.
					re_send = "<%=nick%>
					";
						}//inputMessage가 있을때만 전송가능 끝.
		
					}
		</script>
		
		

	</div>


	<div class="info">
		<p>KH정보교육원 강남지원1관 Q클래스 오전반 3조의 파이널프로젝트 \n</p>
		<p>지 연 소윤정 강성필 박은희 한우빈</p>
		<p>E-Mail. jeeyeon210304@gmail.com</p>
		<p>주소. 서울 강남구 테헤란로14길 6 남도빌딩 2층, 3층, 4층</p>
		<p></p>
		<p></p>
		<p></p> 	
	</div>
	
	<div id="map" style="width:100%;height:350px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c4cbf31fc0b4bc0ff759253ed7b23a16&libraries=services"></script>
	<script type="text/javascript">
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
	
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
	
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 
	
		// 키워드로 장소를 검색합니다
		ps.keywordSearch('서점', placesSearchCB, searchOptions); 
		var searchOptions = {
				location : new kakao.maps.LatLng(37.566826, 126.9786567),
				size : 15,
				radius : 5000,
		};
		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
	
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        //var bounds = new kakao.maps.LatLngBounds();
	
		        for (var i=0; i<data.length; i++) {
		            displayMarker(data[i]);    
		            //bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		        }       
	
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		       // map.setBounds(bounds);
		    } 
		}
	
		// 지도에 마커를 표시하는 함수입니다
		function displayMarker(place) {
		    
		    // 마커를 생성하고 지도에 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: new kakao.maps.LatLng(place.y, place.x) 
		    });
	
		    // 마커에 클릭이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'click', function() {
		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
		        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
		        infowindow.open(map, marker);
		    });
		}
	</script>

	<a href="loginform.do">로그인</a>
	
	<a href="noticeList.do">공지사항</a>
	
	<a href="qnaList.do">문의게시판</a>
	
	<a href="mapTest.do">지도테스트</a>

</body>
</html>
