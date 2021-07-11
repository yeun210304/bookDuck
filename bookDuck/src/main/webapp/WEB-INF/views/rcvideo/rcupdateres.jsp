<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>
<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
<!-- include summernote css/js-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>
</head>
<script>
function goWrite(frm) {
	var rcvideo_content = frm.rcvideo_content.value;
	if (rcvideo_content.trim() == ''){
		alert("내용을 입력해주세요");
		return false;
	}
	frm.submit();
}
</script>
	
<script type="text/javascript">
		$(document).ready(function() {
		  $('#summernote').summernote({
			  height: 300,		//에디터 높이
			  minHeight: 300,	//최대 높이 => 설정시, 스크롤바 생성
			  maxHeight: null,
			  lang: "ko-KR",	// 한글 설정
			  callbacks: {		// 콜백사용
				  onImageUpload: function(files){
					  console.log(files);
					  sendFile(files[0]);
				  }
			  }
		  });
		});
		
		function sendFile(file){
			var data = new FormData();
			data.append("mpfile", file);
			$.ajax({
				data : data,
				type : "post",
				url : "imageUpload.do",
				cache : false,
				contentType: false,
				enctype: 'multipart/form-data',
				processData: false,
				success: function(url){
					//console.log(url);
					var path = "http://localhost:8787/bookduck";
					//console.log(path+url);
					var image = $('<img>').attr('src', path+url).attr('width','500');
					$("#summernote").summernote('insertNode', image[0]);
				}
			});
		}
	</script>


<body>
<h2 style="text-align: center;">추천 동영상 수정</h2><br><br><br>

<div style="width: 60%; margin: auto;">
	<form action="updatercvideo.do" method="post">
		<input type="hidden" name="book_isbn" readonly="readonly" style="width: 20%;" value="${scrapDto.book_isbn}"/><br>
		<input type="hidden" value="${scrapDto.book_isbn }">
		<input type="hidden" name="book_title" value="${scrapDto.book_title }">
		<input type="hidden" name="book_coverLargeUrl" value="${scrapDto.book_coverLargeUrl }">
		<input type="hidden" name="book_author" value="${scrapDto.book_author }">
		<input type="hidden" name="book_categoryId" value="${scrapDto.book_categoryId }">
		<br><br> 
		<textarea id="summernote" name="rcvideo_content">${rcvideoDto.rcvideo_content}</textarea>
		<input type="submit" value="수정하기" style="float: right;" onclick="goWrite(this.form)"/>
		<input type="button" value="취소" onclick="location.href='home.do'"/>
	</form>
	
	
</div>

</body>
</html>