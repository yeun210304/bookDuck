<%@page import="com.spring.bookduck.bookfm.dto.BookFMDto"%>
<%@page import="java.sql.Array"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.spring.bookduck.scrap.dto.ScrapDto"%>
<%@page import="com.spring.bookduck.rcvideo.dto.RcvideoDto"%>
<%@page import="com.spring.bookduck.model.dto.MemberDto"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck
</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!--SummerNote  -->
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.1/css/font-awesome.min.css" />

<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"></script>

<!-- <script>
	$(document).ready(function() {
		$('#summernote').summernote();
	});
</script> -->
<!-- Youtube 검색 -->
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script>
	//검색창 클릭시 얼럿
	function fnGetList(sGetToken) {
		var $getval = $("#search_box").val();
		if ($getval == "") {
			alert("검색어를 입력하세요.");
			$("#search_box").focus();
			return;
		}
		$("#get_view").empty();
		$("#nav_view").empty();
		//유튜브 API 불러오는부분
		//https://developers.google.com/youtube/v3/docs/search/list
		var order = "relevance";
		var maxResults = "3"; //검색 리스트 개수
		var key = "AIzaSyD5ZALqP1e8SkvfWL65oVDCHTUoibbtJGk";//api key값
		var sTargetUrl = "https://www.googleapis.com/youtube/v3/search?part=snippet&order="
				+ order
				+ "&q="
				+ encodeURIComponent($getval)
				+ "&key="
				+ key
				+ "&maxResults=" + maxResults;//검색해서 나온 url

		console.log(sGetToken);
		if (sGetToken != null) {
			sTargetUrl += "&pageToken=" + sGetToken + "";
		}
		console.log(sTargetUrl);
		$
		.ajax({
			type : "POST",
			url : sTargetUrl,
			dataType : "jsonp",
			success : function(jdata) {
				console.log(jdata);
				$(jdata.items)
						.each(
					function(i) {
					//console.log(this.snippet.channelId);
					$("#get_view")
					.append(
				//검색한 책목록을 ifram api 를 활용해서 영상을 띄운다
				'<iframe width="360" height="202.5"src="https://www.youtube.com/embed/'
					+this.id.videoId+'"title="YouTube video player" frameborder="0"allow="accelerometer; autoplay;clipboard-write; encrypted-media; gyroscope; picture-in-picture"allowfullscreen></iframe>');
					})
				.promise()
				.done(
			function() {//다음 동영상 목록을 열어주는 페이징
				if (jdata.prevPageToken) {
					$("#nav_view")
					.append(
					'<a href="javascript:fnGetList(\''
					+ jdata.prevPageToken
					+ '\');">◀ 이전 </a>');
					}
				if (jdata.nextPageToken) {
					$("#nav_view")
					.append(
					'<a href="javascript:fnGetList(\''
					+ jdata.nextPageToken
					+ '\');"> 다음 ▶</a>');
					}
				if (jdata.nextPageToken) {
					$("#refr_view").find("input").remove();
					$("#refr_view")
					.append(
				'<input type="button" value="닫기" onclick="refr();">');
				}
				});
			},
			error : function(xhr, textStatus) {
				console.log(xhr.responseText);
				alert("에러");
				return;
			}
		});
	}
	function refr() {
		window.location.reload();
	}
</script>


