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
<title>도서추천</title>
<style type="text/css">
</style>
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

<script>
	$(document).ready(function() {
		$('#summernote').summernote();
	});
</script>
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
		var maxResults = "6"; //검색 리스트 개수
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
				'<iframe width="320" height="180"src="https://www.youtube.com/embed/'
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
					+ '\');"><이전페이지></a>');
					}
				if (jdata.nextPageToken) {
					$("#nav_view")
					.append(
					'<a href="javascript:fnGetList(\''
					+ jdata.nextPageToken
					+ '\');"><다음페이지></a>');
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
	function setVoiceList() {
		voices = window.speechSynthesis.getVoices();
	}

	setVoiceList();
	if (window.speechSynthesis.onvoiceschanged !== undefined) {
		window.speechSynthesis.onvoiceschanged = setVoiceList;
	}

	function speech(txt) {

		if (!window.speechSynthesis) {
			alert("음성 재생을 지원하지 않는 브라우저입니다. 크롬, 파이어폭스 등의 최신 브라우저를 이용하세요");
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
		utterThis.pitch = 0.8; // 0.4 ~ 1.0
		utterThis.rate = 0.9; //속도 0.7 괜춘
		window.speechSynthesis.speak(utterThis);

	}

	function speak() {
		var t = document.getElementById("ttsspeak");
		speech(t.innerHTML);
	}
</script>
</head>
<body>
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
		categoryId = scdto.getBook_categoryId();

		System.out.println(rclist);
		System.out.println("-----------");
		System.out.println(coverLargeUrl);
		System.out.println(title);
		System.out.println(isbn);
		System.out.println(author);
		System.out.println(categoryId);
	}

	if (title == null) {
		coverLargeUrl = (String) request.getAttribute("coverLargeUrl");
		title = (String) request.getAttribute("title");
		isbn = (String) request.getAttribute("isbn");
		author = (String) request.getAttribute("author");
		categoryId = (String) request.getAttribute("categoryId");
	}
	/*
	BookFMDto fm = (BookFMDto)request.getAttribute("rowlist");
	System.out.println("테스트중");
	System.out.println(fm.getBookfm_fm());
	*/
	%>

	<jsp:include page="../header.jsp" />



	<div class="content">
		<div class="innerOuter">
			<div id="book">
				<h3>책정보</h3>
				<img src="<%=coverLargeUrl%>"><br /> <br /> <b><%=title%></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=author%><br />

			</div>
			<br />


			<div id="star" style="float: left; width: 50%; padding: 10px;">
				<h3>별점</h3>
				<b>당신의 별점은?</b> (평균 : ${staravgg } 점) <br />
				<form action="bookstarInsertRes.do" method="post">
					<input type="hidden" name="coverLargeUrl"
						value="<%=coverLargeUrl%>"> <input type="hidden"
						name="title" value="<%=title%>"> <input type="hidden"
						name="author" value="<%=author%>"> <input type="hidden"
						name="isbn" value="<%=isbn%>"> <input type="hidden"
						name="categoryId" value="<%=categoryId%>"> <input
						type="hidden" name="bookstar_id" value="<%=id%>"> <input
						type="hidden" name="bookstar_title" value="<%=title%>"> <input
						type="hidden" name="bookstar_isbn" value="<%=isbn%>"> <input
						type="hidden" id="starsave" name="bookstar_star">



					<div class="make_star">
						<div class="rating" data-rate="3">
							<i class="fas fa-star fa-2x"></i> <i class="fas fa-star fa-2x"></i>
							<i class="fas fa-star fa-2x"></i> <i class="fas fa-star fa-2x"></i>
							<i class="fas fa-star fa-2x"></i>
						</div>
					</div>
					<button type="submit" class='btn btn-default btn-xs'>&#127775;&nbsp;별점등록</button>
				</form>


			</div>
			<br />

			<div id="tts" style="float: left; width: 50%; padding: 10px;">
				<h3>한줄낭독</h3>
				<div style="display: none">보이나욤</div>

				<div>
					<form action="bookfmInsertRes.do" method="post">
						<input type="hidden" name="coverLargeUrl"
							value="<%=coverLargeUrl%>"> <input type="hidden"
							name="title" value="<%=title%>"> <input type="hidden"
							name="author" value="<%=author%>"> <input type="hidden"
							name="isbn" value="<%=isbn%>"> <input type="hidden"
							name="categoryId" value="<%=categoryId%>">


						<table>
							<tr>
								<td><input type="hidden" name="bookfm_isbn"
									value="<%=isbn%>" readonly></td>
							</tr>
							<tr>
								<td><input type="hidden" name="bookfm_title"
									value="<%=title%>" readonly></td>
							</tr>
							<tr>
								<td><input type="hidden" name="bookfm_author"
									value="<%=author%>" readonly></td>
							</tr>
							<tr>
								<td colspan="3"><textarea name="bookfm_fm" required></textarea></td>
							</tr>
							<tr>
								<td colspan="2" align="right"><input type="submit"
									class='btn btn-default btn-xs' value="등록"></td>
							</tr>
						</table>
					</form>

					<div>
						<div id="ttsspeak" style="display: none;">
							<c:choose>
								<c:when test="${empty rowlist}">등록된 정보가 없습니다. 한 줄을 등록해주세요.</c:when>
								<c:otherwise>
									<c:forEach items="${rowlist }" var="dto">
								${dto.bookfm_fm}
							</c:forEach>
								</c:otherwise>
							</c:choose>
						</div>

						<button onclick="speak()" type="button" class='btn btn-default'>&#128265;&nbsp;SPEAK
							IT!</button>
					</div>
				</div>
			</div>
			<br/><br/><br/>
			<div>
				<div id="youtubesearch" style="float: inherit;">
					<%--/////////////youtube 동영상 검색 단 /////////////// --%>
					<form name="form1" method="post" onsubmit="return false;">
						<input type="text" id="search_box" placeholder="동영상을 검색하세요">
						<button onclick="fnGetList();">검색</button>
					</form>
					<div id="get_view"></div>
					<div id="nav_view"></div>
					<br />
				</div>
				<c:choose>
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
	</div>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
</body>
</html>