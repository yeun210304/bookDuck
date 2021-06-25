<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.js"></script>
</head>
<body>

<div id="map" style="width:100%;height:600px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c4cbf31fc0b4bc0ff759253ed7b23a16&libraries=services"></script>
	<script type="text/javascript">
	// 위도 경도 변수 선언
	var lat; var lon;
	
	// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
		center: new kakao.maps.LatLng(33, 126), // 지도의 중심좌표
		level: 6 // 지도의 확대 레벨
		};

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption);
	console.log("lat : " + lat);
    console.log("lon : " + lon);
	// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
	if (navigator.geolocation) {
	    
	    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
	    navigator.geolocation.getCurrentPosition(function(position) {
	        
	        lat = position.coords.latitude; // 위도
	        lon = position.coords.longitude; // 경도
	        console.log('lat : ' + lat);
	    	console.log('lon : ' + lon);
	        console.log("위도 성공")
	        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	            message = '<div style="padding:5px;">현재 나의 위치</div>'; // 인포윈도우에 표시될 내용입니다
	        
	        // 마커와 인포윈도우를 표시합니다
	        displayMarker(locPosition, message);
	            
	        var ps = new kakao.maps.services.Places();
	        ps.keywordSearch('서점', placeSearchCB, {
	    		location : new kakao.maps.LatLng(lat, lon),
	    		size : 10,
	    		radius : 10000,
	    	});    
	      });
	    
	    console.log("lat_loc : " + lat);
	    console.log("lon : " + lon);
	    
	} else{
		
		 lat = 33;
		 lon = 126;
		
		 var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
         message = '<div style="padding:5px;">현재 나의 위치</div>'; // 인포윈도우에 표시될 내용입니다
     
	     // 마커와 인포윈도우를 표시합니다
	     displayMarker(locPosition, message);
	     console.log("lat_lat : " + lat);
	     console.log("lon : " + lon);
	     var ps = new kakao.maps.services.Places();
	     ps.keywordSearch('서점', placeSearchCB, {
	 		location : new kakao.maps.LatLng(lat, lon),
	 		size : 10,
	 		radius : 10000,
	 	});   
	}
	
	// 장소 검색 객체를 생성합니다
	/*
	var ps = new kakao.maps.services.Places();
	console.log('lat : ' + lat);
	console.log('lon : ' + lon);
	// 키워드로 장소를 검색합니다
	ps.keywordSearch('서점', placeSearchCB, {
		location : new kakao.maps.LatLng(lat, lon),
		size : 10,
		radius : 10000,
	});
	*/
	/*
	var searchOptions = {
		location : new kakao.maps.LatLng(lat, lon),
		size : 5,
		radius : 10000,
	};
	*/
	
	function placeSearchCB(data, status, pagination){
		if(status === kakao.maps.services.Status.OK){
			for(var i = 0; i < data.length; i++){
				displayMarker01(data[i]);
			}
		}
	}
	// 지도에 마커를 표시하는 함수입니다
	function displayMarker01(place) {
	    
	    // 마커를 생성하고 지도에 표시합니다
	    var marker = new kakao.maps.Marker({
	        map: map,
	        position: new kakao.maps.LatLng(place.y, place.x) 
	    });

	    // 마커에 클릭이벤트를 등록합니다
	    kakao.maps.event.addListener(marker, 'click', function() {
	        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
	        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
	        infowindow.open(map, marker);
	    });
	}
	
	// 지도에 마커와 인포윈도우를 표시하는 함수입니다
	function displayMarker(locPosition, message) {
	
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({  
	        map: map, 
	        position: locPosition
	    }); 
	    
	    var iwContent = message, // 인포윈도우에 표시할 내용
	        iwRemoveable = true;
	
	    // 인포윈도우를 생성합니다
	    var infowindow = new kakao.maps.InfoWindow({
	        content : iwContent,
	        removable : iwRemoveable
	    });
	    
	    // 인포윈도우를 마커위에 표시합니다 
	    infowindow.open(map, marker);
	    
	    // 지도 중심좌표를 접속위치로 변경합니다
	    map.setCenter(locPosition);      
	}    
	
		/*
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
	
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
	
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 
	
		// 키워드로 장소를 검색합니다
		ps.keywordSearch('서점', placesSearchCB, searchOptions); 
		var searchOptions = {
				location : new kakao.maps.LatLng(37.566826, 126.9786567),
				size : 15,
				radius : 5000,
		};
		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
	
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        var bounds = new kakao.maps.LatLngBounds();
	
		        for (var i=0; i<data.length; i++) {
		            displayMarker(data[i]);    
		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		        }       
	
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		        map.setBounds(bounds);
		    } 
		}
	
		// 지도에 마커를 표시하는 함수입니다
		function displayMarker(place) {
		    
		    // 마커를 생성하고 지도에 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: new kakao.maps.LatLng(place.y, place.x) 
		    });
	
		    // 마커에 클릭이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'click', function() {
		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
		        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
		        infowindow.open(map, marker);
		    });
		}
		*/
	</script>

</body>
</html>