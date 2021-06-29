<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

	<div style="display: none;">되나 진짜 인생 힘들다</div>
	<button type="button">낭독</button>
	<script>
		var voices = [];
		function setVoiceList() {
			voices = window.speechSynthesis.getVoices();
		}
		
		setVoiceList();
		if (window.speechSynthesis.onvoiceschanged !== undefined) {
			window.speechSynthesis.onvoiceschanged = setVoiceList;
		}
		
		function speech(txt) {
			
			if (!window.speechSynthesis) {
				alert("음성 재생을 지원하지 않는 브라우저입니다. 크롬, 파이어폭스 등의 최신 브라우저를 이용하세요");
				return;
			}
			var lang = 'ko-KR';
			var utterThis = new SpeechSynthesisUtterance(txt);
			utterThis.onend = function(event) {
				console.log('end');
			};
			utterThis.onerror = function(event) {
				console.log('error', event);
			};
			var voiceFound = false;
			for (var i = 0; i < voices.length; i++) {
				if (voices[i].lang.indexOf(lang) >= 0
						|| voices[i].lang.indexOf(lang.replace('-', '_')) >= 0) {
					utterThis.voice = voices[i];
					voiceFound = true;
				}
			}
			if (!voiceFound) {
				alert('voice not found');
				return;
			}
			utterThis.lang = lang;
			utterThis.pitch = 1.0; // 0.4 ~ 1.0
			utterThis.rate = 0.7; //속도
			window.speechSynthesis.speak(utterThis);
		
		}
		document.addEventListener("click", function(e) {
			var t = e.target;
			var input = t.previousElementSibling;
			speech(input.innerHTML);
		});
	</script>


</body>
</html>

