<script type="text/javascript">
	$(function() {
		// 별점
		$('.make_star svg').click(function() {
			var targetNum = $(this).index() + 1;
			$('.make_star svg').css({
				color : '#000'
			});
			$('.make_star svg:nth-child(-n+' + targetNum + ')').css({
				color : '#F05522'
			});
			console.log(targetNum);
			console.log(typeof (targetNum));

			//var targetNum = documemt.getElementById("starsave").innerHTML;
			document.getElementById('starsave').value = targetNum;
		});
		/*
		  $("#starsave").on("click",function(){
			   $.ajax({
			   type:'POST',
			   url: 'bookstarInsertRes.do',
			   data:{
			      bookstar_star: targetNum,
			    }
			   })
			  });
		 */
	});

	// 한줄 낭독
	var voices = [];
	
	/*
	var bookfmlist = document.getElementsByClassName("bookfmlist");
	console.log(bookfmlist);
	console.log(bookfmlist[0]);
	*/
	
	function setVoiceList() {
		voices = window.speechSynthesis.getVoices();
	}

	setVoiceList();
	if (window.speechSynthesis.onvoiceschanged !== undefined) {
		window.speechSynthesis.onvoiceschanged = setVoiceList;
	}

	function speech(txt) {

		if (!window.speechSynthesis) {
			alert("음성 재생을 지원하지 않는 브라우저입니다. 크롬, 파이어폭스 등의 최신 브라우저를 이용하세요.");
			return;
		}
		var lang = 'ko-KR';
		var utterThis = new SpeechSynthesisUtterance(txt);
		utterThis.onend = function(event) {
			console.log('end');
		};
		utterThis.onerror = function(event) {
			console.log('error', event);
		};
		var voiceFound = false;
		for (var i = 0; i < voices.length; i++) {
			if (voices[i].lang.indexOf(lang) >= 0
					|| voices[i].lang.indexOf(lang.replace('-', '_')) >= 0) {
				utterThis.voice = voices[i];
				voiceFound = true;
			}
		}
		if (!voiceFound) {
			alert('voice not found');
			return;
		}
		utterThis.lang = lang;
		utterThis.pitch = 0.8; 	// 0.4 ~ 1.0
		utterThis.rate = 0.9; 	// 속도 0.7 괜춘

		window.speechSynthesis.speak(utterThis);

	}

	
	// 한 줄 낭독 시작 
	function speak() {
		var t = document.getElementById("ttsspeak");
		speech(t.innerHTML);
		// 다시 시작
		window.speechSynthesis.resume();
	}
	
	// 정지
	function stop() {
		window.speechSynthesis.pause();
	}

	// 페이지 나가면 정지됨
	$(window).on("beforeunload", function() {
		window.speechSynthesis.cancel();
	});
	
