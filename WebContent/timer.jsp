<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Timer</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
		<link rel='stylesheet prefetch' href='css/flipclock.css'>
		<link rel="stylesheet" href="css/style.css">
	</head>
	<body>
		<div class="container-fluid">
			<div class="row text-center">
				<header>
					<h1><span id="sessiontitle">Session Title</span></h1><br>
				</header>
			</div>
			<div class="row text-center flip-clock-wrapper centered">
				<span class="clock-header totalTimeLabel">Total Time</span><br>
				<div class="totalClock clock-size"></div>
				<br><br><br><br>
				<span class="clock-header partTimeLabel">Part Time</span><br>
				<div class="partClock"></div>
			</div> 
			<div class="row col-lg-6 col-lg-offset-3 text-center" style= "visibility:hidden">
				<div class="pull-left ">
					<span class="settings-head">Total</span>
					<h5 class="text-center">
						<span>&nbsp;<button id="removeTotal">-</button></span>
						<span class="durationvalue" id="totalValue">25</span> 
						<span>&nbsp;<button id="addTotal">+</button></span>
					</h5>
				</div>
				<div class="pull-right">
					<span class="settings-head">Part</span>
					<h5 class="text-center">
						<span>&nbsp;<button id="removePart">-</button></span>
						<span class="durationvalue" id="partValue">5</span>
						<span>&nbsp;<button id="addPart">+</button></span>
					</h5>
				</div>
			</div>
			<textarea class="form-control text-size text-center" id="messageWindow" rows="1" cols="50" readonly="true"></textarea>
		    <button class="btn-success" id="onTotalSwitch" style= "visibility:hidden"></button>
		    <button class="btn-success" id="onPartSwitch" style= "visibility:hidden"></button>
			<button class="btn-warning" id="offSwitch" style= "visibility:hidden"></button>
			<button class="btn-danger" id="resetSwitch" style= "visibility:hidden"></button>
			<button class="btn-danger" id="setSwitch" style= "visibility:hidden"></button>
		</div>
	
		<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
		<script src='js/flipclock.js'></script>
		<script src="js/index.js"></script>
		<script type="text/javascript">
	        var textarea = document.getElementById("messageWindow");
	        var webSocket = new WebSocket('ws://localhost:8080/Timer/Timer');
	        var inputMessage = document.getElementById('inputMessage');
		    webSocket.onerror = function(event) {
		      onError(event)
		    };
		    webSocket.onopen = function(event) {
		      onOpen(event)
		    };
		    webSocket.onmessage = function(event) {
		      onMessage(event)
		    };
		    function onMessage(event) {
		    	var key = (JSON.parse(event.data)).key;
		    	switch (key){
					 case "onTotalSwitch":
		    		  	  document.getElementById(key).click();
			    	    break;
			    	  case "offSwitch": 
			    		  document.getElementById(key).click();	
		    		 	break;
			    	  case "onPartSwitch":
			    		  document.getElementById(key).click();	
		    		 	break;
			    	  case "resetSwitch":
			    		  document.getElementById(key).click();
		    		 	break;
			    	  case "setting":
				    		var totalTime = parseInt((JSON.parse(event.data)).totalTime);
				    		var partTime = parseInt((JSON.parse(event.data)).partTime);
				    		$("#totalValue").html(totalTime);	
				    		$("#partValue").html(partTime);
				    		document.getElementById("setSwitch").click();
		    		 	break;
			    	  case "sessiontext":
				    		var sessiontitle = (JSON.parse(event.data)).sessiontitle;
				    		var time = parseInt((JSON.parse(event.data)).sessiontime);
				    		$("#sessiontitle").html(sessiontitle);
				    		$("#totalValue").html(time);
				    		document.getElementById("setSwitch").click();
		    		 	break;	
			    	  case "message":
					    	textarea.value = (JSON.parse(event.data)).text;
		    		 	break;
		    	}
		    }
		    function onOpen(event) {
		        textarea.value = "connect\n";
		    }
		    function onError(event) {
		      alert(event.data);
		    }
	        function disconnect(){
	            webSocket.close();
	        }
	  </script>
	</body>
</html>
