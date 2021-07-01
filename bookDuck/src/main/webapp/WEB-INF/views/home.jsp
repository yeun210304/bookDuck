<%@page import="com.spring.bookduck.pay.dto.PayDto"%>
<%@page import="com.spring.bookduck.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>    
<%
    response.setContentType("text/html; charset=UTF-8");
    %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%

String id = "";

	MemberDto Ldto = (MemberDto)session.getAttribute("Ldto");
	PayDto payDto = (PayDto)session.getAttribute("payDto");

	if (session.getAttribute("id") != null) {
		id = (String) session.getAttribute("id");
	}
	
	//여기서 자꾸 오류나고 있음 아이디 제대로 넣어야함
	//아이디랑 닉이 뭔지 알고 처리할 것. 값 가공 제대로 할 것
	
	// String nick = {Ldto.getMember_id()};
	String Member_id = "";
	if (session.getAttribute("Member_id") != null) {
		Member_id = (String) session.getAttribute(Member_id);
	} else {
		Member_id = "Member_id NULL";
	}

%>
	
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
			
			// websocket 웹소켓을 이용한 모두가 함께 쓰는 실시간소설 RealTimeNovel  
			
			//웹소켓 설정
			var webSocket = new WebSocket('ws://localhost:8787/bookduck/RealTimeNovel.do');
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
				webSocket.send("<%=Member_id%> is DisConnected\n");
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
				webSocket.send("<%=Member_id%>|\|안녕하세요^^");
			}
		
			//	OnError는 웹 소켓이 에러가 나면 발생을 하는 함수.
			function onError(event) {
				alert("chat_server connecting error " + event.data);
			}
			
			// send 함수를 통해서 웹소켓으로 메시지를 보낸다.
			function send() {
				//if(test()==1){
					//inputMessage가 있을때만 전송가능
					if(inputMessage.value!=""){
						
						//	서버에 보낼때 날아가는 값.
						webSocket.send("<%=Member_id%>|\|" + inputMessage.value);
						
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
						re_send = "<%=Member_id%>";
						}//inputMessage가 있을때만 전송가능 끝.
			//	}
					
			}
			
			function test(){
				
				var inputMessage = $("#inputMessage").val();
				var novel_id = $("#novel_id").val();
				
				$.ajax({
					url: "insertContent.do",
					data: {"novel_content":inputMessage,
						"novel_id":novel_id},
					dataType: "application/json",
					success: function(data){
						if(data.success == "success"){
							return 1;
						} else{
							return 0;
						}
					},
					error: function(error){
						alert("채팅ajax통신오류");
					}
				})
			}
			
		</script>
<title>Home</title>
</head>
<body onload="submit()">

<!-- 
헤더부분 수정할거
1. 항상 떠있게 바꿔주세요~! - 정은 
2. 검색창추가해주세요 - 성필, 은희
3. 메인이름추가링크 - 지연
-->
<%@ include file="header.jsp" %>
	<a href="loginform.do">로그인</a>
	
	<a href="noticeList.do">공지사항</a>
	
	<a href="qnaList.do">문의게시판</a>


	<!-- 웹소켓 채팅을 이용한 소설 RealTimeNovel -->
	<div class="RealTimeNovle">
		<!-- onkeydown을 통해서 엔터키로도 입력되도록 설정. -->
		<div id="messageWindow2" style="padding: 10px 0; height: 20em; overflow: auto; background-color: #a0c0d7;"></div>
		
		<c:choose>
			<c:when test="${Ldto.member_payrole eq 'Y'}">
			<!-- 사용자가 입력한 키의 코드를 .d보내준다. -->
				 <form action="insertNovel.do" method="post">
					<input id="inputMessage" type="text" name="novel_content" onkeydown="if(event.keyCode==13){send();}" />
					<input type="submit" value="입력" onclick="send();" />
					<input type="hidden" id="novel_id" value="${Ldto.member_id}" name="novel_id" />
				 </form> 
			</c:when>
			<c:otherwise>
				<input type="text" readonly="readonly" value="로그인시 이용하실 수 있습니다"/>
			</c:otherwise>
		</c:choose>
		
		
		<script type="text/javascript">
		    function submit()
		    {
		        document.getElementById("startrunning").click(); // Simulates button click
		        document.submitForm.submit(); // Submits the form without the button
		    }
		</script>
 
	
	    <form id="submitForm" action="submitForm.do">
	        <input type="hidden" id="startrunning">
	        <c:forEach var="list" items="${list}">
				<input type="text" id="novel_id" value="${list.novel_id}" />
				<input type="text" id="novel_regdate" value="${list.novel_regdate}" />
				<input type="text" id="novel_content" value="${list.novel_content}" />
			</c:forEach>
	    </form>
	
		
	</div>
