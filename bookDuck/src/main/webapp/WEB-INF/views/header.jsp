<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>
<link href="css/header.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript">
	function autotext(booklist) {
		console.log(booklist);
		var text = document.getElementById("value");
		text.value = booklist;
	}
</script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						// ajax 통신으로 만든 헤더 검색 (현재 안쓰는 코드) 
						$("#sear")
								.click(
										function() {

											var value = document
													.getElementById("headervalue").value;
											console.log(value);
											$
													.ajax({

														url : "booksearch.do",
														type : "post",
														data : {
															"value" : value,
															"key" : "title",
															"start" : "1",
															"target" : "book",
															"sort" : "accuracy"
														},

														success : function(data) {
															//location.href = "booksearch.do"
															location.href = "booksearch.do?value="
																	+ value
																	+ "&key=title&start=1&target=book&sort=accuracy";
															//console.log("검색");
															//console.log(data);
															//const formdata = new FormData();
															//formdata.append(data);
															/*
															$("#header").hide();
															var arr = data.split('<');
															console.log(arr);

															var value = "";
															
															for(var i=106; i < arr.length; i++){
																value += '<'+arr[i]
															};
															
															var value2 = value.split("<ul class=");
															
															$("#bo").html(value);
															 */
														},
														error : function() {
															console
																	.log("검색 실패");
														}
													});
										});
						/*
						$("#value")
								.on(
										"propertychange change keyup paste input",
										function() {
											var booklist = [];

											if ($(this).val() !== ""
													&& $(this).val().trim() !== "") {
												var search = $(this).val();

												$
														.getJSON(
																"classifybookajax.do?search="
																		+ search,
																function(result) {
																	// console.log(list);
																	if (booklist.length !== 0) {
																		booklist = [];
																	}
																	booklist = result.list;
																	//console.log(booklist);

																	var $add = $(
																			"#value")
																			.parent()
																			.parent();

																	for (var i = 0; i < booklist.length; i++) {
																		$add
																				.find(
																						'a')
																				.remove();
																		$add
																				.find(
																						'.headerallsearch')
																				.remove();
																		$add
																				.append('<div class="headerallsearch"></div>')
																		for (var i = 0; i < booklist.length; i++) {
																			$add
																					.find(
																							'div')
																					.append(
																							"<a href='javascript:autotext(\""
																									+ booklist[i]
																									+ "\")'>"
																									+ ((booklist[i].length > 13) ? booklist[i]
																											.substring(
																													0,
																													12)
																											+ "...</a><br/>"
																											: booklist[i]
																													+ "</a><br/>"));
																		}
																	}
																});

											} else {
												$("#value").parent().parent()
														.find('a').remove();
												$("#value")
														.parent()
														.parent()
														.find(
																'.headerallsearch')
														.remove();
											}
										});

						$("body").click(
								function() {
									$("#value").parent().parent().find('a')
											.remove();
									$("#value").parent().parent().find(
											'.headerallsearch').remove();
								});
						*/
						// 호버시 h1 이벤트 해제 연습중 
						$(".sub").hover(function() {
							$(".e").unbind("");
							$("#h1").unbind("");
						});

					});

	/*
	function headsearch() {
		var value = document.getElementById("headervalue").value;
		location.href = "booksearch.do?value=" + value + "&key=title&start=1&target=book&sort=accuracy";

	} 
	 */

	// 검색 
	function searchToggle(obj, evt) {
		var container = $(obj).closest('.search-wrapper');
		if (!container.hasClass('active')) {
			container.addClass('active');
			evt.preventDefault();
		} else if (container.hasClass('active')
				&& $(obj).closest('.input-holder').length == 0) {
			container.removeClass('active');
			// clear input
			container.find('.search-input').val('');
		}
	}
</script>
<body>

	<div id="header">
		<a href="goHome.do" class="text-body"><img id="logo" src="resources/img/bookduckLogo.png" alt="BookDuck"> </a>
		
		<ul class="menu">
				 <!-- 
				<ul class="sub">
					<li class="subbook"><a href="bookbest.do">&nbsp;&nbsp;&nbsp;베스트샐러</a></li>
					<li class="subbook"><a href="newBook.do">&nbsp;&nbsp;&nbsp;신간도서</a></li>
				</ul>
				-->
			<li id="notice"><a href="noticeList.do" class="text-body">공지사항</a></li>
			<li id="qna"><a href="qnaList.do" class="text-body">문의게시판</a></li>
			<li class="headerbooksear"><a href="booksearch.do" class="text-body">도서검색</a></li>
		</ul>
		
		<!-- 헤더 검색바 -->
		<form role="form" class="form-inline" method="POST" action="booksearch.do">
			<input type="hidden" id="start" name="start" value="1">
			<input type="hidden" id="sort" name="sort" value="accuracy"> 
			<input type="hidden" id="target" name="target" value="book"> 
			<input type="hidden" id="sort" name="key" value="title">

			<!-- 꾸민 검색바 -->
			<div id="" class="search-wrapper">
				<div class="input-holder">
					<input id="value" name="value" required="required" type="text" class="search-input" placeholder="" />
					<button type="submit" class="search-icon" onclick="searchToggle(this, event);">
						<span></span>
					</button>
				</div>
						<!-- 
						<span class="close" onclick="searchToggle(this, event);"></span>
						-->
			</div>
		</form>
		
		<c:choose>
			<c:when test="${empty Ldto }">
			
<!-- 로그인 전 -->

				<ul>
					<li><a id="admin" href="joinform.do" class="text-body">회원가입</a></li>
					<li><a id="mainlogin" href="loginform.do" class="text-body">로그인</a></li>
				</ul>
			</c:when>
			<c:otherwise>


<!-- 로그인 후 -->

				<ul id="afterLogin">
					<li class="text-body" id="hihi">${Ldto.member_id }님, 안녕하세요😊</li>
					<li class="text-body"><a href="mypage.do?member_id=${Ldto.member_id}&member_payrole=${Ldto.member_payrole}">MYPAGE</a></li>
					<li class="text-body"><a href="logout.do">로그아웃</a></li>
				</ul>
			</c:otherwise>
		</c:choose>

		

		
	</div>

				<!--  
						    <div id="searchbox">
			              <input type="text" class="form-control" 
			              id="value" name="value" required="required">
			             </div>
			              <button type="submit" class="btn btn-default-info">
			                <span class="glyphicon glyphicon-search"></span>
			                검색
			              </button>
						<div class="search-wrapper">
				-->


			<!-- 검색 보내는 중 onclick="headsearch();"-->
			<!--  
						    <div id="searchbox">
		
		              <input type="text" class="form-control" 
		              id="value" name="value" required="required">
		             </div>
		              <button type="submit" class="btn btn-default-info">
		                <span class="glyphicon glyphicon-search"></span>
		                검색
		              </button>
						
								<div class="search-wrapper">
						-->
			<!-- 
					원래 검색바 
					<div id="searchbox">
	              		<input type="text" class="form-control" 
	              		id="value" name="value" required="required">
	             	</div>
	                <button type="submit" class="btn btn-default-info">
	                  <span class="glyphicon glyphicon-search"></span>
	                    검색
	                </button>
					-->


			<!-- 
						<input type="text" class="form-control" 
						id="value" name="value" required="required">
						<button type="submit" class="btn btn-info">
							<span class="glyphicon glyphicon-search"></span>
							검색
						</button>
						-->

</body>
</html>