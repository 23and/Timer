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
					<h1>Forum Timer</h1><br>
				</header>
			</div>
			<div class="text-center">
				<span class="clock-header totalTimeLabel">Session Time</span><br><br>
				<div class="row text-center flip-clock-wrapper centered">
					<div class="totalClock"></div>
				</div>
				<br><br><br><br><br><br>
				<span class="clock-header partTimeLabel">Speaking Slot</span><br><br>
				<div class="row text-center flip-clock-wrapper centered">
					<div class="partClock"></div>
				</div> 
			</div>
			<div class="row col-lg-6 col-lg-offset-3 text-center" style= "visibility:hidden">
				<div class="pull-left ">
					<span class="settings-head">Total</span>
					<h5 class="text-center">
						<input type="text" class="durationvalue" id="totalValue" value="10">
					</h5>
				</div>
				<div class="pull-right">
					<span class="settings-head">Part</span>
					<h5 class="text-center">
						<input type="text" class="durationvalue" id="partValue" value="5">
					</h5>
				</div>
			</div>
			<textarea class="form-control text-size text-center" id="messageWindow" rows="2" cols="50" readonly="true"></textarea>
		    <button id="onSwitch" style= "visibility:hidden"></button>
		    <button id="onTotalSwitch" style= "visibility:hidden"></button>
		    <button id="onPartSwitch" style= "visibility:hidden"></button>
			<button id="offSwitch" style= "visibility:hidden"></button>
			<button id="offTotalSwitch" style= "visibility:hidden"></button>
			<button id="offPartSwitch" style= "visibility:hidden"></button>
			<button id="resetSwitch" style= "visibility:hidden"></button>
			<button id="resetTotalSwitch" style= "visibility:hidden"></button>
			<button id="resetPartSwitch" style= "visibility:hidden"></button>
			<button id="setSwitch" style= "visibility:hidden"></button>
			<button id="setTotalSwitch" style= "visibility:hidden"></button>
			<button id="setPartSwitch" style= "visibility:hidden"></button>
			<button id="removeTotal" style= "visibility:hidden"> </button>
			<button id="addTotal" style= "visibility:hidden"></button>
			<button id="removePart" style= "visibility:hidden"> </button>
			<button id="addPart" style= "visibility:hidden"></button>
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
					 case "onSwitch":
		    		  	  document.getElementById(key).click();
			    	    break;
			    	  case "offSwitch": 
			    		  document.getElementById(key).click();	
		    		 	break;
			    	  case "resetSwitch": 
			    		  document.getElementById(key).click();	
		    		 	break;
					 case "onTotalSwitch":
		    		  	  document.getElementById(key).click();
			    	    break;
			    	  case "offTotalSwitch": 
			    		  document.getElementById(key).click();	
		    		 	break;
			    	  case "resetTotalSwitch": 
			    		  document.getElementById(key).click();	
		    		 	break;	
			    	  case "onPartSwitch":
			    		  document.getElementById(key).click();	
		    		 	break;
			    	  case "offPartSwitch":
			    		  document.getElementById(key).click();
		    		 	break;
			    	  case "resetPartSwitch":
			    		  document.getElementById(key).click();
		    		 	break;
			    	  case "removeTotal":
			    		  document.getElementById(key).click();
		    		 	break;
			    	  case "addTotal":
			    		  document.getElementById(key).click();
		    		 	break;
			    	  case "removePart":
			    		  document.getElementById(key).click();
		    		 	break;
			    	  case "addPart":
			    		  document.getElementById(key).click();
		    		 	break;	
			    	  case "setting":
				    		var totalTime = parseInt((JSON.parse(event.data)).totalTime);
				    		var partTime = parseInt((JSON.parse(event.data)).partTime);
				    		$("#totalValue").val(totalTime);	
				    		$("#partValue").val(partTime);
				    		document.getElementById("setSwitch").click();
		    		 	break;
			    	  case "setTotalSwitch":
				    		var time = parseInt((JSON.parse(event.data)).time);
				    		$("#totalValue").val(time);	
				    		document.getElementById("setTotalSwitch").click();
		    		 	break;
			    	  case "setPartSwitch":
				    		var time = parseInt((JSON.parse(event.data)).time);
				    		$("#partValue").val(time);
				    		document.getElementById("setPartSwitch").click();
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
