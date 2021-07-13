<%@page import="org.w3c.dom.Node"%>
<%@page import="javax.xml.xpath.XPathConstants"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="javax.xml.xpath.XPathFactory"%>
<%@page import="javax.xml.xpath.XPath"%>
<%@page import="org.xml.sax.InputSource"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="java.io.Console"%>
<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@page import="com.spring.bookduck.pay.dto.PayDto"%>
<%@page import="com.spring.bookduck.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>    
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	MemberDto Ldto = (MemberDto)session.getAttribute("Ldto");
	PayDto payDto = (PayDto)session.getAttribute("payDto");
	String nick = "";
	String novel_id = "";
	if(Ldto != null){
		if (request.getAttribute("nick") == null || request.getAttribute("nick") == "" || request.getAttribute("nick") != null || request.getAttribute("nick") != "") {
			novel_id = Ldto.getMember_id();
			request.setAttribute("nick", novel_id);
			nick = (String) request.getAttribute("nick");
		} else {
			nick = "NICK NULL";
		}
	}
%>
<%	
//절대경로 확인
String path = request.getContextPath();
String key = request.getParameter("key");
String value = request.getParameter("value");
if (key == null) {
	key = "";
	value = "";
}
String genreTAG = request.getParameter("genreTAG");
System.out.println("genreTAG : " + request.getParameter("genreTAG"));
StringBuilder sb = new StringBuilder();
String totalcount = "0";
String count = "0";

