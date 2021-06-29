<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.spring.bookduck.scrap.dto.ScrapDto"%>
<%@page import="com.spring.bookduck.rcvideo.dto.RcvideoDto"%>
<%@page import="com.spring.bookduck.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>책추천</title>
<style type="text/css">
</style>
<!--SummerNote  -->
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script>
	$(document).ready(function() {
		$('#summernote').summernote();
	});
</script>
<!-- Youtube 검색 -->
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
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
		var maxResults = "8"; //검색 리스트 개수
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
	
	List<RcvideoDto> rclist = (List<RcvideoDto>)request.getAttribute("rclist");
	
	
	if(title==null){
		ScrapDto scdto = (ScrapDto)request.getAttribute("scrapDto");
		coverLargeUrl= scdto.getBook_coverLargeUrl();
		title = scdto.getBook_title();
		isbn= scdto.getBook_isbn();
		author = scdto.getBook_author();
		categoryId= scdto.getBook_categoryId();
		
		System.out.println(rclist);
		
	}
	
	
	
	%>
	<div id="book">
		<b>책정보</b><br /> <img src="<%=coverLargeUrl%>"><br />
		<%=title%>&nbsp;<%=author%><br />
		<%=isbn%><br />
		<%=categoryId%>
	</div>
	<br />

	<div id="star">
		<b>별점</b>

	</div>
	<br />

	<div id="tts">
		<b>한줄낭독</b>
	</div>
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
	<div>
		<c:choose>
			<c:when test="${empty rclist}">
				<table>
					<tr>
						<td colspan="1" align="center"
							onclick="location.href='rcinsertres.do?rcinsertres.do?title=<%=title%>&coverLargeUrl=<%=coverLargeUrl %>&isbn=<%=isbn %>&author=<%=author %>&categoryId=<%=categoryId%>'">
						 	추천 동영상을 등록해 주세요</td>
					</tr>
				</table>
			</c:when>
			<c:otherwise>
			
			<table>
				<tr>
					<th>추천 영상</th>
				</tr>
				<c:forEach items="${rclist}" var="rcvideoDto">
					<tr>
						<td id="summernote">${rcvideoDto.rcvideo_content}</td>
					</tr>
				<tr>
					<td><input type="button" value="수정"
						onclick="location.href='updatercvideores.do?rcvideo_no=${rcvideoDto.rcvideo_no}'">
						<input type="button" value="삭제"
						onclick="location.href='deletercvideo.do?rcvideo_no=${rcvideoDto.rcvideo_no}'">
					</td>
				</tr>
				</c:forEach>
			</table>
			</c:otherwise>
		</c:choose>
		
	</div>

</body>
</html>