</script>
<style type="text/css">
	
	div{
	width: 100%;
	}
	
	/* 좌우 나누기 */
	div #left{
	width : 18%;
	float: left;
	padding-top : 50px;
	margin : 0px auto;
	padding-left: 0px; 
	text-align: center;
	}
	
	div #right{
	width : 77%;
	float: right;
	padding-top : 50px;
	margin : 0px auto;
	}
	
	/* 페이지 영역 나누는 중 */
	/*
	#star{
	padding : 10px 0px 10px 0px;
	}
	
	#tts{
	padding : 10px 0px 10px 0px;
	}
	
	#make_star{
	padding : 10px;
	}
	
	#bookdetail{
	padding : 15px 10px 10px 10px;
	text-align: center;
	}
	
	#yourstar{
	padding : 13px;
	text-align: center;
	}
	
	#stardetail{
	text-align: center;
	}
	
	#ttsdetail{
	padding : 0px 5px 5px 18px;
	text-align: center;
	}
	*/
	textarea{
	width:290px; 
	height:90px;
	resize:none;
	}
	
	/*
	#imgadd{
	height : 50%;
	bottom : 10px;
	padding : 20px 0px 0px 0px;	
	}
	
	#youtubesearch{
	height: 50%;
	}
	*/
	
	
	
	
	
	
	
	
	
	
	/* 책 정보, 별점, 한 줄 낭독 hover시 보이는 css */
	nav a {
		position: relative;
		width: 33.333%;
		text-align: center;
		color: #949494;
		text-decoration: none;
		font-weight: bold;
		padding: 10px 20px;
		transition: 0.2s ease color;
	}
	
	nav a:before, nav a:after {
		content: "";
		position: absolute;
		border-radius: 50%;
		transform: scale(0);
		transition: 0.2s ease transform;
	}
	
	nav a:before {
		top: 0;
		left: 10px;
		width: 6px;
		height: 6px;
	}
	
	nav a:after {
		top: 5px;
		left: 18px;
		width: 4px;
		height: 4px
	}
	
	nav a:nth-child(1):before {
		background-color: yellow;
	}
	
	nav a:nth-child(1):after {
		background-color: red;
	}
	
	nav a:hover {
		color: #F5DC7A;
	}
	
	nav a:hover:before, nav a:hover:after {
		transform: scale(1);
	}
	
	nav a:nth-child(1):hover ~ #indicator {
		background: linear-gradient(130deg, yellow, red);
	}
	
	/* 동영상, 이미지 정렬 css */
		
	#selectimglist tr {
		border-bottom: 20px solid #FDF7DD;
	}
	
	#selectrclist tr{
		border-bottom: 20px solid #FDF7DD;
	}
	
	#selectimglist tbody{
		text-align:center;
	}
	
	.videodbtn input{
		border:0px;
		background-color:#FDF7DD;
		margin-top:-100px;
		font-size:10px;
		color:#052696;
		border-radius:10px;
	}
	
	.videodbtn input:hover{
		color:red;
		border-radius:15px;
	}
	
	.imgdbtn input {
		border:0px;
		background-color:#FDF7DD;
		margin-top:0px;
		font-size:20px;
		color:#FDF7DD;
		border-radius:10px;
	}
	
	.imgdbtn input:hover{
		color:red;
		border-radius:15px;
	}
	
	
	/* 검색 태그 버튼 css */
	
	#search_box {
		border: 0px;
		width : 250px;
		font-size:15px;
		margin-top:5px;
		border-radius:10px;
		text-indent : 10px;
		margin-bottom:8px;
		padding:5px;
		padding-top:7px;
	}
	#search_box:focus{
		outline: none;
		border-bottom : 1px solid #6277BA;
		box-shadow: 4.5px 4.5px #B5BFE5;
	}	
	#search_box_btn {
		border: 0px;
		border-radius:15px;
		background-color:#052696;
		color:white;
		font-size:13px;
		margin-left:10px;
	}
	
	#youtubeurl {
		border: 0px;
		width : 280px;
		font-size:16px;
		margin-top:5px;
		border-radius:10px;
		text-indent : 10px;
		margin-bottom:8px;
		padding:5px;
		padding-top:7px;
	}
	#youtubeurl:focus{
		outline: none;
		border-bottom : 1px solid #6277BA;
		box-shadow: 4.5px 4.5px #B5BFE5;
	}	
	#youtubeurl_btn {
		border: 0px;
		border-radius:15px;
		background-color:#052696;
		color:white;
		font-size:13px;
		margin-left:10px;
	}
	
	#imgurl {
		border: 0px;
		width : 280px;
		font-size:16px;
		margin-top:5px;
		border-radius:10px;
		text-indent : 10px;
		margin-bottom:8px;
		padding:5px;
		padding-top:7px;
	}
	#imgurl:focus{
		outline: none;
		border-bottom : 1px solid #6277BA;
		box-shadow: 4.5px 4.5px #B5BFE5;
	}	
	#imgurl_btn {
		border: 0px;
		border-radius:15px;
		background-color:#052696;
		color:white;
		font-size:13px;
		margin-left:10px;
	}
	
	
	/* 이미지나 동영상이 없을때 빈공간 css */
	
	.emptyspace {
		height: 250px;
		background-color:#F5F5DC;
		text-align:center;
		color:#483D8B;
		font-size:17px;
	}	
	
	
	/* 왼쪽에 별점 한줄낭독 버튼 css */
	
	#stardetail button {
		border:0px;
		background-color:#6277BA;
		border-radius:10px;
		font-size:13px;
		color:white;
	
	}
	
	#ttsdetail_sub_btn{
		border:0px;
		background-color:#6277BA;
		border-radius:10px;
		font-size:10px;
		color:white;
		margin-top:5px;
	}
	
	#tts_speak_btn{
		border:0px;
		background-color:#6277BA;
		border-radius:10px;
		font-size:15px;
		color:white;
		margin-top:5px;
		margin-left:15px;
	}
	
	#tts_stop_btn{
		border:0px;
		background-color:#6277BA;
		border-radius:10px;
		font-size:15px;
		color:white;
		margin-top:5px;
		margin-left:7px;
	}
	
	
	/* 동영상 검색 하고나서 css*/
	#nav_view{
		text-align:center;
		font-size:17px;
	}
	#nav_view a{
		text-decoration: none;
		color:#052696;
		margin-left:10px;
	}	
	#nav_view a:link{
		text-decoration: none;	
		color:#052696;
	}
	
	#refr_view{
		text-align:right;
	}
	#refr_view input{
		border: 0px;
		border-radius:15px;
		background-color:#052696;
		color:white;
		font-size:15px;
	}
	
	#get_view iframe{
		margin-left:5px;	
	}
	
	
	/*이미지 파일 위치조정*/
	#imgurllist img{
		
	}
	
	
	body {
		background-color:#FDF7DD;
	}
	
	
	
	#test {
		clear:both;
	}
	
	
	
	

	
