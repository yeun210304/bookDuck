<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.spring.bookduck.pay.dto.PayDto"%>
<%@page import="com.spring.bookduck.introduce.dto.IntroduceDto"%>
<%@page import="com.spring.bookduck.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<%
	MemberDto dto1 = (MemberDto) session.getAttribute("Ldto");
%>

<!--SummerNote  -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script>
	$(document).ready(function() {
		$('#summernote').summernote();
	});
</script>



<!-- 구글차트 GoogleChart -->
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
    	  var jsonData = $.ajax({
    		 url: "chartData.do",
    		 data: "chartId=${Ldto.member_id}",
    		 dataType:"json",
    		 async: false
    		}).responseText;

    	  var stringJson = JSON.parse(jsonData);
    	  
    	  var data = new google.visualization.DataTable();
    	  data.addColumn('string', 'chartMdate');
    	  data.addColumn('number', '독서량');
    	  
    	  var dataArray = [];
    	  for(var i = 0; i < stringJson.map.length; i++){
				dataArray.push([stringJson.map[i].chartMdate, Number(stringJson.map[i].chartreadingtime)]);
			};
			
			data.addRows(dataArray);
    	  
        var options = {
          title: '독서그래프',
          curveType: 'function',
          legend: { position: 'bottom' }
        };

        var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

        chart.draw(data, options);
      }
</script>

<!-- 리딩차트 null값 처리 -->
<script type="text/javascript">
	
	var submitAction = function() {
		/* do something with Error */
	    return false;
	};
	
	function isNullCheck(){
		
		var chartreadingtime = document.getElementById("chartreadingtime").value;
		
		var chartMdate = document.getElementById("chartMdate").value;
		
		if(chartMdate == null || chartMdate == 0){
			$('form').bind('submit', submitAction);
			alert("독서일을 클릭해주세요");
			return false;
		} else if(chartreadingtime == 0 || chartreadingtime == null){
			$('form').bind('submit', submitAction);
			alert("독서한 시간을 선택해주세요");
			return false;
		}
		
	}
	
</script>

 <!--찜하기 삭제 스크립트  -->
<script type="text/javascript">
	$(function() {
		var chkObj = document.getElementsByName("RowCheck");
		var rowCnt = chkObj.length;
			
		$("input[name='allCheck']").click(function() {
			var chk_listArr = $("input[name='RowCheck']");
			for(var i=0; i<chk_listArr.length; i++){
				chk_listArr[i].checked= this.checked;
			}
		});
		$("input[name='RowCheck']").click(function() {
			if($("input[name'RowCheck']:checked").length == rowCnt){
				$("input[name ='allCheck']")[0].checked =true;
			}
			else{
				$("input[name ='allCheck']")[0].checked =false;
			}
		});
	});
	function deleteValue() {
		var url ="scalldelete.do";//컨트롤러로 
		var valueArr = new Array();
		var list =$("input[name ='RowCheck']");
		for(var i = 0; i < list.length ; i++){
			if(list[i].checked){//선택하면 배열값으로 저장
				valueArr.push(list[i].value);
			}
		}
		if(valueArr.length == 0){
			alert("선택된 목록이 없습니다.");
		}
		else{
			var chk =confirm("삭제 하시겠습니까?");
			$.ajax({
				url : url,              //전송 url
				type : 'POST',			//post 방식
				traditional : true,	
				data : {
					valueArr : valueArr	//보내는 data 변수설정
				},
				success : function(jdata) {
					if(jdata = 1){
						alert("삭제성공");
						location.reload();
					}
					else{
						alert("삭제실패");
					}
				}
			});
		}
	}
</script>

<style type="text/css">
	.blistclass	{
		display: none;
	}


</style>



</head>
<body style="background-color:#fdf7dd ">
<jsp:include page="header.jsp"/>

	

