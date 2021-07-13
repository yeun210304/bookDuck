<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="org.xml.sax.*"%>
<%@ page import="java.net.*"%>
<%@ page import="javax.xml.xpath.*"%>
<%@ page import="javax.xml.transform.*"%>
<%@ page import="javax.xml.transform.dom.*"%>
<%@ page import="javax.xml.transform.stream.*"%>
<%
	request.setCharacterEncoding("UTF-8");
//절대경로 확인
String path = request.getContextPath();

/*
 * XML Parsing 
 * 1. XML document loading -> XML Object 
 * 2. root element 
 * 3. child element 
 * 4. text node 
 * 5. print
 */

//인터파크 도서 검색에 대한 XML 요청 및 분석, 결과 출력
//http://book.interpark.com/api/search.api?key=개인키&query=검색어&queryType=검색기준&maxResults=10&inputEncoding=utf-8

//검색 기준 및 검색 단어 수신
String key = request.getParameter("key");

String value = request.getParameter("value");
if (key == null) {
	key = "";
	value = "";
}

String start = request.getParameter("start");
if (start == null) {
	start = "";
}

String target = request.getParameter("target");

String sort = request.getParameter("sort");

/*
System.out.println("---------");
System.out.println(key);
System.out.println(value);
System.out.println(start);
System.out.println(target);
System.out.println(sort);
*/
/*
Crawler craw = new Crawler();
craw.Crawler(value, start, key);
*/

//System.out.println(key);
//System.out.println(value);
//System.out.println(start);


StringBuilder sb = new StringBuilder();
String totalcount = "0";
String count = "0";