</style>
<style type="text/css">
/* CSS */
.Blog .grid-image {
    display:flex;
    flex-wrap:wrap;
    align-items:flex-start;
    margin:30px 0;
}
.Blog .grid-image img {
    width:calc(33.333% - 10px);
    margin:0 15px 15px 0;
}
.Blog .grid-image img:nth-of-type(3n),
.Blog .grid-image img:last-child {
    margin-right:0;
}
@media screen and (max-width:640px){
  .Blog .grid-image img {
    width:calc(50% - 15px);
  }
}
@media screen and (max-width:480px){
  .Blog .grid-image img:nth-of-type(2n) {
    margin-right:0;
  }
  .Blog .grid-image img:nth-of-type(3n) {
    margin-right:15px;
  }
}

</style>


</head>
<body>

	<jsp:include page="../header.jsp"/>
	<div id="test"></div>
	<%
	request.setCharacterEncoding("UTF-8");

	MemberDto dto1 = (MemberDto) session.getAttribute("Ldto");
	RcvideoDto rcdto = new RcvideoDto();
	
	//절대경로 확인
	String path = request.getContextPath();

	String coverLargeUrl = request.getParameter("coverLargeUrl");
	String title = request.getParameter("title");
	String isbn = request.getParameter("isbn");
	String author = request.getParameter("author");
	String categoryId = request.getParameter("categoryId");

	String id = dto1.getMember_id();
	System.out.println(dto1.getMember_id());
	List<RcvideoDto> rclist = (List<RcvideoDto>) request.getAttribute("rclist");

	if (title == null) {
		ScrapDto scdto = (ScrapDto) request.getAttribute("scrapDto");
		coverLargeUrl = scdto.getBook_coverLargeUrl();
		title = scdto.getBook_title();
		isbn = scdto.getBook_isbn();
		author = scdto.getBook_author();

		categoryId= scdto.getBook_categoryId();
		
		/*
		categoryId = scdto.getBook_categoryId();
		System.out.println(rclist);
		System.out.println("-----------");
		System.out.println(coverLargeUrl);
		System.out.println(title);
		System.out.println(isbn);
		System.out.println(author);
		System.out.println(categoryId);
		*/
	}

	if (title == null) {
		coverLargeUrl = (String) request.getAttribute("coverLargeUrl");
		title = (String) request.getAttribute("title");
		isbn = (String) request.getAttribute("isbn");
		author = (String) request.getAttribute("author");
		categoryId = (String) request.getAttribute("categoryId");
	}
	
	// 한 줄 낭독 테스트
	List<BookFMDto> fm = (List<BookFMDto>)request.getAttribute("rowlist");
	//System.out.println(fm.get(0).getBookfm_fm());
	
 	/*
	BookFMDto fm = (BookFMDto)request.getAttribute("rowlist");
	System.out.println(fm.getBookfm_fm());
	*/
