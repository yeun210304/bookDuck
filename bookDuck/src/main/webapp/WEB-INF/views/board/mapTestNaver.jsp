<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>간단한 지도 표시하기</title>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=e8f98sdo5u&submodules=geocoder"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<div id="map" style="width:100%;height:400px;"></div>

<script>
	var mapOptions = {
	    center: new naver.maps.LatLng(37.3595704, 127.105399),
	    zoom: 10
	};
	
	var map = new naver.maps.Map('map', mapOptions);
	
	// 인포윈도우 설정
	var infoWindow = new naver.maps.InfoWindow({
		anchorSkew : true
	});
	
	map.setCursor('pointer');
	
	// 검색 관련(주소 to 좌표)
	function searchAdressToCoordinate(address){
		naver.maps.Service.geocode({
			query: address
		}, function(status, response){
			if(status === naver.maps.Service.Status.ERROR){
				return alert('Geocode Error, address: ' + address);
			}
			if(response.v2.meta.totalCount === 0){
				return alert('No result');
			}
			var htmlAddress = [],
				item = response.v2.addresses[0],
				point = new naver.maps.Point(item.x, item.y);
			
			if (item.roadAddress) {
			      htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
			    }

			    if (item.jibunAddress) {
			      htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
			    }

			    if (item.englishAddress) {
			      htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
			    }

			    infoWindow.setContent([
			      '<div style="padding:10px;min-width:200px;line-height:150%;">',
			      '<h4 style="margin-top:5px;">검색 주소 : '+ address +'</h4><br />',
			      htmlAddresses.join('<br />'),
			      '</div>'
			    ].join('\n'));

			    map.setCenter(point);
			    infoWindow.open(map, point);
		});
	}
	
	function initGeocoder() {
		  if (!map.isStyleMapReady) {
		    return;
		  }

		  map.addListener('click', function(e) {
		    searchCoordinateToAddress(e.coord);
		  });
		  
		  searchAddressToCoordinate('서점');

		  $('#address').on('keydown', function(e) {
		    var keyCode = e.which;

		    if (keyCode === 13) { // Enter Key
		      searchAddressToCoordinate($('#address').val());
		    }
		  });

		  $('#submit').on('click', function(e) {
		    e.preventDefault();

		    searchAddressToCoordinate($('#address').val());
		  });

		  searchAddressToCoordinate('서점');
		}

		naver.maps.onJSContentLoaded = initGeocoder;
		naver.maps.Event.once(map, 'init_stylemap', initGeocoder);
	
</script>
</body>
</html>