<div class="content">
	<div class="innerOuter">
	
		<a href="updatePwForm.do">비밀번호변경</a>
		<a href="leaveAccountForm.do">회원탈퇴</a>
	
	<h1 style="color: ">MY BookDuck</h1>
	<br/><br/>
	<div>
		<c:choose>
			<c:when test="${Ldto.member_payrole eq 'N'}">
				<div>
					<p>${Ldto.member_id }님은 회원권이 없습니다. </p>
					<a href="payorder.do?">회원 결제하기</a>
				</div>
			</c:when>
				<%--/////////////결제한 회원이보여지는 단 /////////////// --%>
			<c:when test="${Ldto.member_payrole eq 'Y'}">
				<p>${Ldto.member_id }님은, 유료회원 입니다.</p>
				<br/><br/>
				<%--/////////////자기소개가 없을시 보여지는 단 /////////////// --%>
				<c:choose>
					<c:when test="${empty intdDto.intd_content}">
						<table class="table table-borderless">
							<tr>
								<td colspan="1" align="center"
									onclick="location.href='intdinsertres.do?member_id=${Ldto.member_id}'">
									자기소개를작성해 주세요(클릭)</td>
							</tr>
						</table>
						<br/><br/>
							<div>
							<table border="1">
								<col width="10">
								<col width="25" />
								<col width="100" />
								<tr>
									<th><input id="allCheck" type="checkbox" name="allCheck"/></th>
									<th>도서국제번호</th>
									<th>제목</th>
								</tr>
								<c:choose>
									<c:when test="${empty sclist }">
										<tr>
											<td colspan="3" align="center">------------찜목록이 없습니다.------------</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${sclist }" var="scrapDto">
											<tr>
												<td>
													<input name="RowCheck" type="checkbox" value="${scrapDto.scrap_no }" />
													<input type="hidden" name="book_author" value="${scrapDto.book_author }">
													<input type="hidden" name="book_coverLargeUrl" value="${scrapDto.book_coverLargeUrl }">
													<input type="hidden" name="book_categoryId" value="${scrapDto.book_categoryId }">
												</td>
												<td><a href="scselectone.do?title=${scrapDto.book_title }&coverLargeUrl=${scrapDto.book_coverLargeUrl }
												&isbn=${scrapDto.book_isbn }&author=${scrapDto.book_author }&categoryId=${scrapDto.book_categoryId}">${scrapDto.book_isbn }</a></td>
												<td>${scrapDto.book_title }</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</table>
							<input type="button" value="삭제" onclick="deleteValue();" />	
						</div>
					</c:when>
					<c:otherwise>
					<%--////////////자기소개가 있을때/////////////  --%>
						<table class="table table-borderless">
							<tr>
								<td id="summernote">${intdDto.intd_content}
								</td>
							</tr>
							<tr>
								<td class="btn-group" ><input type="button" value="수정" class="btn btn-primary"
									onclick="location.href='updateintdres.do?intd_no=${intdDto.intd_no}'">
									<input type="button" value="삭제" class="btn btn-primary"
									onclick="location.href='deleteintd.do?intd_no=${intdDto.intd_no}'">
								</td>
							</tr>
						</table>
						<br/><br/>
						<div>
							<table border="1" class="table table-borderless">
								<col width="10">
								<col width="25" />
								<col width="100" />
								<tr>
									<th><input id="allCheck" type="checkbox" name="allCheck"/></th>
									<th>도서국제번호</th>
									<th>제목</th>
								</tr>
								<c:choose>
									<c:when test="${empty sclist }">
										<tr>
											<td colspan="3" align="center">------------찜목록이 없습니다.------------</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${sclist }" var="scrapDto">
											<tr>
												<td>
													<input name="RowCheck" type="checkbox" value="${scrapDto.scrap_no }" />
													<input type="hidden" name="book_author" value="${scrapDto.book_author }">
													<input type="hidden" name="book_coverLargeUrl" value="${scrapDto.book_coverLargeUrl }">
													<input type="hidden" name="book_categoryId" value="${scrapDto.book_categoryId }">
												</td>
												<td><a href="scselectone.do?title=${scrapDto.book_title }&coverLargeUrl=${scrapDto.book_coverLargeUrl }
												&isbn=${scrapDto.book_isbn }&author=${scrapDto.book_author }&categoryId=${scrapDto.book_categoryId}">${scrapDto.book_isbn }</a></td>
												<td>${scrapDto.book_title }</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</table>
							<input type="button" class="btn btn-primary" value="삭제" onclick="deleteValue();" />	
						</div>
					</c:otherwise>
				</c:choose>
			</c:when>
		</c:choose>
		<br/><br/><br/>
	</div>
	
	
	
	<!-- 리딩차트. 구글차트 부분 -->
	<div class="readingChart">
		<c:choose>
			<c:when test="${Ldto.member_payrole eq 'N'}">
				<p> </p>
			</c:when>
			<c:when test="${Ldto.member_payrole eq 'Y'}">
				<!-- 구글차트 위치-->
				<div id="curve_chart" method="get" style="width:900px; height:500px">
					<h3>독서량을 등록하시면 그래프가 그려집니다</h3>
				</div>
				<!-- 독서량 전달 -->
				<form action="readingTimeInsert.do" method="post">
					<p>독서량을 등록하시면 그래프가 그려집니다</p>
					<!-- 날짜 -->
					<input type="date" id="chartMdate" name="chartMdate" style="width:30%" />
					<br/>
					<!-- 독서한 시간(분) -->
					<input type="range" min="0" max="600" value="0" style="width:30%" id="chartreadingtime" name="chartreadingtime" oninput="document.getElementById('CRTime').innerHTML=this.value;">
					<br/>
					<span id="CRTime" ></span>분
					<input type="hidden" id="chartId" name="chartId" value="${Ldto.member_id}" />
					<input type="submit" value="등록" onclick="isNullCheck();" />
				</form>
			</c:when>
		</c:choose>

	</div>

	
	<!-- 신고하기. 블랙리스트 -->
	
	<div>
		<input id="blist" type="button" value="신고하기">
		<div id="blistdiv" class="blistclass">			
			<table>
				<tr>
					<td>ID</td>
					<td>
						<input id="blistid" type="text" placeholder="신고할 ID를 검색하세요">
						<input id="blistidsearch" type="button" value="ID 찾기">
					</td>
				</tr>
				<tr>
					<td>신고내용</td>
					<td>
						<textarea id="blistcontent" rows="10" cols="60"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right">					
						<input id="blistinsert" type="button" value="신고하기">
						<input id="blistcancel" type="button" value="취소">
					</td>				
				</tr>				
			</table>		
		</div>
	</div>
	
	<script type="text/javascript">
	var $blist = $("#blist");
	var $blistdiv = $("#blistdiv");
	var $blistcancel = $("#blistcancel");
	var $blistidsearch = $("#blistidsearch");
	var $blistid = $("#blistid");
	var $blistinsert = $("#blistinsert");
	var $blistcontent = $("#blistcontent");
	
	$blist.click(function(){
		$blistdiv.toggleClass("blistclass");
		$blistdiv.parent().find("span").remove();
		$blistid.val("");
		$blistcontent.val("");
	});
	
	$blistcancel.click(function(){
		$blistdiv.addClass("blistclass");
	});
	
	$blistidsearch.click(function(){
		var $id = $blistid.val();
		
		$.getJSON("classifyidajax.do?member_id="+$id, function(list){
			$blistidsearch.parent().find("span").remove();
			var jsonlist = JSON.stringify(list);
			var jsondata = JSON.parse(jsonlist);
			
			if(jsondata.list.length === 0){		
				$blistidsearch.parent().append("<span>검색한 id가 존재하지 않습니다.</span>");		
			} else{
				$blistidsearch.parent().append("<span>검색한 id가 존재합니다.</span>");	
			}			
		});
	});
	
	$blistinsert.click(function(){
		
		var from_id = "${Ldto.member_id }";
		var to_id = $blistid.val();
		var content = $blistcontent.val();
		
		if(to_id.length != 0 || to_id.trim() != ""){
			$.getJSON("blistinsert.do?blist_from="+from_id+"&blist_to="+to_id+"&blist_contents="+content , function(data){
				if(data.list != null && data.list.length != 0){
					$blist.parent().find("span").remove();
					$blistdiv.addClass("blistclass");
					$blist.parent().append("<span>신고가 완료되었습니다.</span>")
				} else{
					$blist.parent().find("span").remove();
					$blistdiv.addClass("blistclass");
					$blist.parent().append("<span>신고가 실패했습니다.</span>")
				}					
			});
		} else {
			$blist.parent().find("span").remove();
			$blist.parent().append("<span>신고할 ID를 검색해주세요.</span>")	
		}		
	});	
	
	</script>	
	
	
	
	
	
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	</div>
</div>


</body>
</html>