if (key != null && value != null) {
	DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	DocumentBuilder builder = factory.newDocumentBuilder();
	Document doc = null;
	String str = String.format(
	"http://book.interpark.com/api/search.api?key=7A71D8E679DA9C96874476B8E225B77A4592E29959B15764C52A257C0343754F&query=%s&queryType=%s&start=%s&maxResults=10&inputEncoding=utf-8&searchTarget=%s&sort=%s",
	URLEncoder.encode(value, "UTF-8"), key, start, target, sort);
	URL url = new URL(str);
	//System.out.println(url);
	
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
		//System.out.println(categoryId);
		
		// 비어있는 값 대비
		if(description == null || description == "" || description == " " ){
			description = "이 도서는 정보를 제공하지 않습니다.";
		}
	
		if(categoryId == null || categoryId == "" || categoryId == " " ){
			categoryId = "이 도서는 정보를 제공하지 않습니다.";
		}
		
		if(categoryName == null || categoryName == "" || categoryName == " " ){
			categoryName = "이 도서는 정보를 제공하지 않습니다.";
		}
		if(isbn == null || isbn == "" || isbn == " " ){
			isbn = "이 도서는 정보를 제공하지 않습니다.";
		}
		if(pubDate == null || pubDate == "" || pubDate == " " ){
			pubDate = "이 도서는 정보를 제공하지 않습니다.";
		}
		if(publisher == null || publisher == "" || publisher == " " ){
			publisher = "이 도서는 정보를 제공하지 않습니다.";
		}
		if(author == null || author == "" || author == " " ){
			author = "이 도서는 정보를 제공하지 않습니다.";
		}
		
		// categoryId 정리
		if(categoryId == "101" || categoryId == "101 "){
			categoryId = categoryId + "소설";
		}
		if(categoryId == "102"){
			categoryId = "시/에세이";
		}
		if(categoryId == "103"){
			categoryId = "예술/대중문화";
		}
		if(categoryId == "104"){
			categoryId = "사회과학";
		}
		if(categoryId == "105"){
			categoryId = "역사와 문화";
		}
		if(categoryId == "107"){
			categoryId = "잡지";
		}
		if(categoryId == "108"){
			categoryId = "만화";
		}
		if(categoryId == "109"){
			categoryId = "유아";
		}
		if(categoryId == "110"){
			categoryId = categoryId + "아동";
		}
		if(categoryId == "111"){
			categoryId = "가정과 생활";
		}
		if(categoryId == "112"){
			categoryId = "청소년";
		}
		if(categoryId == "113"){
			categoryId = "초등학습서";
		}
		if(categoryId == "114"){
			categoryId = "고등학습서";
		}
		if(categoryId == "115"){
			categoryId = categoryId + "국어/외국어/사전";
		}
		if(categoryId == "116"){
			categoryId = "자연과 과학";
		}
		if(categoryId == "117"){
			categoryId = "경제경영";
		}
		if(categoryId == "118"){
			categoryId = "자기계발";
		}
		if(categoryId == "119"){
			categoryId = categoryId + "인문";
		}
		if(categoryId == "120"){
			categoryId = "종교/역학";
		}
		if(categoryId == "122"){
			categoryId = "컴퓨터/인터넷";
		}
		if(categoryId == "123"){
			categoryId = "자격서/수험서";
		}
		if(categoryId == "124"){
			categoryId = "취미/레저";
		}
		if(categoryId == "125"){
			categoryId = "전공도서/대학교제";
		}
		if(categoryId == "126"){
			categoryId = "건강뷰티";
		}
		if(categoryId == "128"){
			categoryId = "여행";
		}
		if(categoryId == "129"){
			categoryId = "중등학습서";
		}
		/*
		request.setAttribute("coverLargeUrl", coverLargeUrl);
		request.setAttribute("title", title);
		request.setAttribute("isbn", isbn);
		*/
		//System.out.println(title);
		sb.append(String.format("<div class='row result'>"));
		sb.append(String.format("<div class='col-md-1'><span>%s</span></div>", a));
		sb.append(String.format("<div class='col-md-4' id='selectimg' style='overflow : auto; text-align : center;'><a href='recommendBook.do?title=%s&coverLargeUrl=%s&isbn=%s&author=%s&categoryId=%s'  target='_blank'><img src='%s' class='resize'><div class='hovertext'><p>클릭시 도서추천 페이지로 이동합니다.</p></div></a></div>", title,coverLargeUrl,isbn,author,categoryId,coverLargeUrl));
		sb.append(String.format("<div class='col-md-7'><ul>"));
		sb.append(String.format("<table id = 'tbb' style='table-layout:fixed'><tr> <td id='td1'><b> &#128157;&nbsp; 제목 </b></td> <td id='td2'>%s</td> </tr>", title));
		sb.append(String.format("<tr> <td id='td1' ><b> &#128039;&nbsp; 저자 </b></td> <td  id='td2'>%s</td> </tr>", author));
		sb.append(String.format("<tr> <td id='td1' ><b> &#127804;&nbsp; 출판사 </b></td> <td  id='td2'>%s</td> </tr>", publisher));
		sb.append(String.format("<tr> <td id='td1' ><b> &#127904;&nbsp; 설명 </b></td> <td id='td2'>%s</td> </tr>", description));
		sb.append(String.format("<tr> <td id='td1' ><b> &#127826;&nbsp; 판매가 </b></td> <td id='td2'>%s</td> </tr>", priceStandard));
		sb.append(String.format("<tr> <td id='td1' ><b> &#10024;&nbsp; 출간일 </b></td> <td id='td2'>%s</td> </tr>", pubDate));
		sb.append(String.format("<tr> <td id='td1' ><b> &#127800;&nbsp; ISBN </b></td> <td id='td2'>%s</td> </tr>", isbn));
		sb.append(String.format("<tr> <td id='td1' ><b> &#128049;&nbsp; 카테고리 </b></td> <td id='td2'>%s</td> </tr>", categoryName));
		sb.append(String.format("<tr> <td id='td1' ><b> &#127776;&nbsp; 분류 </b></td> <td id='td2'>%s</td> </tr> </table>", categoryId));
		sb.append(String.format("</div>"));
		sb.append(String.format("</div>"));
		sb.append(String.format("<div class='wrapper'>"));
		sb.append(String.format("<div id='btncss' style='background : #F7DAE5;'><a href='%s' target='_blank'>&#128184;&nbsp;구매하기</a></div>",
		link));
		sb.append(String.format("<div id='btncss' style='background : #FFEAB3;'><a href='recommendBook.do?title=%s&coverLargeUrl=%s&isbn=%s&author=%s&categoryId=%s'  target='_blank'>&#128149;&nbsp;도서추천</a></div>",title,coverLargeUrl,isbn,author,categoryId));
		sb.append(String.format("<div id='btncss' style='background : #C5F5D4;'><a href='scinsert.do?title=%s&isbn=%s&coverLargeUrl=%s&author=%s&categoryId=%s' target='_blank'>&nbsp;&#127873;&nbsp;&nbsp;찜하기&nbsp;&nbsp;</a></div>",title,isbn,coverLargeUrl,author,categoryId));
		sb.append(String.format("</div>"));
		
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck - 도서검색</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.1/css/font-awesome.min.css" />



<style>

/* 글씨체 */
@font-face{
	src: url("font/NanumSquareB.ttf");
	font-family: NanumMyeongjo;
}
/*
body {
	font-family:  NanumMyeongjo;
}

#sorting{
	font-family: NanumMyeongjo;
}
*/
/* 이미지 호버시 도서 추천 페이지 이동 */
.hovertext{
	background : #000000;
	opacity: 0;
}

#selectimg:hover{
	opacity : 0.6;
	color : #ffffff;
	text-align: center;
}

