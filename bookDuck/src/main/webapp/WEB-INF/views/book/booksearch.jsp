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
System.out.println(key);
System.out.println(value);
System.out.println(start);

/*
Crawler craw = new Crawler();
craw.Crawler(value);
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
	"http://book.interpark.com/api/search.api?key=7A71D8E679DA9C96874476B8E225B77A4592E29959B15764C52A257C0343754F&query=%s&queryType=%s&start=%s&maxResults=10&inputEncoding=utf-8",
	URLEncoder.encode(value, "UTF-8"), key, start);
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
		String categoryId = xpath.compile("categoryId").evaluate(item);
		String categoryName = xpath.compile("categoryName").evaluate(item);
		//System.out.println(title);

		sb.append(String.format("<div class='row result'>"));
		sb.append(String.format("<div class='col-md-1'><span>%s</span></div>", a));
		sb.append(String.format("<div class='col-md-3'><img src='%s'></div>", coverLargeUrl));
		sb.append(String.format("<div class='col-md-6'><ul>"));
		sb.append(String.format("<li>title : %s</li>", title));
		sb.append(String.format("<li>author : %s</li>", author));
		sb.append(String.format("<li>publisher : %s</li>", publisher));
		sb.append(String.format("<li>description : %s</li>", description));
		sb.append(String.format("<li>priceStandard : %s</li>", priceStandard));
		sb.append(String.format("<li>pubDate : %s</li>", pubDate));
		sb.append(String.format("<li>isbn : %s</li>", isbn));
		sb.append(String.format("<li>categoryId : %s</li>", categoryId));
		sb.append(String.format("<li>categoryName : %s</li>", categoryName));
		sb.append(String.format("</ul></div>"));
		sb.append(String.format("<div><a href='%s' class='btn btn-default btn-xs' target='_blank'>인터파크 바로가기</a></div>",
		link));
		sb.append(String.format("</div>"));

	}
}
%>
<!DOCTYPE html>
<html>
<head>
<title>도서 검색</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<style>
div.result {
	border-top: 1px solid #dddddd;
	margin-top: 10px;
	padding: 20px;
	margin-bottom: 10px;
}
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>



<!-- jQuery library -->

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
<script>


	var currentPageNum; //현재 페이지 번호 저장용 전역변수
	
    $(document).ready(function() {
        $("#key option[value='<%=key%>']").attr("selected", "selected");
        $("#value").val('<%=value%>');
       	 currentPageNum = "1";
		 currentPage(currentPageNum);
        
		//이전, 다음 버튼 -> 페이지 이동
		$("#previous").click(function() {
			var previousNum = parseInt(currentPageNum)-1;
			//ajax($("#value").val(), $("#key option:selected").val(), previousNum);			
			currentPage(previousNum);
			startChange($("#value").val(), $("#key option:selected").val(), previousNum);
		});
	
		$("#next").click(function() {
			var nextNum = parseInt(currentPageNum)+1;
			//ajax($("#value").val(), $("#key option:selected").val(), nextNum);			
			currentPage(nextNum);
			startChange($("#value").val(), $("#key option:selected").val(), nextNum);
		});
		/*
	    function ajax(value, key, start) {
	    	console.log(key);
	    	console.log(value);
	    	console.log(start);
	    	
		    $.ajax({
		    	type : 'post',
		    	data : { "value" : value, "key" : key, "start" : start },
	
		    	success: function(data){
		    		console.log("통신 성공");
		    	}
		    })
	    
		}
	    */
	    

	    
	    function startChange(value, key, start){
	    	
            //console.log("시작");
	    	$.ajax({
            	
                type : "post",
                data: {"value" : value, "key" : key, "start" : start},
                
                success: function(list){
                	//console.log("성공");
                	//console.log(list);
                	//console.log(typeof(list));
                	//console.log(list.split("<li></li>"));
                	
        			
        			var arr = list.split('<');
        			//var arr2 = arr.split('</li>');
					console.log(arr);
					//console.log(arr[4]);
					
        			//console.log(arr[116]);
        			
                    var value = "";
                    
                    
                    for(var i=78; i < arr.length; i++){
                    	value += '<'+arr[i]
                    };
                    
                    console.log(value);
                    var value2 = value.split("<ul class=");
                    console.log(value2);
                    
                    
                    //$(".container").hide();
                    //$("#out").hide();
                    //$(".panel-heading").hide();
					//$(".panel-body").hide();
					//$(".panel-body").html(value);
					$("#originalpage").hide();
					//$("#hey").html(value);
                    //$(".container").html(value);
					$("#pagingBody").html(value2[0]);

                }, error: function(){
                    console.log("덧붙이기 ajax 실패");
                }
            });
        }
	    
    });			

	function currentPage(idx) {
		$(".currentPage").text(idx);
		currentPageNum = idx;
	}
    
</script>

</head>
<body>

	<div class="container">

		<div class="panel page-header" style="text-align: center;">
			<h1 style="font-size: xx-large;">
				<!-- 주의)상대경로 대신 절대경로 표기를 권장 -->
				도서검색 <small>인터파크</small> <span
					style="font-size: small; color: #777777;"></span>
			</h1>
		</div>

		<div class="panel-group">
			<div class="panel panel-default">
				<div class="panel-heading">도서 검색</div>
				<div class="panel-body">
					<form role="form" class="form-inline" method="POST">
						<input type="hidden" id="start" name="start" value="1">
						<select class="form-control" id="key" name="key">
							<option value="title">책 제목</option>
							<option value="isbn">ISBN</option>
						</select> 
						<input type="text" class="form-control" 
						id="value" name="value" required="required">
						<button type="submit" id="bts" class="btn btn-default">
							<span class="glyphicon glyphicon-search"></span>
							검색</button>
					</form>
				</div>
			</div>
		</div>


		<div class="panel panel-default" id="output">
			<div class="panel-heading">도서 검색 결과</div>
			<div class="panel-body" id="hey">
				<button type="button" class="btn btn-default">
					TotalCount <span class="badge" id="totalcount"><%=totalcount%></span>
				</button>
				<button type="button" class="btn btn-default">
					Count <span class="badge" id="count"><%=count%></span>
				</button>
				<button type="button" class="btn btn-default">
					CurrentPage <span class="badge currentPage">0</span>
				</button>
				<div id="originalpage">
				<%=sb.toString()%>
				</div>
				
				<div id="pagingBody"></div>
			</div>
			<div id="pagingBody"></div>
			<ul class="pager">
				<li><button type="button" class="btn btn-default"
						id="previous" value="1">Previous</button></li>
				<li><button type="submit" class="btn btn-default" 
					id="next" value="2">Next</button></li>
			</ul>
		</div>


	</div>

</body>
</html>