</body>
	
<body>
	

	
	
	<!-- 현재 위치 기준 주변 서점 또는 도서관 검색 -->
	<div id="map" style="width:100%;height:350px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c4cbf31fc0b4bc0ff759253ed7b23a16&libraries=services"></script>
	<script type="text/javascript">
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
	        
	        var lat = position.coords.latitude; // 위도
	        var lon = position.coords.longitude; // 경도
	        
	        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	            message = '<div style="padding:5px;">나의 위치</div>'; // 인포윈도우에 표시될 내용입니다
	        
	        // 마커와 인포윈도우를 표시합니다
	        displayMarker(locPosition, message);
	            
	     	// 장소 검색 객체를 생성합니다
	    	var ps = new kakao.maps.services.Places();
	    	
	    	// 키워드로 장소를 검색합니다
	    	ps.keywordSearch('서점', placeSearchCB, {
	    		location : locPosition,							// 검색 중심 좌표
	    		size : 5,										// 표시될 갯수
	    		radius : 10000,									// 제한 범위(m)
	    		sort : kakao.maps.services.SortBy.DISTANCE,		// 정렬 기준(DISTANCE : 거리순 , ACCURACY : 정확도순)
	    	});
	    	ps.keywordSearch('도서관', placeSearchCB, {
	    		location : locPosition,
	    		size : 5,
	    		radius : 10000,
	    		sort : kakao.maps.services.SortBy.DISTANCE,
	    	});
	            
	      }, function(error){
	    	  if(error.PERMISSION_DENIED){	// 사용자가 위치 권한 차단했을 경우
	    		  var locPosition = new kakao.maps.LatLng(37.49767083325, 127.03050314956),    // kh 정보교육원 기준으로 함
		  	        message = 'kh정보교육원'
		  	        
		  	    displayMarker(locPosition, message);
	    		// 장소 검색 객체를 생성합니다
	  	    	var ps = new kakao.maps.services.Places();
	  	   		// 키워드로 장소를 검색합니다
		    	ps.keywordSearch('서점', placeSearchCB, {
		    		location : locPosition,		// 검색 중심 좌표
		    		size : 5,										// 표시될 갯수
		    		radius : 10000,									// 제한 범위(m)
		    		sort : kakao.maps.services.SortBy.DISTANCE,		// 정렬 기준(DISTANCE : 거리순 , ACCURACY : 정확도순)
		    	});
		    	ps.keywordSearch('도서관', placeSearchCB, {
		    		location : locPosition,
		    		size : 5,
		    		radius : 10000,
		    		sort : kakao.maps.services.SortBy.DISTANCE,
		    	});
	    		  
	    	  }
	      });
	    
	} else { // HTML5의 GeoLocation을 지원하지 않을 때
	    
		console.log("");
		console.log("findLocation : geolocation을 사용할수 없어요..");
		alert("지도 정보를 지원하지 않는 브라우저입니다.");
		console.log("");
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
	
	
	<!-- 인공지능을 활용한 책 카테고리 추천. -->
	<br/><br/><br/><br/>
	<div>
		<table>
			<tr>
				<td colspan="4" id="airecommendbox">나이/성별/좋아하는 책 분류를 선택해주세요</td>			
			</tr>
			<tr>
				<td>										
					<select name="age">
					     <optgroup label="나이">
					        <option value="10s">10대</option>
					        <option value="20s">20대</option>
					        <option value="30s">30대</option>
					        <option value="40s">40대</option>
					        <option value="50s">50대</option>
					        <option value="60s_over">60대 이상</option>
					     </optgroup>
					</select>
				</td>
				<td>
					<select name="mw">
						<optgroup label="성별">
							<option value="man">남자</option>
							<option value="woman">여자</option>
						</optgroup>					
					</select>				
				</td>
				<td>
					<select name="category">
						<optgroup label="좋아하는 책분류">
							<option value="101">소설</option>
							<option value="102">시/에세이</option>
							<option value="103">예술/대중문화</option>
							<option value="104">사회과학</option>
							<option value="105">역사와 문화</option>
							<option value="107">잡지</option>
							<option value="108">만화</option>
							<option value="109">유아</option>
							<option value="110">아동</option>
							<option value="111">가정과 생활</option>
							<option value="112">청소년</option>
							<option value="113">초등학습서</option>
							<option value="114">고등학습서</option>
							<option value="115">국어/외국어/사전</option>
							<option value="116">자연과 과학</option>
							<option value="117">경제경영</option>
							<option value="118">자기계발</option>
							<option value="119">인문</option>
							<option value="120">종교/역학</option>
							<option value="122">컴퓨터/인터넷</option>
							<option value="123">자격서/수험서</option>
							<option value="124">취미/레저</option>
							<option value="125">전공도서/대학교재</option>
							<option value="126">건강/뷰티</option>
							<option value="128">여행</option>
							<option value="129">중등학습서</option>							
						</optgroup>					
					</select>	
				</td>
				<td><input id="airecommend" type="button" value="추천받기"></td>			
			</tr>
		</table>
	</div>
	
	<script type="text/javascript">
		
		var $age = $("select[name=age]").val();
		var $mw = $("select[name=mw]").val();
		var $category = $("select[name=category]").val();
		var id = "${Ldto.member_id}";
		var $aibox = $("#airecommendbox");
		var scorelist = [];
		var categorylist = [{category : '101' , name : '소설'},
							{category : '102' , name : '시/에세이'},
							{category : '103' , name : '예술/대중문화'},
							{category : '104' , name : '사회과학'},
							{category : '105' , name : '역사와 문화'},
							{category : '107' , name : '잡지'},
							{category : '108' , name : '만화'},
							{category : '109' , name : '유아'},
							{category : '110' , name : '아동'},
							{category : '111' , name : '가정과 생활'},
							{category : '112' , name : '청소년'},
							{category : '113' , name : '초등학습서'},
							{category : '114' , name : '고등학습서'},
							{category : '115' , name : '국어/외국어/사전'},
							{category : '116' , name : '자연과 과학'},
							{category : '117' , name : '경제 경영'},
							{category : '118' , name : '자기계발'},
							{category : '119' , name : '인문'},
							{category : '120' , name : '종교/역학'},
							{category : '122' , name : '컴퓨터/인터넷'},
							{category : '123' , name : '자격서/수험서'},
							{category : '124' , name : '취미/레저'},
							{category : '125' , name : '전공도서/대학교재'},
							{category : '126' , name : '건강/뷰티'},
							{category : '128' , name : '여행'},
							{category : '129' , name : '중등학습서'}];
				
		$("#airecommend").click(function(){
			if(id.trim() != ""){
				$age = $("select[name=age]").val();
				$mw = $("select[name=mw]").val();
				$category = $("select[name=category]").val();			
				
				$.getJSON("airecommend.do?age_mw="+$age+"_"+$mw+"&category="+$category, function(result){
					scorelist = result.list;
					scorelist.sort((a,b) => (a.score > b.score) ? -1 : ((a.score < b.score) ? 1 : 0));
					
					var one;
					var two;
					var three;
					
					for(var i = 0 ; i < categorylist.length ; i++){						
						if(categorylist[i].category == scorelist[0].category){							
							one = categorylist[i].name
						} else if(categorylist[i].category == scorelist[1].category){
							two = categorylist[i].name
						} else if(categorylist[i].category == scorelist[2].category){
							three = categorylist[i].name
						}
					}
					
					$aibox.text("");
					$aibox.text("추천 카테고리 1 : "+ one +" 2 : "+ two +" 3: "+ three);
					
				});
			} else {
				$aibox.text("");
				$aibox.text("로그인을 해야 사용할 수 있는 기능입니다.");
			}
			
			
			
		});
	
	
	
	
	
	
	</script>


	
		<!-- footer 에 넣던지 하기! -->
	<div class="info">
		<p>KH정보교육원 강남지원1관 Q클래스 오전반 3조의 파이널프로젝트</p>
		<p>지 연 소윤정 강성필 박은희 한우빈 이정은</p>
		<p>E-Mail. jeeyeon210304@gmail.com</p>
		<p>주소. 서울 강남구 테헤란로14길 6 남도빌딩 2층, 3층, 4층</p>
		<p></p>
		<p></p>
		<p></p> 	
	</div>
	
</body>
</html>
