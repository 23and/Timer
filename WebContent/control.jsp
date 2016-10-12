<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
		<title>Control</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
		<link rel='stylesheet prefetch' href='css/flipclock.css'>
		<link rel="stylesheet" href="css/style.css">
	</head>
	<body>
		<div class="container">
			<div class="row">
				<header>
					<h1 class="text-center title">Control</h1>
				</header>
			</div>
			<div class="row text-center">
				<div>
					<button class="btn-success" id="setSwitch" onclick="set()">SET</button>
					<button class="btn-primary" id="onSwitch" onclick="pushSwitch(this.id)">START</button>
					<button class="btn-danger" id="offSwitch" onclick="pushSwitch(this.id)">STOP</button>
					<button class="btn-warning" id="resetSwitch" onclick="pushSwitch(this.id)">RESET</button>
				</div>
				<div class="col-sm-6 div-padding">
					<span class="clock-header">Session Time</span>
					<div class="row text-center flip-clock-wrapper centered clock-size">
						<button id="removeTotal" onclick="pushSwitch(this.id)"><</button>
						<div class="totalClock clock-height"></div>
						<button id="addTotal" onclick="pushSwitch(this.id)">></button>
					</div>
					<input type="text" class="durationvalue input-form" id="totalValue" value="10" size="4">minutes
					<button class="btn-success" id="setTotalSwitch" onclick="set(this.id)">SET</button>
					<button class="btn-primary" id="onTotalSwitch" onclick="pushSwitch(this.id)">START</button>
					<button class="btn-danger" id="offTotalSwitch" onclick="pushSwitch(this.id)">STOP</button>
					<button class="btn-warning" id="resetTotalSwitch" onclick="pushSwitch(this.id)">RESET</button>
				</div>
				<div class="col-sm-6 div-padding">
					<span class="clock-header">Speaking Slot</span>
					<div class="row text-center flip-clock-wrapper centered clock-size">
						<button id="removePart" onclick="pushSwitch(this.id)"><</button>
						<div class="partClock clock-height"></div>
						<button id="addPart" onclick="pushSwitch(this.id)">></button>
					</div>
					<input type="text" class="durationvalue input-form" id="partValue" value="5" size="4">minutes
					<button class="btn-success" id="setPartSwitch" onclick="set(this.id)">SET</button>		
					<button class="btn-primary" id="onPartSwitch" onclick="pushSwitch(this.id)">START</button>
					<button class="btn-danger" id="offPartSwitch" onclick="pushSwitch(this.id)">STOP</button>
					<button class="btn-warning" id="resetPartSwitch" onclick="pushSwitch(this.id)">RESET</button>
				</div>
				<div>
					<div class="controls"></div>
				    <fieldset>
				        <textarea class="form-control" id="messageWindow" rows="3" cols="50" readonly="true"></textarea><br>
				        <div class="row col-xs-10">
				        	<input class="form-control" id="inputMessage" type="text"/>
				        </div>
				        <div class="pull-right">
				        	<input class="btn btn-round color-1 material-design" type="submit" value="send" onclick="send()" />
				        </div>
				    </fieldset>
			    </div>
			</div>
		</div>
		<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
		<script src='js/flipclock.js'></script>
		<script src="js/index.js"></script>
		<script type="text/javascript">
	        var textarea = document.getElementById("messageWindow");
	        var webSocket = new WebSocket('ws://localhost:8080/Timer/Control');
	        var inputMessage = document.getElementById('inputMessage');
	        var breakvalue = $("#breakvalue").html();
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
		        textarea.value += "Received message : " + event.data + "\n";
		        document.getElementById("buttonOnOff").click();
		    }
		    function onOpen(event) {
		        textarea.value = "connect\n";
		    }
		    function onError(event) {
		      alert(event.data);
		    }
		    function send() {
		        textarea.value = "message : " + inputMessage.value + "\n";
    		  	value = {
			    		key: "message",
			    		text: inputMessage.value
			    		}
		    	webSocket.send(JSON.stringify(value));
		        inputMessage.value = "";
		    }
	        function disconnect(){
	            webSocket.close();
	        }

		    function pushSwitch(id){
    		  	value = {
			    		key: id
			    		}
		    	webSocket.send(JSON.stringify(value));
		    }
		    function set(id) {
		    	var value;
		        var totalValue = $("#totalValue").val();
		        var partValue = $("#partValue").val();
		    	switch (id) {
		    	  case "setTotalSwitch":
			    	value = {
			    		key: id,
			    		time: totalValue
			    	}
		    	    break;
		    	  case "setPartSwitch": 
			    	value = {
			    		key: id,
			    		time: partValue
			    	}
	    		 	break;
		    	  default:
	    		  	value = {
			    		key: "setting",
			    		totalTime: totalValue,
			    		partTime: partValue
			    	}  
	    		 	break;
		    	}
		        webSocket.send(JSON.stringify(value));
		    }
	  </script>
	</body>
</html>