%>
	<!-- 헤더 -->
      
	<div class="content">
	
      
		<!-- 왼쪽 시작  -->
		<div id="left" style="margin:0px;">
		<!-- 도서 정보 -->
		<div id="book">
			<nav style="text-align: left; padding:10px;">
				<a href="#">&nbsp;도서 정보</a>
			</nav>
			<!-- 책 제목, 저자 -->
			<div id="bookdetail">
			<img src="<%=coverLargeUrl %>"><br/><br/>
			<b><%=title %></b><br/><%=author %><br/>
			</div>
		</div><br/><br/>
	
		<!-- 별점 -->
		<div id="star">
			<nav style="text-align: left; padding:10px;">
				<a href="#">&nbsp;별점</a>
			</nav>
			<div id="yourstar">
				<b>당신의 별점은?</b> (평균 :  ${staravgg } 점)
			</div>
			<div id="stardetail">
			<form action="bookstarInsertRes.do" method="post">
					<input type="hidden" name="coverLargeUrl" value="<%=coverLargeUrl %>">
					<input type="hidden" name="title" value="<%=title %>">
					<input type="hidden" name="author" value="<%=author %>">
					<input type="hidden" name="isbn" value="<%=isbn %>">
					<input type="hidden" name="categoryId" value="<%=categoryId %>">
					
					
					<input type="hidden" name="bookstar_id" value="<%=id %>">
					<input type="hidden" name="bookstar_title" value="<%=title %>">
					<input type="hidden" name="bookstar_isbn" value="<%=isbn %>">
					<input type="hidden" id="starsave" name="bookstar_star">
					
				<div class="make_star">
					<div class="rating" data-rate="3" >
						<i class="fas fa-star fa-2x"></i> <i class="fas fa-star fa-2x"></i> <i
							class="fas fa-star fa-2x"></i> <i class="fas fa-star fa-2x"></i> <i
							class="fas fa-star fa-2x"></i>
					</div>
				</div>
				<br/>
				<button type="submit"  class='btn btn-default btn-xs' style="float: right;">&#127775;&nbsp;별점등록&nbsp;</button>	
			</form>
			</div>
			</div>
      
				<br />
				<!--찜한사람  -->
				<table class="table table-hover">
								<col width="100" />
								<tr>
									<th>찜한 회원 </th>
								</tr>
								<c:choose>
									<c:when test="${empty scidlist }">
										<tr>
											<td colspan="3" align="center">찜한 사람이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${scidlist }" var="scrapDto">
											<tr>
												<td>
												<a href="mypage.do?member_id=${scrapDto.scrap_id}&member_payrole=${Ldto.member_payrole}">
												 <!-- <a href="mypage.do?member_id=${scrapDto.scrap_id }">${scrapDto.scrap_id }  -->
												${scrapDto.scrap_id}
												</a></td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</table>

				<br /><br/>

			
		<!-- <h4>한줄낭독</h4> -->
		<div id="tts">
		<nav style="text-align:left; padding:10px; margin-left:-10px;">
			<a href="#">한 줄 낭독</a>
		</nav>
		
		<div id="ttsdetail">
			<form action="bookfmInsertRes.do" method="post">
				<input type="hidden" name="coverLargeUrl" value="<%=coverLargeUrl %>">
				<input type="hidden" name="title" value="<%=title %>">
				<input type="hidden" name="author" value="<%=author %>">
				<input type="hidden" name="isbn" value="<%=isbn %>">
				<input type="hidden" name="categoryId" value="<%=categoryId %>">
				
				<table>
					<tr>
						<td><input type="hidden" name="bookfm_isbn" value="<%=isbn %>" readonly ></td>
					</tr>
					<tr>
						<td><input type="hidden" name="bookfm_title" value="<%=title %>" readonly></td>
					</tr>
					<tr>
						<td><input type="hidden" name="bookfm_author" value="<%=author %>" readonly ></td>
					</tr>
					<tr>
						<td colspan="3"><textarea name="bookfm_fm" required></textarea></td>
					</tr>
					<tr>
						<td colspan="2" align="right">
							<input id="ttsdetail_sub_btn" type="submit" class='btn btn-default btn-xs' style="text-align: center;" value="등록">
						</td>
					</tr>
				</table>
			</form>

				<div>
					<div id="ttsspeak" style="display: none;">
						<c:choose>
							<c:when test="${empty rowlist}">등록된 정보가 없습니다. 한 줄을 등록해주세요.</c:when>
							<c:otherwise>
								<c:forEach items="${rowlist }" var="dto">
									<div class="bookfmlist">
										${dto.bookfm_fm}
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
					
					<button id="tts_speak_btn" onclick="speak()" type="button" class='btn btn-default'>&#128265;&nbsp;<b>SPEAK IT!</b></button>
					<button id="tts_stop_btn" onclick="stop()" type="button" class='btn btn-default'>&#128263;&nbsp;<b>STOP IT!</b></button>
				</div>
			</div>
		</div>
	</div>
	<!-- 왼쪽 부분 끝나는 곳 -->


	<!-- 오른쪽 부분 시작 -->
	<div id="right" style="margin:0px;">
	<div id="youtubesearch" style="float: inherit;">
		<nav>
			<a href="#">▶ 동영상 검색</a>
		</nav>
		<%--/////////////youtube 동영상 검색 단 /////////////// --%>
		<form name="form1" method="post" onsubmit="return false;">
			<input type="text" id="search_box" placeholder="동영상을 검색하세요">
			<button id="search_box_btn" onclick="fnGetList();">검색</button>
		</form>
		<div id="get_view"></div>
		<div id="nav_view"></div>
		<div id="refr_view"></div>
		<br />
	
	<div>
		<%-- 	<c:choose>
                    <c:when test="${empty rclist}">
                        <c:choose>
                            <c:when test="${empty Ldto }"></c:when>
                            <c:otherwise>
                                <table>
                                    <tr>
                                        <td>
                                        <iframe width="560" height="315" src="https://www.youtube.com/embed/6NZREGmnubw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                                        <input type="button" value="동영상 등록하기" onclick="location.href='rcinsertres.do?rcinsertres.do?title=<%=title%>&coverLargeUrl=<%=coverLargeUrl%>&isbn=<%=isbn%>&author=<%=author%>&categoryId=<%=categoryId%>'">
                                        </td>
                                    </tr>
                                </table>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${rclist}" var="rcvideoDto">
                            <table>
                                <tr>
                                    <td id="summernote">${rcvideoDto.rcvideo_content}</td>
                                    
                                </tr>
                            </table>
                            <c:choose>
								<c:when test="${empty Ldto }">
                                    <table>
                                        <tr>
                                            <td>로그인 하세요</td>
                                        </tr>
                                    </table>
                                </c:when>
                                <c:otherwise>
                                    <table>
                                        <tr>
                                            <td><input type="button" value="수정"
                                                onclick="location.href='updatercvideores.do?rcvideo_no=${rcvideoDto.rcvideo_no}&title=<%=title%>&coverLargeUrl=<%=coverLargeUrl %>&isbn=<%=isbn %>&author=<%=author %>&categoryId=<%=categoryId%>'">
                                                <input type="button" value="삭제"
                                                onclick="location.href='deletercvideo.do?rcvideo_no=${rcvideoDto.rcvideo_no}&title=<%=title%>&coverLargeUrl=<%=coverLargeUrl %>&isbn=<%=isbn %>&author=<%=author %>&categoryId=<%=categoryId%>'">
                                            </td>
                                        </tr>
                                    </table>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
			</div>
		</div>
 --%>

		<nav>
			<a href="#">▶ 동영상 등록</a>
		</nav>		
		<table id="selectrclist">
			<col width="360px;">
			<col width="10px;">
			<col width="360px;">
			<col width="10px;">
			<col width="360px;">
			<col width="10px;">
			<thead>
			<tr>
				<td colspan="2">
				<input type="text" id="youtubeurl" placeholder="youtube URL을 입력해 주세요">
				<input id="youtubeurl_btn" type="button"  value="등록" onclick="urlinsert();">
				</td>
			</tr>
			</thead>
			<tbody id="youtubeurllist">
				
			</tbody>
		</table>
		
		<script type="text/javascript">
			var isbn =<%=isbn %>
			var content = 0;

			function selectrclist() {
				$
				.ajax({
				type : "post",
				url : "rcvideolist.do",
				data : {
				"book_isbn" : isbn
					},
				success : function(data) {
					content = data.list.length					
					var value = "";
					$.each(
				data.list,
		function(i, obj) {
				if(i%3 == 0){
					value += "<tr>"
						+ "<td>"
						+ "<iframe width='360' height='202.5' src='https://www.youtube.com/embed/"+obj.rcvideo_content +"' title='YouTube video player' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe></td>"
						+"<td class='videodbtn'>"
	                       + "<input type='button' value='X' onclick='urldelete("+obj.rcvideo_no+");'>"
	                    +"</td>";	          				
				} else if(i%3 == 1) {
					value += "<td>"
						+ "<iframe width='360' height='202.5' src='https://www.youtube.com/embed/"+obj.rcvideo_content +"' title='YouTube video player' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe></td>"
						+"<td class='videodbtn'>"
	                       + "<input type='button' value='X' onclick='urldelete("+obj.rcvideo_no+");'>"
	                    +"</td>";	                		
				} else {
					value += "<td>"
						+ "<iframe width='360' height='202.5' src='https://www.youtube.com/embed/"+obj.rcvideo_content +"' title='YouTube video player' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe></td>"
						+"<td class='videodbtn'>"
	                       + "<input type='button' value='X' onclick='urldelete("+obj.rcvideo_no+");'>"
	                    +"</td>"
	                	+"</tr>";						
				}
					
				
				});
				if(content == 0){					
						var context = "<tr class='emptyspace'>"+"<td>"
						+"추천하는 동영상을<br/>등록해주세요"						
						+"</td>"+"</tr>";
						$("#selectrclist tbody").html(context);
				} else {
					$("#selectrclist tbody").html(value);
				}
					
				
							},
							error : function() {
							}
						});
			}
			function urlinsert() {
				var url = $("#youtubeurl").val().substring(17);
				$.ajax({
					type : "post",
					url : "rcvideoinsert.do",
					data : {
						"book_isbn" : isbn,
						"rcvideo_content" : url
					},
					success : function(data) {
						if (data > 0) {
							$("#youtubeurl").val("")
							selectrclist();
						} else {
							alert('실패..')
						}
					},
					error : function() {
						alert('video ajax 오류..')
					}

				});

			}
			function urldelete(rcvideo_no) {
				$.ajax({
					type : "post",
					url : "deleterc.do",
					data : {
						"rcvideo_no" : rcvideo_no	
					},
					success : function (data) {
						if(data == "1"){
							url = "";
						selectrclist();
						}else{
							
							alert('삭제 실패...다시해라..')
						}
					},
					error : function() {
						alert('video 삭제 ajax 오류..')
					}

					
					});
				
			}
			$(function() {
				console.log(isbn)

				selectrclist();

			});
		</script>
		</div>
		
		<br/><br/>
		</div>
		
	<!-- 이미지 업로드 -->
	
		<div id="imgadd">
		<table id="selectimglist">
			<col width="360px;">
			<col width="10px;">
			<col width="360px;">
			<col width="10px;">
			<col width="360px;">
			<col width="10px;">
		<nav>
			<a href="#">▶ 이미지 등록</a>
		</nav>
			<thead>
			<tr>
				<td>
				<input type="text" id="imgurl" placeholder="img URL을 입력해 주세요">
				<input id="imgurl_btn" type="button" value="등록" onclick="imginsert();">
				</td>
			</tr>
			</thead>
			<tbody id="imgurllist">
			</tbody>
		</table>
		<script type="text/javascript">
			var isbn =<%=isbn %>
			var content = 0;

			function selectimglist() {
				$
				.ajax({
				type : "post",
				url : "rcimglist.do",
				data : {
				"book_isbn" : isbn
					},
				success : function(data) {
					content = data.list.length		
					var value = "";
					$.each(
				data.list,
		function(i, obj) {					
				if(i%3 == 0){
					value += "<tr>"
						+ "<td>"
						+ "<img style='width:360px;' src="+obj.rcimg_content +"></td>"
	                    +"<td class='imgdbtn'>"
	                       + "<input type='button' value='X' onclick='rcimgdelete("+obj.rcimg_no+");'>"
	                    +"</td>";
	                	
				} else if(i%3 == 1){
					value += "<td>"
						+ "<img style='width:360px;' src="+obj.rcimg_content +"></td>"
	                    +"<td class='imgdbtn'>"
	                       + "<input type='button' value='X' onclick='rcimgdelete("+obj.rcimg_no+");'>"
	                    +"</td>";	                		
				} else {
					value += "<td>"
						+ "<img style='width:360px;' src="+obj.rcimg_content +"></td>"
	                    +"<td class='imgdbtn'>"
	                       + "<input type='button' value='X' onclick='rcimgdelete("+obj.rcimg_no+");'>"
	                    +"</td>"
	                	+"</tr>";		
				}
					
				
				
				});
				if(content == 0){					
						var context = "<tr class='emptyspace'>"+"<td>"
						+"추천하는 이미지를<br>등록해주세요"						
						+"</td>"+"</tr>";
						$("#selectimglist tbody").html(context);
				} else {
					$("#selectimglist tbody").html(value);
				}	
					
				
							},
							error : function() {
							}
						});
			}
			function imginsert() {
				var url = $("#imgurl").val();
				$.ajax({
					type : "post",
					url : "rcimginsert.do",
					data : {
						"book_isbn" : isbn,
						"rcimg_content" : url
					},
					success : function(data) {
						if (data > 0) {
							$("#imgurl").val("")
							selectimglist();
						} else {
							alert('실패..')
						}
					},
					error : function() {
						alert('이미지 ajax 오류..')
					}

				});

			}
			function rcimgdelete(rcimg_no) {
				$.ajax({
					type : "post",
					url : "rcimgdelete.do",
					data : {
						"rcimg_no" : rcimg_no	
					},
					success : function (data) {
						if(data > 0){
							url = "";
						selectimglist();
						}else{
							
							alert('이미지 삭제 실패...다시해라..')
						}
					},
					error : function() {
						alert('img 삭제 ajax 오류..')
					}

					
					});
				
			}
			$(function() {
				console.log(isbn)

				selectimglist();

			});
		</script>
		</div>
		</div>
	</div>
	<!-- 오른쪽 부분 끝나는 곳  -->

	
</body>
</html>