#selectimg:hover .hovertext{
	margin-top : 15px;
	font-size : 15px;
	opacity: 0.8;
	text-align: center;
	color : #ffffff;
}



/* 책 정보 */
td{
	width: 130px;
	text-align: left;
	vertical-align: top;
	
}
#td1{
	padding: 3px;
}

#td2{
	width: 380px;
	padding : 3px;
}

/* 검색 결과 */
div.result {
	border-top: 1px solid #dddddd;
	margin-top: 10px;
	padding: 20px;
	margin-bottom: 10px;
}

 	#searchbox {
    	position: relative;
    	display: inline;
    }    
    
    .allsearch{
		position: absolute;
		background-color:white;		
		left:1px;
	}
	


/* 도서 검색 대문 */
#h1 {
	font-size: 40px;
	font-weight: bold;
	text-align: center;
	color: #696969;
	letter-spacing: 3px;
	transition: 1s;
	-webkit-transition: 1s;
	-ms-transition: 1s;
	position: relative;
	padding: 12px;
	z-index: 1
}

#h1:before, #h1:after {
	content: "";
	position: absolute;
	height: 8px;
	width: 0px;
	background: #ffd800;
	transition: 300ms;
	-webkit-transition: 1s;
	-ms-transition: 1s;
	opacity: 0.3;
	left: 50%;
}

#h1:before {
	bottom: 0;
}

#h1:after {
	top: 0;
}

/* 호버 효과 */
#h1:hover {
	letter-spacing: 30px;
}

#h1:hover:before, #h1:hover:after {
	width: 100%;
	opacity: 1;
	left: 0;
}

#h1:hover ~ #h2 {
	opacity: 0;
}

#h2{
	color: #0A11FF;
	font-family: 'Pinyon Script', cursive;
	text-align: center;
	font-size: 30px;
	font-weight: 100;
	bottom: 40px;
	transition: 1s;
	-webkit-transition: 1s;
	-ms-transition: 1s;
	opacity: 0.3;
	width: 100%;
}


/* 정렬 그라데이션 css */
#accuracy, #publishTime, #title, #salesPoint, #customerRating, #reviewCount, #price, #priceDesc {
  text-align: center;
  transition: 0.5s;
  background-size: 200% auto;
  color: white;
  box-shadow: 0 0 20px #eee;
  border-radius: 10px;
 }


