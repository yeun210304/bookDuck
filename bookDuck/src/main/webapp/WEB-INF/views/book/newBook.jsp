<%@ page language="java" contentType="text/html; charset=UTF-8"  
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="javax.xml.parsers.*" %>    
<%@ page import="org.w3c.dom.*" %>    
<%@ page import="org.xml.sax.*" %>    
<%@ page import="java.net.*" %>    
<%@ page import="javax.xml.xpath.*" %>    
<%@ page import="javax.xml.transform.*" %>    
<%@ page import="javax.xml.transform.dom.*" %>    
<%@ page import="javax.xml.transform.stream.*" %>    
<%
	request.setCharacterEncoding("UTF-8");
    //절대경로 확인
    String path = request.getContextPath();
 
    //인터파크 도서 검색에 대한 XML 요청 및 분석, 결과 출력
    //http://book.interpark.com/api/search.api?key=개인키&query=검색어&queryType=검색기준&maxResults=10&inputEncoding=utf-8
 
    
 
    StringBuilder sb = new StringBuilder();
    String totalcount = "0";
    String count = "0";
    

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = null;
        String str = String.format(
                "http://book.interpark.com/api/newBook.api?key=7A71D8E679DA9C96874476B8E225B77A4592E29959B15764C52A257C0343754F&categoryId=100",
                URLEncoder.encode("UTF-8"));
        URL url = new URL(str);
        InputSource is = new InputSource(url.openStream());
        doc = builder.parse(is);
    
     
        XPath xpath = XPathFactory.newInstance().newXPath();
        totalcount = xpath.compile("/channel/totalResults").evaluate(doc);
        NodeList itemList = (NodeList)xpath.compile("/channel/item").evaluate(doc, XPathConstants.NODESET);
        int count_ = itemList.getLength();
        count = String.valueOf(count_); 
        for (int a=1; a <= count_; a++) {
            Node item = (Node)xpath.compile(String.format("/channel/item[%s]", a)).evaluate(doc, XPathConstants.NODE);
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
            sb.append(String.format("<div><a href='%s' class='btn btn-default btn-xs' target='_blank'>&#128184;&nbsp;구매하기</a></div>", link));
            sb.append(String.format("</div>"));
            
        }
    
    
%>
<!DOCTYPE html>
<html>
<head>
<title>신작도서</title>
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
 
<!-- jQuery library -->
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 
<!-- Latest compiled JavaScript -->
<script
    src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 
<script>
 
    $(document).ready(function() {
       
    });
 
</script>
 
</head>
<body>
 
    <div class="container">
            
        <div class="panel page-header" style="text-align: center;">
            <h1 style="font-size: xx-large;">
            <!-- 주의)상대경로 대신 절대경로 표기를 권장 -->
                 &#128218;&nbsp;신작도서 <small></small> <span
                    style="font-size: small; color: #777777;"></span>
            </h1>
        </div>
       
 
 
        <div class="panel panel-default" id="output">
            <div class="panel-heading">&#128218;&nbsp;신작도서</div>
            <div class="panel-body">
                <button type="button" class="btn btn-default">
                      TotalCount <span class="badge" id="totalcount"><%=totalcount%></span>
                </button>
                <button type="button" class="btn btn-default">
                      Count <span class="badge" id="count"><%=count%></span>
                </button>
                
                <%=sb.toString() %>
                
            </div>
        </div>
    
    
    </div>
 
</body>
</html>