if (key != null && value != null) {
	DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	DocumentBuilder builder = factory.newDocumentBuilder();
	Document doc = null;
	String str = String.format(
	"http://book.interpark.com/api/search.api?key=7A71D8E679DA9C96874476B8E225B77A4592E29959B15764C52A257C0343754F&query=%s&inputEncoding=utf-8&searchTarget=book&foreign&categoryId=%s&sort=customerRating",
	1, genreTAG);
	URL url = new URL(str);
	InputSource is = new InputSource(url.openStream());
	doc = builder.parse(is);

	XPath xpath = XPathFactory.newInstance().newXPath();
	totalcount = xpath.compile("/channel/totalResults").evaluate(doc);
	NodeList itemList = (NodeList) xpath.compile("/channel/item").evaluate(doc, XPathConstants.NODESET);
	int count_ = itemList.getLength();
	count = String.valueOf(count_);
	for (int a = 1; a <= count_; a++) {
		Node item = (Node) xpath.compile(String.format("/channel/item[%s]", a)).evaluate(doc, XPathConstants.NODE);
		String coverLargeUrl = xpath.compile("coverLargeUrl").evaluate(item);
		String title = xpath.compile("title").evaluate(item);
		String author = xpath.compile("author").evaluate(item);
		String publisher = xpath.compile("publisher").evaluate(item);
		String priceStandard = xpath.compile("priceStandard").evaluate(item);
		String description = xpath.compile("description").evaluate(item);
		String pubDate = xpath.compile("pubDate").evaluate(item);
		String isbn = xpath.compile("isbn").evaluate(item);
		String link = xpath.compile("link").evaluate(item);
		String categoryName = xpath.compile("categoryName").evaluate(item);
		String categoryId = xpath.compile("categoryId").evaluate(item);
		// 비어있는 값 대비
		if(description == null || description == "" || description == " " ){description = "이 도서는 정보를 제공하지 않습니다.";}
		if(categoryId == null || categoryId == "" || categoryId == " " ){categoryId = "이 도서는 정보를 제공하지 않습니다.";}
		if(categoryName == null || categoryName == "" || categoryName == " " ){categoryName = "이 도서는 정보를 제공하지 않습니다.";}
		if(isbn == null || isbn == "" || isbn == " " ){isbn = "이 도서는 정보를 제공하지 않습니다.";}
		if(pubDate == null || pubDate == "" || pubDate == " " ){pubDate = "이 도서는 정보를 제공하지 않습니다.";}
		if(publisher == null || publisher == "" || publisher == " " ){publisher = "이 도서는 정보를 제공하지 않습니다.";}
		if(author == null || author == "" || author == " " ){author = "이 도서는 정보를 제공하지 않습니다.";}
		// categoryId 정리
		if(categoryId == "101"){categoryId = "소설";}
		if(categoryId == "102"){categoryId = "시/에세이";}
		if(categoryId == "103"){categoryId = "예술/대중문화";}
		if(categoryId == "104"){categoryId = "사회과학";}
		if(categoryId == "105"){categoryId = "역사와 문화";}
		if(categoryId == "107"){categoryId = "잡지";}
		if(categoryId == "108"){categoryId = "만화";}
		if(categoryId == "109"){categoryId = "유아";}
		if(categoryId == "110"){categoryId = "아동";}
		if(categoryId == "111"){categoryId = "가정과 생활";}
		if(categoryId == "112"){categoryId = "청소년";}
		if(categoryId == "113"){categoryId = "초등학습서";}
		if(categoryId == "114"){categoryId = "고등학습서";}
		if(categoryId == "115"){categoryId = "국어/외국어/사전";}
		if(categoryId == "116"){categoryId = "자연과 과학";}
		if(categoryId == "117"){categoryId = "경제경영";}
		if(categoryId == "118"){categoryId = "자기계발";}
		if(categoryId == "119"){categoryId = "인문";}
		if(categoryId == "120"){categoryId = "종교/역학";}
		if(categoryId == "122"){categoryId = "컴퓨터/인터넷";}
		if(categoryId == "123"){categoryId = "자격서/수험서";}
		if(categoryId == "124"){categoryId = "취미/레저";}
		if(categoryId == "125"){categoryId = "전공도서/대학교제";}
		if(categoryId == "126"){categoryId = "건강뷰티";}
		if(categoryId == "128"){categoryId = "여행";}
		if(categoryId == "129"){categoryId = "중등학습서";}
		
		sb.append(String.format("<div class='cols'>"));
			
			sb.append(String.format("<div><img src='%s' style='width:115px; margin-left: 40px; margin-bottom: 10px;'></div>", coverLargeUrl));
			sb.append(String.format("<table id = 'tbb'><tr> <td id='td1'><b> &#128157;&nbsp; 제목 </b></td> <td id='td2'>%s</td> </tr>", title));
			sb.append(String.format("<tr> <td id='td1' ><b> &#128039;&nbsp; 저자 </b></td> <td  id='td2'>%s</td> </tr>", author));
			sb.append(String.format("<tr> <td id='td1' ><b> &#128049;&nbsp; 카테고리 </b></td> <td id='td2'>%s</td> </tr>", categoryName));
			sb.append(String.format("<tr> <td id='td1' colspan='2'><div id='btncss'><a href='recommendBook.do?title=%s&coverLargeUrl=%s&isbn=%s&author=%s&categoryId=%s'  target='_blank' style='vertical-align: middle; margin-botton: 60px;'>&#128149;&nbsp;도서추천</a></div></td></tr></table>",title,coverLargeUrl,isbn,author,categoryId));
			sb.append(String.format("<div class='wrapper'></div>"));
		
			
		sb.append(String.format("</div>"));
	}
}
%>
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.js"></script>
<!-- bootstrap 4 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="css/home.css" rel="stylesheet" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!--  websocket 웹솤캣 채팅-->  
<script type="text/javascript">
	//웹소켓 설정
	var webSocket = new WebSocket('ws://localhost:8787/bookduck/RealTimeNovel.do');	
	//var webSocket = new WebSocket('ws://localhost:8080/프로젝트명/broadcasting');

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
	//	OnMessage는 클라이언트에서 서버 측으로 메시지를 보내면! 호출되는 함수.
	function onMessage(event) {
		//클라이언트에서 날아온 메시지를 |\| 단위로 분리한다
		var message = event.data.split("|\|");
			//금방 보낸 이를 re_send에 저장하고,
			//금방 보낸 이가 다시 보낼경우 보낸이 출력 없도록 함.
			if(message[0] != re_send){
				//messageWindow2에 붙이기
				var who = document.createElement('div');
				who.style["padding"]="3px";
				who.style["margin"]="6px";
				who.innerHTML = message[0];
				document.getElementById('messageWindow2').appendChild(who);
				re_send = message[0];
			}
			//div는 받은 메시지 출력할 공간.
			var div=document.createElement('div');
			div.style["width"]="auto";
			div.style["word-wrap"]="break-word";
			div.style["display"]="inline-block";
			div.style["background-color"]="#6277BA";
			div.style["border-radius"]="3px";
			div.style["padding"]="3px";
			div.style["color"]="white";
			div.style["margin"]="6px";
			div.innerHTML = message[1];
			document.getElementById('messageWindow2').appendChild(div);
		//clear div 추가. 줄바꿈용.		
		var clear=document.createElement('div');
		clear.style["clear"]="both";
		document.getElementById('messageWindow2').appendChild(clear);
		//div 스크롤 아래로.
		messageWindow2.scrollTop = messageWindow2.scrollHeight;
	}
	var novel_id = document.getElementById("novel_id");
	
	if(novel_id != "" || novel_id != null){
	//	OnOpen은 서버 측에서 클라이언트와 웹 소켓 연결이 되었을 때 호출되는 함수.
		function onOpen(event) {
			//접속했을 때, 내 영역에 보이는 글.
			var div=document.createElement('div');
			div.style["text-align"]="center";
			document.getElementById('messageWindow2').appendChild(div);
			var clear=document.createElement('div');
			clear.style["clear"]="both";
			document.getElementById('messageWindow2').appendChild(clear);
			//접속했을 때 접속자들에게 알릴 내용.
			if(<%=nick%> != null){
				webSocket.send("<%=nick%>|\|<%=nick%>님이 채팅에 입장하셨습니다.");s
			}
			
		}
	}
	// send 함수를 통해서 웹소켓으로 메시지를 보낸다.
	function send() {
		// 콘솔 텍스트 오브젝트
		var inputMessage = document.getElementById("inputMessage");
		//inputMessage가 있을때만 전송가능
		if(inputMessage.value != ""){
			//	서버에 보낼때 날아s가는 값.
			webSocket.send("<%=nick%>|\|" + inputMessage.value);
			// 채팅화면 div에 붙일 내용
			var div=document.createElement('div');
			div.style["width"]="auto";
			div.style["word-wrap"]="break-word";
			div.style["float"]="right";
			div.style["display"]="inline-block";
			div.style["background-color"]="#F5DC7A";
			div.style["padding"]="3px";
			div.style["border-radius"]="3px";
			div.style["margin"]="6px";
			//div에 innerHTML로 문자 넣기
			div.innerHTML = inputMessage.value;
			document.getElementById('messageWindow2').appendChild(div);
			//clear div 추가
			var clear = document.createElement('div');
			clear.style["clear"] = "both";
			document.getElementById('messageWindow2').appendChild(clear);
			// inputMessage의 value값을 지운다.
			inputMessage.value = '';
			// textarea의 스크롤을 맨 밑으로 내린다.
			messageWindow2.scrollTop = messageWindow2.scrollHeight;
			// 금방 보낸 사람을 임시 저장한다.
			re_send = "<%=nick%>";
			}//inputMessage가 있을때만 전송가능 끝.
		}