#accuracy:hover, #publishTime:hover, #title:hover, #salesPoint:hover , #customerRating:hover, #reviewCount:hover, #price:hover, #priceDesc:hover{
  background-position: right center;
}

#accuracy {
  background-image: linear-gradient(to right, #FBD9E6 0%, #fda085 51%, #FBD9E6 100%);
}

#publishTime{
  background-image: linear-gradient(to right, #fbc2eb 0%, #a6c1ee 51%, #fbc2eb 100%);	
}

#title {
  background-image: linear-gradient(to right, #84fab0 0%, #8fd3f4 51%, #84fab0 100%);
}

#salesPoint {
  background-image: linear-gradient(to right, #a1c4fd 0%, #c2e9fb 51%, #a1c4fd 100%);
}

#customerRating {
  background-image: linear-gradient(to right, #ffecd2 0%, #fcb69f 51%, #ffecd2 100%);
}

#reviewCount {
  background-image: linear-gradient(to right, #FFB7C5 0%, #FFBFF0 51%, #FFB7C5 100%);
}

#price {
  background-image: linear-gradient(to right, #d9f2b3 0%, #fccbc7 51%, #d9f2b3 100%);
}

#priceDesc {
  background-image: linear-gradient(to right, #F0DDEC 0%, #BFBFE6 51%, #F0DDEC 100%);
}


/* 구매하기, 추천하기, 찜하기 버튼 */
.wrapper {
  position : relative;
  text-align: right;
  bottom : 10px;
}

#btncss { 
  border-radius : 10px;
  padding : 10px 10px 10px 10px;
  margin : 0px 15px 0px 15px;
  opacity : 0.75;
  color: #A071F5;
  font-size : 15px;
  font-weight : bold;
  text-transform: uppercase;
  text-align: center;
  position: relative;
  text-decoration: none;
  display:inline-block;
 
}

#btncss>a{
	text-decoration: none;
	color: black;
}

a{
text-decoration: none;
}

#btncss a:hover, #btncss a:visited, #btncss a:active {
text-decoration: none;
}


#btncss::before {
  content: '';
  position: absolute;
  bottom: 0%;
  left: 0px;
  width: 100%;
  height: 2px;
  background: #dcdcdc;
  display: block;
  -webkit-transform-origin: right top;
  -ms-transform-origin: right top;
  transform-origin: right top;
  -webkit-transform: scale(0, 1);
  -ms-transform: scale(0, 1);
  transform: scale(0, 1);
  -webkit-transition: transform 0.4s cubic-bezier(1, 0, 0, 1);
  transition: transform 0.4s cubic-bezier(1, 0, 0, 1)
}

#btncss:hover::before {
  -webkit-transform-origin: left top;
  -ms-transform-origin: left top;
  transform-origin: left top;
  -webkit-transform: scale(1, 1);
  -ms-transform: scale(1, 1);
  transform: scale(1, 1)
}

/* 올라가기 고정 버튼 */
#upup {
    position: fixed;
    height : 30px;
    width : 50px;
    right: 50px;
    bottom: 50px;
    z-index: 50;
    /*
    height : 50px;
    width : 50px;
    
    right: 2%;
    bottom: 50px;
    z-index: 999;
    */
 
}

/* 페이지 스크롤업 이미지 */
#upup img{
	height : 50px;
    width : 50px;
}


/* 이미지 리사이즈 */
.resize{
	height: auto;
	width: 245px;
	float : center;
	text-align: center;
}

#searchbox {
	position : relative;
}

.searchpagebox {
	position : absolute;
	background-color : #fcfaf2;
	left : 0.5px;
	width : 195px;
	border-radius : 10px;
	margin-bottom : 10px;
	padding : 15px;	
	z-index : 1000;
}

.searchpagebox a {
	font-size : 1.6rem;
	line-height : 2.5rem;
	text-decoration : none;
	color:#233f9e
}
.searchpagebox a:link {
	text-decoration : none;
	color:#233f9e
}
.searchpagebox a:visited {
	text-decoration : none;
	color:#233f9e
}
.searchpagebox a:hover {
	text-decoration : none;
	color:#233f9e
}

