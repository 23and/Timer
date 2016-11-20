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
					<button class="btn-default" onclick="connect()">Connect</button>
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
			<textarea class="form-control text-size text-center" id="messageWindow" rows="2" cols="50" readonly="true"></textarea>
		    <div style="visibility:hidden">
				<input type="text" class="durationvalue" id="totalValue" value="10">
				<input type="text" class="durationvalue" id="partValue" value="5">
			</div>
		</div>
	
		<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
		<script src='js/flipclock.js'></script>
		<script src="js/index.js"></script>
		<script type="text/javascript">
			var host = location.host
	        var textarea = document.getElementById("messageWindow");
	        var inputMessage = document.getElementById('inputMessage');
	        var webSocket;
	        function connect(){
		        webSocket = new WebSocket('ws://' + host + '/Timer/Timer');
			    webSocket.onerror = function(event) {
				      onError(event)
			    };
			    webSocket.onopen = function(event) {
			      onOpen(event)
			    };
			    webSocket.onmessage = function(event) {
			      onMessage(event)
			    };
	        }
		    function onMessage(event) {
		    	var key = (JSON.parse(event.data)).key;
		    	var value = (JSON.parse(event.data)).value;
		    	switch (key){
		    	  case "set":
				    	var totalValue = (JSON.parse(event.data)).totalTime;
				    	var partValue = (JSON.parse(event.data)).partTime;
			    		$.set(value, totalValue, partValue);
	    		 	break;	    		 	
		    	  case "message":
				    	textarea.value = (JSON.parse(event.data)).value;
	    		 	break;
		    	  case "start":
		    		  $.start(value);
		    		  break;
		    	  case "stop":
		    		  $.stop(value);
		    		  break;
		    	  case "reset":
		    		  $.reset(value);
		    		  break;
		    	  case "remove":
		    		  $.timeControl(key, value);
		    		  break;
		    	  case "add":
		    		  $.timeControl(key, value);
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
