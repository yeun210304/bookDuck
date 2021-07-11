<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

/* 헤더 검색 */
.search-wrapper {
	left: 30px;
}

.search-wrapper .input-holder {
	height: 55px;
	width: 50px;
	overflow: hidden;
	background: rgba(255, 255, 255, 0);
	border-radius: 6px;
	position: relative;
	transition: all 0.3s ease-in-out;
}

.search-wrapper.active .input-holder {
	width: 250px;
	border-radius: 30px;
	background: #F2F2F2;
	transition: all .5s cubic-bezier(0.000, 0.105, 0.035, 1.570);
}

.search-wrapper .input-holder .search-input {
	width: 100%;
	height: 20px;
	padding: 0px 70px 0 20px;
	opacity: 0;
	position: absolute;
	top: 9px;
	left: 0px;
	background: transparent;
	box-sizing: border-box;
	border: none;
	outline: none;
	font-size: 15px;
	font-weight: 700;
	line-height: 20px;
	color: #392f31;
	transform: translate(0, 60px);
	transition: all .3s cubic-bezier(0.000, 0.105, 0.035, 1.570);
	transition-delay: 0.3s;
}

.search-wrapper.active .input-holder .search-input {
	opacity: 1;
	transform: translate(0, 10px);
}

.search-wrapper .input-holder .search-icon {
	width: 40px;
	height: 40px;
	border: none;
	border-radius: 6px;
	background: #FFF;
	padding: 0px;
	outline: none;
	position: relative;
	z-index: 2;
	float: right;
	cursor: pointer;
	transition: all 0.3s ease-in-out;
}

.search-wrapper.active .input-holder .search-icon {
	width: 40px;
	height: 40px;
	margin: 8px;
	border-radius: 25px;
}

.search-wrapper .input-holder .search-icon span {
	width: 22px;
	height: 22px;
	display: inline-block;
	vertical-align: middle;
	position: relative;
	transform: rotate(45deg);
	transition: all .4s cubic-bezier(0.650, -0.600, 0.240, 1.650);
}

.search-wrapper.active .input-holder .search-icon span {
	transform: rotate(-45deg);
}

.search-wrapper .input-holder .search-icon span::before, .search-wrapper .input-holder .search-icon span::after
	{
	position: absolute;
	content: '';
}

.search-wrapper .input-holder .search-icon span::before {
	width: 4px;
	height: 11px;
	left: 10px;
	top: 14px;
	border-radius: 2px;
	background: #A071F5;
}

.search-wrapper .input-holder .search-icon span::after {
	width: 14px;
	height: 14px;
	left: 5px;
	top: 1px;
	border-radius: 16px;
	border: 4px solid #A071F5;
}

.search-wrapper .close {
	position: absolute;
	z-index: 1;
	top: 24px;
	right: 20px;
	width: 25px;
	height: 25px;
	cursor: pointer;
	transform: rotate(-180deg);
	transition: all .3s cubic-bezier(0.285, -0.450, 0.935, 0.110);
	transition-delay: 0.2s;
}

.search-wrapper.active .close {
	right: -50px;
	transform: rotate(45deg);
	transition: all .6s cubic-bezier(0.000, 0.105, 0.035, 1.570);
	transition-delay: 0.5s;
}

.search-wrapper .close::before, .search-wrapper .close::after {
	position: absolute;
	content: '';
	background: #FE5F55;
	border-radius: 2px;
}

.search-wrapper .close::before {
	width: 5px;
	height: 25px;
	left: 10px;
	top: 0px;
}

.search-wrapper .close::after {
	width: 25px;
	height: 5px;
	left: 0px;
	top: 10px;
}
/* 여기까지 검색바 */

#header {
	width: 100%;
	height: 100px;
	padding-top: 10px;
	/*margin: auto; */
	background-color: F5DC7A; important!
}

#header>div {
	width: 100%;
	margin-bottom: 10px
}

#header_1 {
	height: 40%;
}
#header_2{height: 60%;}

#header_1>div {
	height: 100%;
	float: left;
}
#header_2>div{height:100%; float: left;}
#header_1_left {
	text-align: center;
	width: 30%;
	position: relative;
}

#header_1_center {
	width: 30%;
}

#header_1_right {
	width: 40%; text-indent: 35px;
}

#header_1_right>ul {
	list-style: none;
}

#header_1_right>ul>li {
	float: left;
	padding: 10px;
}

#header_2_left{width: 30%;}
#header_2_center{width: 40%;}
#header_2_right{width: 30%;}

