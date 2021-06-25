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
	
	
	<!-- 현재 위치 기준 주변 서점 또는 도서관 검색 -->
	<div id="map" style="width:100%;height:350px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c4cbf31fc0b4bc0ff759253ed7b23a16&libraries=services"></script>
	<script type="text/javascript">
	// 위도 경도 변수 선언
	var lat; var lon;
	
	// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
		center: new kakao.maps.LatLng(33, 126), // 지도의 중심좌표
		level: 6 // 지도의 확대 레벨
		};

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
	if (navigator.geolocation) {
	    
	    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
	    navigator.geolocation.getCurrentPosition(function(position) {
	        
	        lat = position.coords.latitude; // 위도
	        lon = position.coords.longitude; // 경도
	        
	        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	            message = '<div style="padding:5px;">나의 위치</div>'; // 인포윈도우에 표시될 내용입니다
	        
	        // 마커와 인포윈도우를 표시합니다
	        displayMarker(locPosition, message);
	            
	     	// 장소 검색 객체를 생성합니다
	    	var ps = new kakao.maps.services.Places();
	    	
	    	// 키워드로 장소를 검색합니다
	    	ps.keywordSearch('서점', placeSearchCB, {
	    		location : new kakao.maps.LatLng(lat, lon),		// 검색 중심 좌표
	    		size : 5,										// 표시될 갯수
	    		radius : 10000,									// 제한 범위(m)
	    		sort : kakao.maps.services.SortBy.DISTANCE,		// 정렬 기준(DISTANCE : 거리순 , ACCURACY : 정확도순)
	    	});
	    	ps.keywordSearch('도서관', placeSearchCB, {
	    		location : new kakao.maps.LatLng(lat, lon),
	    		size : 5,
	    		radius : 10000,
	    		sort : kakao.maps.services.SortBy.DISTANCE,
	    	});
	            
	      });
	    
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
	    
		console.log("");
		console.log("findLocation : Geolocation API Not Enable");    		
		console.log("");
		
	    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
	        message = 'geolocation을 사용할수 없어요..'
	        
	    displayMarker(locPosition, message);
	}
	
	
	function placeSearchCB(data, status, pagination){
		if(status === kakao.maps.services.Status.OK){
			for(var i = 0; i < data.length; i++){
				displayMarker01(data[i]);
			}
		}
	}
	// 지도에 마커를 표시하는 함수입니다(검색 결과 마커들)
	function displayMarker01(place) {
	    
	    // 마커를 생성하고 지도에 표시합니다
	    var marker = new kakao.maps.Marker({
	        map: map,
	        position: new kakao.maps.LatLng(place.y, place.x) 
	    });

	    // 마커에 클릭이벤트를 등록합니다
	    kakao.maps.event.addListener(marker, 'click', function() {
	        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
	        infowindow.setContent('<div style="padding:5px;font-size:12px;"><a href="'+ place.place_url +'" target="_blank">' + place.place_name +'</a><br/>'
	        																  + place.address_name + '<br/>나로부터 '
	        																  + place.distance + 'm</div>');
	        infowindow.open(map, marker);
	    });
	}
	
	// 지도에 마커와 인포윈도우를 표시하는 함수입니다(현재 위치 혹은 기본 위치일 때)
	function displayMarker(locPosition, message) {
	
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({  
	        map: map, 
	        position: locPosition
	    }); 
	    
	    var iwContent = message, // 인포윈도우에 표시할 내용
	        iwRemoveable = true;
	
	    // 인포윈도우를 생성합니다
	    var infowindow = new kakao.maps.InfoWindow({
	        content : iwContent,
	        removable : iwRemoveable
	    });
	    
	    // 인포윈도우를 마커위에 표시합니다 
	    infowindow.open(map, marker);
	    
	    // 지도 중심좌표를 접속위치로 변경합니다
	    map.setCenter(locPosition);      
	}
	</script>

	<a href="loginform.do">로그인</a>
	
	<a href="noticeList.do">공지사항</a>
	
	<a href="qnaList.do">문의게시판</a>
	
	<a href="mapTest.do">지도테스트</a>

</body>
</html>