/* 헤더 글씨 굵고 까맣게 */
#notice>a, #qna>a, .headerbooksear>a, #admin, #mainlogin, #afterLogin>li>a{
	font-weight: bold;
	color : black;
}




</style>

<link href='https://fonts.googleapis.com/css?family=Montserrat:700|Pinyon+Script' rel='stylesheet' type='text/css'>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		
<script>

	var currentPageNum; //현재 페이지 번호 저장용 전역변수
	
    $(document).ready(function() {
        $("#key option[value='<%=key%>']").attr("selected", "selected");
        $("#value").val('<%=value%>');
        <%--
        $("#sort").val('<%=sort%>');
        --%>
        
        console.log("통신");
        
       	 currentPageNum = "1";
		 currentPage(currentPageNum);
        
		//이전, 다음 버튼 -> 페이지 이동
		$("#previous").click(function() {
			var previousNum = parseInt(currentPageNum)-1;
			if(previousNum < 1){
				previousNum = 1;
			}
			//ajax($("#value").val(), $("#key option:selected").val(), previousNum);			
			currentPage(previousNum);
			startChange($("#value").val(), $("#key option:selected").val(), previousNum,$("input:radio[name='target']:checked").val(), $("#publishTime").val());
	
			$('html,body').animate({scrollTop:0},1000);
		});
		
		$("#next").click(function() {
			var nextNum = parseInt(currentPageNum)+1;
			//ajax($("#value").val(), $("#key option:selected").val(), nextNum);			
			currentPage(nextNum);
			startChange($("#value").val(), $("#key option:selected").val(), nextNum, $("input:radio[name='target']:checked").val(), $("#publishTime").val());
			
			$('html,body').animate({scrollTop:0},1000);
		});
	
		
		// 출간일 정렬
		$("#publishTime").click(function() {
			currentPageNum = 1;
			currentPage(1);
			realsort($("#value").val(), $("#key option:selected").val(), currentPageNum, $("input:radio[name='target']:checked").val(), $("#publishTime").val());
		});
		
		// 정확도 정렬
		$("#accuracy").click(function() {
			currentPageNum = 1;
			currentPage(1);
			realsort($("#value").val(), $("#key option:selected").val(), currentPageNum, $("input:radio[name='target']:checked").val(), $("#accuracy").val());
		});
		
		// 제목 정렬
		$("#title").click(function() {
			currentPageNum = 1;
			currentPage(1);
			realsort($("#value").val(), $("#key option:selected").val(), currentPageNum, $("input:radio[name='target']:checked").val(), $("#title").val());
		});
		
		// 판매량 정렬
		$("#salesPoint").click(function() {
			currentPageNum = 1;
			currentPage(1);
			realsort($("#value").val(), $("#key option:selected").val(), currentPageNum, $("input:radio[name='target']:checked").val(), $("#salesPoint").val());
		});
		
		// 고객평점 정렬
		$("#customerRating").click(function() {
			currentPageNum = 1;
			currentPage(1);
			realsort($("#value").val(), $("#key option:selected").val(), currentPageNum, $("input:radio[name='target']:checked").val(), $("#customerRating").val());
		});
		
		// 리뷰갯수 정렬
		$("#reviewCount").click(function() {
			currentPageNum = 1;
			currentPage(1);
			realsort($("#value").val(), $("#key option:selected").val(), currentPageNum, $("input:radio[name='target']:checked").val(), $("#reviewCount").val());
		});
		
		// 가격오름순 정렬
		$("#price").click(function() {
			currentPageNum = 1;
			currentPage(1);
			realsort($("#value").val(), $("#key option:selected").val(), currentPageNum, $("input:radio[name='target']:checked").val(), $("#price").val());
		});
		
		// 가격내림순 정렬
		$("#priceDesc").click(function() {
			currentPageNum = 1;
			currentPage(1);
			realsort($("#value").val(), $("#key option:selected").val(), currentPageNum, $("input:radio[name='target']:checked").val(), $("#priceDesc").val());
		});
		
		// 정렬
	    function realsort(value, key, start, target, sort){
	    	
            //console.log("시작");
	    	$.ajax({
            	
                type : "post",
                data: {"value" : value, "key" : key, "start" : start, "target" : target, "sort" : sort},
                
                success: function(list){
                	// console.log("성공");
                	
                	var arr = list.split('<');
					console.log(arr);
					
                    var value = "";
                    
                    
                    for(var i=261; i < arr.length; i++){
                    	value += '<'+arr[i]
                    };
                    
                    //console.log(value);
                    var value2 = value.split("<ul class=");
                    //console.log(value2);
                    
                    
					$("#originalBody").hide();
					$("#pagingBody").html(value2[0]);

                }, error: function(){
                    console.log("실패");
                }
            });
        }
    	
	    
	    
	    
	    // 페이징
	    function startChange(value, key, start, target, sort){
	    	
            //console.log("시작");
	    	$.ajax({
            	
                type : "post",
                data: {"value" : value, "key" : key, "start" : start, "target" : target, "sort" : sort},
                
                success: function(list){
                	//console.log("성공");
                	//console.log(list);
        			
        			var arr = list.split('<');
					console.log(arr);
        			
                    var value = "";
                    
                    
                    for(var i=261; i < arr.length; i++){
                    	value += '<'+arr[i]
                    };
                    
                    console.log(value);
                    var value2 = value.split("<ul class=");
                    console.log(value2);
                    
                    
					$("#originalBody").hide();
					$("#pagingBody").html(value2[0]);

                }, error: function(){
                    console.log("덧붙이기 ajax 실패");
                }
            });
        }
	    
	   
	    
	    var $searchbox = $("#searchbox").find("input");
	    $searchbox.on("propertychange change keyup paste input", function() {
	    	// console.log("작동되나"?");	    	

			var booklist = [];
			
			if($(this).val() !== "" && $(this).val().trim() !== ""){
				var search = $(this).val();				
				
				$.getJSON("classifybookajax.do?search="+search, function(result){
					// console.log(list);
					if(booklist.length !==0){
						booklist = [];
					}
					booklist = result.list;
					// console.log(booklist);
						
					var $add = $("#searchbox");						
						
					for(var i = 0; i<booklist.length ; i++){
						$add.find('a').remove();
						$add.find('.searchpagebox').remove();
						$add.append('<div class="searchpagebox"></div>')
						for(var i = 0; i < booklist.length ; i++){								
							$add.find('div').append("<a href='javascript:$(\""+"#searchbox"+" input"+"\").val(\""+booklist[i]+"\");'>"+((booklist[i].length > 11)? booklist[i].substring(0,10)+"...</a><br/>" : booklist[i] +"</a><br/>"));
						}							
					}						
				});		
				
			} else {
				$("#searchbox").find('a').remove();
				$("#searchbox").find('.searchpagebox').remove();
			}
		});
	    
	    $("body").click(function(){
	    	$("#searchbox").find('a').remove();
			$("#searchbox").find('.searchpagebox').remove();
	    });
    	
    });


	// 현재 페이지 
	function currentPage(idx) {
		$(".currentPage").text(idx);
		currentPageNum = idx;
	}
    
	// 올라가기 고정 버튼  
	$(function(){
		$('#upup').on('click',function(e){
			e.preventDefault();
			$('html,body').animate({scrollTop:0},1000);
		});
	});