#header_2_center>ul {
	width: 100%;
	height: 100%;
	list-style-type: none;
	margin: auto;
	padding: 0;
}

#header_2_center>ul>li {
	float: left;
	width: 25%;
	height: 100%;
	line-height: 55px;
	text-align: center;
}

#header_2_center>ul>li a {
	text-decoration: none;
	font-size: 18px;
	font-weight: 900;
}

.content {
	width: 90%;
	margin: auto;
}

.innerOuter {
	width: 80%;
	margin: auto;
	padding: 5% 10%;
	background: white;
}

a {
	text-decoration: none;
}

.search-wrapper {
	position: relative;
}

.headerallsearch {
	position: absolute;
	background-color: white;
	left: 5px;
	width: 230px;
	border-radius: 10px;
	margin-bottom: 10px;
	padding: 15px;
}

.headerallsearch a {
	font-size: 16px;
	line-height: 21px;
}


/*
	헤더 도서검색 호버시 나오는 신간도서,베스트샐러 

.sub{
	top: 100%;
	left:0;
	z-index: 998;
	display: none;
	visibility: hidden;
	float: left;
}

.menu>li:hover>.sub{
	visibility: visible;
	display: block;
	background-color: white;
}

.subbook{
	list-style: none;
	font-size: 10pt;
	background-color: white;
	z-index: 998;
	float: left;

}

.headerbooksear{
	background-color: white;
	z-index: 999;
}
*/

</style>
</head>
<script type="text/javascript">

	function autotext(booklist){
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
																							"<a href='javascript:autotext(\""+booklist[i]+"\")'>"
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
		<div id="header_1">
			<div id="header_1_left" >
			
				 <a href="goHome.do" class="text-body">북덕 BookDuck<img src="" alt=""></a></p>
			</div>
			<div id="header_1_center"></div>
			<div id="header_1_right">
				<c:choose>
					<c:when test="${empty Ldto }">
						<!-- 로그인 전 -->
						<ul>
							<li><a href="joinform.do" class="text-body">회원가입</a></li>
							<li><a href="loginform.do" class="text-body">로그인</a></li>
						</ul>
					</c:when>
					<c:otherwise>
						<!-- 로그인 후 -->
						<ul>
							<li class="text-body">${Ldto.member_id } 님, 안녕하세요😊</li>
							<li class="text-body"><a href="mypage.do?member_id=${Ldto.member_id}&member_payrole=${Ldto.member_payrole}">MYPAGE</a></li>
							<li class="text-body"><a href="logout.do">로그아웃</a></li>
						</ul>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div id="header_2">
			<div id="header_2_left">
			</div>
			<div id="header_2_center">
				<ul class="menu">
					<li class="headerbooksear">
						<a href="booksearch.do" class="text-body">도서검색</a>
						<!-- 
						<ul class="sub">
							<li class="subbook"><a href="bookbest.do">&nbsp;&nbsp;&nbsp;베스트샐러</a></li>
							<li class="subbook"><a href="newBook.do">&nbsp;&nbsp;&nbsp;신간도서</a></li>
						</ul>
						-->
					</li>
					<li><a href="noticeList.do" class="text-body">공지사항</a></li>
					<li><a href="qnaList.do" class="text-body">문의게시판</a></li>
				</ul>
		
			</div>
			<div id="header_2_right">
				<!-- 
					<input id="headervalue">
					<button id="sear"  type="submit" class='btn btn-info btn-sm'>
						<span class="glyphicon glyphicon-search"></span>
						&nbsp;검색
					</button>
					-->	

					<!-- 헤더 검색바 -->					
					<form role="form" class="form-inline" method="POST" action="booksearch.do">
						<input type="hidden" id="start" name="start" value="1">
						<input type="hidden" id="sort" name="sort" value="accuracy">
						<input type="hidden" id="target" name="target" value="book">
						<input type="hidden" id="sort" name="key" value="title">

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

					<!-- 꾸민 검색바 -->
					<div class="search-wrapper">
						<div class="input-holder">
							<input id="value" name="value" required="required" type="text"
								class="search-input" placeholder="" />
							<button type="submit" class="search-icon"
								onclick="searchToggle(this, event);">
								<span></span>
							</button>
						</div>
						<!-- 
						<span class="close" onclick="searchToggle(this, event);"></span>
						-->
					</div>

					<!-- 
						<input type="text" class="form-control" 
						id="value" name="value" required="required">
						<button type="submit" class="btn btn-info">
							<span class="glyphicon glyphicon-search"></span>
							검색
						</button>
						-->

				</form>
			</div>
		</div>
	</div>


</body>
</html>