</script>
<!-- 책장르 선택시 책 나열 -->
<script type="text/javascript">
	function genreTagDo(){
		
		var member_id = document.getElementById("member_id");
		
		if(member_id == null){
			alert("로그인 후 이용가능합니다");
			return false;
		} else{
			$.ajax({
				type : "post",
		        data: {"genreTAG" : genreTAG.value},
		        success: function(list){
		        	var arr = list.split('<');
		        	console.log(arr);
	                var value = "";
	                for(var i=226; i < 390; i++){
	                	value += '<'+arr[i]
	                };
	                var value2 = value.split("<ul class=");
	               // $("#genreTAG").hide();
		        	$("#Result1").html(value2);
		            }, 
		        error: function(){
	            	alert("error...");
	         	   }
		        });
			}
		}
	
</script>
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>

	<jsp:include page="header.jsp"/>
	
			<!-- 장르(태그) 선택 -->
				<div id="genre" class="jumbotron text-center">
					<label>장르선택</label>
					<select id="genreTAG" name="genreTAG" onchange="genreTagDo();" >
						<option value="none">  ---------   선택   ---------  </option>
						<optgroup label=문학>
							<option value="101">소설</option>
							<option value="112">청소년</option>
							<option value="108">만화</option>
						</optgroup>	
						<optgroup label="전문서적">
							<option value="119">인문</option>
							<option value="117">경제경영</option>
							<option value="104">사회과학</option>
							<option value="116">자연과 과학</option>
							<option value="103">예술/대중문화</option>
							<option value="122">컴퓨터/인터넷</option>
							<option value="120">종교/역학</option>
							<option value="105">역사와 문화</option>
							<option value="118">자기계발</option>
						</optgroup>	
						<optgroup label="학습서">
							<option value="113">초등학습서</option>
							<option value="129">중등학습서</option>			
							<option value="114">고등학습서</option>
							<option value="123">자격서/수험서</option>
							<option value="125">전공도서/대학교재</option>
							<option value="115">국어/외국어/사전</option>
						</optgroup>	
						<optgroup label="사회">
							<option value="107">잡지</option>
							<option value="109">유아</option>
							<option value="110">아동</option>
							<option value="111">가정과 생활</option>
							<option value="124">취미/레저</option>
							<option value="126">건강/뷰티</option>
							<option value="128">여행</option>
						</optgroup>
					</select>
					<%=sb.toString()%>
					<div class="container-fluid">
					 	<div class="row">
							<div id="Result1"></div>
						</div>
					</div>
					 	
				</div>
				
	<div class="container">
		<div class="container-fluid">
			<div class="row">
			
				<div class="col-sm-5">
				<!-- 현재 위치 기준 주변 서점 또는 도서관 검색 -->
				<div id="mainCenter_right">
					<c:choose>
						<c:when test="${Ldto.member_id eq null }">
							<b>주변 서점 및 도서관</b>
						</c:when>
						<c:otherwise>
							<b>${Ldto.member_id } 님 주변에 위치한 서점 및 도서관</b>
						</c:otherwise>
					</c:choose>
					<div id="map"></div>
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
				</div>
				</div>
				
				<div class="col-sm-7">
                <!-- 웹소켓 채팅 -->
                <div class="RealTimeNovle" id="mainCenter_left">
                    <!-- onkeydown을 통해서 엔터키로도 입력되도록 설정. -->
                    <b align="center">모두와 채팅</b>
                    <div id="messageWindow2" style="padding: 10px 0; height: 332px; overflow: auto; background-color: #B5BFE5;"></div>
                    <div align="right">
                        <c:choose>
                            <c:when test="${Ldto.member_payrole eq 'Y'}">
                            <!-- 사용자가 입력한 키의 코드를 .d보내준다. -->
                                <input id="inputMessage" type="text" name="novel_content" onkeydown="if(event.keyCode==13){send();}" />
                                <input id="submitBtn" type="submit" value="입력" onclick="send();" />
                                <input type="hidden" id="member_id" value="${Ldto.member_id}" name="member_id" />
                            </c:when>
                            <c:otherwise>
                                <input id="inputMessage" class="form-control" type="text" readonly="readonly" value="로그인시 이용하실 수 있습니다"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                </div>
				
				</div>
			</div>
		</div>	
		<br><br>


	<!-- 인공지능을 활용한 책 카테고리 추천. -->
				<h3 style="text-align:center;">나에게 맞는 AI 책추천📖</h3>	
				<div id="aire_box">	
				<table id="airecommendbox">
					<tr>
						<td>
							<label>나이/성별/좋아하는 책 분류를 선택해주세요</label>													
						</td>
					</tr>				
				</table>				
				<table>
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
						<td><input id="aire_btn" type="button" value="추천받기"></td>			
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
							
					
					$("#aire_btn").click(function(){	
						
						var onecate;
						var twocate;
						var threecate;			
						
						if(id.trim() != ""){
							$age = $("select[name=age]").val();
							$mw = $("select[name=mw]").val();
							$category = $("select[name=category]").val();			
							
							$.getJSON("airecommend.do?age_mw="+$age+"_"+$mw+"&category="+$category, function(result){
								scorelist = result.list;
								scorelist.sort((a,b) => (a.score > b.score) ? -1 : ((a.score < b.score) ? 1 : 0));
								
								onecate = scorelist[0].category;
								twocate = scorelist[1].category;
								threecate = scorelist[2].category;
								
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
								
								$.getJSON("airecommendcate.do?onecate="+onecate+"&twocate="+twocate+"&threecate="+threecate, function(result){
									//console.log(result.list);
									//console.log(result.list[0].isbn);
									//console.log(result.list[1].isbn);
									//console.log(result.list[2].isbn);
									$aibox.text("");
									$aibox.append("<tr id='aire_cate_name'><td>"+one+"</td><td>"+two+"</td><td>"+three+"</td></tr>"+
											"<tr id='aire_book'><td><a href='recommendBook.do?title="+result.list[0].title+"&coverLargeUrl="+result.list[0].coverLargeUrl+
											"&isbn="+result.list[0].isbn+"&author="+result.list[0].author+"&categoryId="+result.list[0].categoryId+"'  target='_blank'>"
											+"<img src='"+result.list[0].coverLargeUrl+"'></a></td>"+
											"<td><a href='recommendBook.do?title="+result.list[1].title+"&coverLargeUrl="+result.list[1].coverLargeUrl+
											"&isbn="+result.list[1].isbn+"&author="+result.list[1].author+"&categoryId="+result.list[1].categoryId+"'  target='_blank'>"
											+"<img src='"+result.list[1].coverLargeUrl+"'></a></td>"+
											"<td><a href='recommendBook.do?title="+result.list[2].title+"&coverLargeUrl="+result.list[2].coverLargeUrl+
											"&isbn="+result.list[2].isbn+"&author="+result.list[2].author+"&categoryId="+result.list[2].categoryId+"'  target='_blank'>"
											+"<img src='"+result.list[2].coverLargeUrl+"'></a></td></tr>"+
											"<tr id='aire_scrap'><td><a href='scinsert.do?title="+result.list[0].title+"&coverLargeUrl="+result.list[0].coverLargeUrl+
											"&isbn="+result.list[0].isbn+"&author="+result.list[0].author+"&categoryId="+result.list[0].categoryId+"'  target='_blank'>&#127873; 찜하기</a></td>"+
											"<td><a href='scinsert.do?title="+result.list[1].title+"&coverLargeUrl="+result.list[1].coverLargeUrl+
											"&isbn="+result.list[1].isbn+"&author="+result.list[1].author+"&categoryId="+result.list[1].categoryId+"'  target='_blank'>&#127873; 찜하기</a></td>"+
											"<td><a href='scinsert.do?title="+result.list[2].title+"&coverLargeUrl="+result.list[2].coverLargeUrl+
											"&isbn="+result.list[2].isbn+"&author="+result.list[2].author+"&categoryId="+result.list[2].categoryId+"'  target='_blank'>&#127873; 찜하기</a></td></tr>"
									);
																		
									/*
									$aibox.append("<tr><td>추천 카테고리 1 : "+one+
											"<br><a href='recommendBook.do?title="+result.list[0].title+"&coverLargeUrl="+result.list[0].coverLargeUrl+
											"&isbn="+result.list[0].isbn+"&author="+result.list[0].author+"&categoryId="+result.list[0].categoryId+"'  target='_blank'>"
											+"<img src='"+result.list[0].coverLargeUrl+"'></a></td><td>"+ 
											"추천 카테고리 2 : "+two+
											"<br><a href='recommendBook.do?title="+result.list[1].title+"&coverLargeUrl="+result.list[1].coverLargeUrl+
											"&isbn="+result.list[1].isbn+"&author="+result.list[1].author+"&categoryId="+result.list[1].categoryId+"'  target='_blank'>"
											+"<img src='"+result.list[1].coverLargeUrl+"'></a></td><td>"+
											"추천 카테고리 3 : "+three+
											"<br><a href='recommendBook.do?title="+result.list[2].title+"&coverLargeUrl="+result.list[2].coverLargeUrl+
											"&isbn="+result.list[2].isbn+"&author="+result.list[2].author+"&categoryId="+result.list[2].categoryId+"'  target='_blank'>"
											+"<img src='"+result.list[2].coverLargeUrl+"'></a></td></tr>");
									*/
								});
								
							});
						} else {
							$aibox.text("");
							$aibox.text("로그인을 해야 사용할 수 있는 기능입니다.");
						}				
						
						
					});
				</script>
		
	
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
