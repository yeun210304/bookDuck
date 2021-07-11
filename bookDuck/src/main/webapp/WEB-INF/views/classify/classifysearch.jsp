<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">
	
	#test{
		position: relative;
	}

	.allsearch{
		position: absolute;
		background-color:white;
		
	}
	



</style>



<script type="text/javascript">

	$(function(){				
		var opt = "0";
		var booklist = [];
		
		$("select[id=searchtag]").change(function(){
			opt = $(this).val();			
		});
		
		$("#search").on("propertychange change keyup paste input", function() {
			if($(this).val() !== "" && $(this).val().trim() !== ""){
				var search = $(this).val();				
				
				if(opt == 0){
					$.getJSON("classifyidajax.do?member_id="+search, function(list){
						var jsonlist = JSON.stringify(list);
						var jsondata = JSON.parse(jsonlist);
						var $add = $("#search").parent();						
						
						if(jsondata.list.length !== 0){		
							$add.find('span').remove();
							$add.find('div').remove();
							$add.append('<div class="allsearch"></div>')
							for(var i = 0; i < jsondata.list.length ; i++){								
								$add.find('div').append("<span>"+jsondata.list[i].member_id+"</span><br/>");
							}							
						}						
					});					
				} else {
					console.log("책 검색 영역");
					$.getJSON("classifybookajax.do?search="+search, function(result){
						// console.log(list);
						if(booklist.length !==0){
							booklist = [];
						}
						booklist = result.list;
						console.log(booklist);
						
						var $add = $("#search").parent();						
						
						for(var i = 0; i<booklist.length ; i++){
							$add.find('span').remove();
							$add.find('div').remove();
							$add.append('<div class="allsearch"></div>')
							for(var i = 0; i < booklist.length ; i++){								
								$add.find('div').append("<span>"+booklist[i].substring(0,15)+"...</span><br/>");
							}							
						}						
					});					
					
				}	
				
			} else {
				$("#search").parent().find('span').remove();
			}
		});
		
		/*
		$("#search").autocomplete({
		      source: idlist
		});		
		*/
		
		
	});



</script>



</head>
<body>




<table>
	<tr>
		<td>
			<select id="searchtag">
				<option value="0">ID</option>
				<option value="1">책</option>
			</select>	
		</td>		
		<td id="test"><input type="text" id="search"></td>
		<td><input type="button" value="검색" ></td>
	</tr>
	
</table>
이렇게 해도 되나 확인중



</body>
</html>