</script>


</head>
<body>

 <!-- 헤더 시작 -->
 <jsp:include page="../header.jsp"/>
  
  <div class="container">
      <div class="panel page-header" style="text-align: center;">
          
          <!-- 주의) 상대경로 대신 절대경로 표기를 권장한다. -->
          <!-- 도서검색 효과 -->
          <div class="e">
            <h1 id="h1">
              &#128218;&nbsp;도서검색
            </h1>
            <h2 id="h2">BookDuck</h2>
          </div>
          <span style="font-size: small; color: #777777;"></span>
      </div>
      <div id="btncss" style="float: right; padding: 4px 15px 15px 10px; "><a href="newBook.do">&#10024;&nbsp;신간도서</a></div>
      <div id="btncss" style="float: right; padding: 4px 15px 15px 10px; "><a href="bookbest.do">&#128077;&nbsp;베스트셀러</a></div>
      <br/><br/>
      
        
      <div class="panel-group">
			<div class="panel panel-default">
				<div class="panel-heading">
				&#128270;&nbsp;도서 검색
				</div>
				
	   			<div class="panel-body">
                    <form role="form" class="form-inline" method="POST">
                        <input type="hidden" id="start" name="start" value="1">
                        <input type="hidden" id="sort" name="sort" value="accuracy">

                        <label class="radio-inline">
                        <input type="radio" class="target" name="target" value="book" checked="checked">국내도서</label> 
                        <label class="radio-inline">
                        <input type="radio" class="target" name="target" value="foreign">해외도서</label> 

                        &nbsp;
                        <select class="form-control" id="key" name="key">
                            <option value="title">책 제목</option>
                            <option value="isbn">ISBN</option>
                        </select>
                      	<div id="searchbox">
                          <input type="text" class="form-control" 
                          id="value" name="value" required="required">
					     </div>
                        <button type="submit" id="bts" class="btn btn-default">
                            <span class="glyphicon glyphicon-search"></span>
                            검색</button>
                        <!-- 
                        <button id="mic" class="btn btn-default"
                            onClick="startConverting();" type="button">
                            <span class="fa fa-microphone"></span>
                        </button>
                         -->
                    </form>
                </div>
            </div>
        </div>
  
		<div class="panel panel-default" id="output">
			<div class="panel-heading">&#128036;&nbsp;도서 검색 결과&nbsp;&nbsp;
				<button type="button" class="btn btn-default">
					총&nbsp;<span class="badge" id="totalcount"><%=totalcount%></span> 개의 도서가 검색되었습니다.
				</button>
			</div>
			<div class="panel-body" id="hey">
				
				<button type="button" class="btn btn-default">
					<span class="badge" id="count"><%=count%></span>&nbsp;개씩 정렬
				</button>
				<button type="button" class="btn btn-default">
					현재 페이지 <span class="badge currentPage">0</span>
				</button>
				
				<!-- 정렬 -->
				<div id="sorting" style="float: right;">
					<button class="btn btn-default" id="accuracy" value="accuracy">정확도순</button>
					<button class="btn btn-default" id="publishTime" value="publishTime">출간일</button>
					<button class="btn btn-default" id="title" value="title">제목</button>
					<button class="btn btn-default" id="salesPoint" value="salesPoint">판매량</button>
					<button class="btn btn-default" id="customerRating" value="customerRating">고객평점</button>
					<button class="btn btn-default" id="reviewCount" value="reviewCount">리뷰갯수</button>
					<button class="btn btn-default" id="price" value="price">가격오름순</button>
					<button class="btn btn-default" id="priceDesc" value="priceDesc">가격내림순</button>
				</div>
				
				<!-- 원래 페이지 바디 -->
				<div id="originalBody">
					<%=sb.toString()%>
				</div>
				
				<div id="pagingBody"></div>
			</div>
			<div id="pagingBody"></div>
			<ul class="pager">
				<li><button type="button" class="btn btn-default"
						id="previous" value="1">&#11164;&nbsp;이전 페이지</button></li>
				<li><button type="submit" class="btn btn-default" 
					id="next" value="2">다음 페이지&nbsp;&#11166;</button></li>
			</ul>
		</div>

		<!-- 페이지 스크롤업 -->
		<div id="upup">
			<img src="resources/img/arrow_up.png" >
		</div>

	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>