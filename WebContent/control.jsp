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
					<button class="btn-default" onclick="connect()">Connect</button>
					<h1 class="text-center title">Control</h1>
				</header>
			</div>
			<div class="row text-center">
				<div>
					<button class="btn-success" id="setSwitch" onclick="pushSet('set', this.id); $.set(this.id, $('#totalValue').val(), $('#partValue').val())">SET</button>
					<button class="btn-primary" id="onSwitch" onclick="pushSwitch('start', this.id); $.start(this.id);">START</button>
					<button class="btn-danger" id="offSwitch" onclick="pushSwitch('stop', this.id); $.stop(this.id);">STOP</button>
					<button class="btn-warning" id="resetSwitch" onclick="pushSwitch('reset', this.id); $.reset(this.id);">RESET</button>
				</div>
				<div class="col-sm-6 div-padding">
					<span class="clock-header">Session Time</span>
					<div class="row text-center flip-clock-wrapper centered clock-size">
						<button id="removeTotal" onclick="pushSwitch('remove', 'total'); $.timeControl('remove', 'total')"><</button>
						<div class="totalClock clock-height"></div>
						<button id="addTotal" onclick="pushSwitch('add', 'total'); $.timeControl('add', 'total')">></button>
					</div>
					<input type="text" class="durationvalue input-form" id="totalValue" value="10" size="4">minutes
					<button class="btn-success" id="setTotalSwitch" onclick="pushSet('set', this.id); $.set(this.id, $('#totalValue').val()), 0">SET</button>
					<button class="btn-primary" id="onTotalSwitch" onclick="pushSwitch('start', this.id); $.start(this.id);">START</button>
					<button class="btn-danger" id="offTotalSwitch" onclick="pushSwitch('stop', this.id); $.stop(this.id);">STOP</button>
					<button class="btn-warning" id="resetTotalSwitch" onclick="pushSwitch('reset', this.id); $.reset(this.id);">RESET</button>
				</div>
				<div class="col-sm-6 div-padding">
					<span class="clock-header">Speaking Slot</span>
					<div class="row text-center flip-clock-wrapper centered clock-size">
						<button id="removePart" onclick="pushSwitch('remove', 'part'); $.timeControl('remove', 'part')"><</button>
						<div class="partClock clock-height"></div>
						<button id="addPart" onclick="pushSwitch('add', 'part'); $.timeControl('add', 'part')">></button>
					</div>
					<input type="text" class="durationvalue input-form" id="partValue" value="5" size="4">minutes
					<button class="btn-success" id="setPartSwitch" onclick="pushSet('set', this.id); $.set(this.id, 0, $('#partValue').val())">SET</button>		
					<button class="btn-primary" id="onPartSwitch" onclick="pushSwitch('start', this.id); $.start(this.id);">START</button>
					<button class="btn-danger" id="offPartSwitch" onclick="pushSwitch('stop', this.id); $.stop(this.id);">STOP</button>
					<button class="btn-warning" id="resetPartSwitch" onclick="pushSwitch('reset', this.id); $.reset(this.id);">RESET</button>
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
			var host = location.host
	        var textarea = document.getElementById("messageWindow");
	        var inputMessage = document.getElementById('inputMessage');
	        var breakvalue = $("#breakvalue").html();
	        var webSocket;
	        function connect(){
	        	webSocket = new WebSocket('ws://' + host + '/Timer/Control');
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
			    		value: inputMessage.value
			    		}
		    	webSocket.send(JSON.stringify(value));
		        inputMessage.value = "";
		    }
	        function disconnect(){
	            webSocket.close();
	        }
	        
		    function pushSet(state, id) {
		    	var value;
		        var totalValue = $("#totalValue").val();
		        var partValue = $("#partValue").val();
		    	switch (id) {
		    	  case "setTotalSwitch":
			    	value = {
			    		key: state,
			    		value: id,
			    		totalTime: totalValue
			    	}
		    	    break;
		    	  case "setPartSwitch": 
			    	value = {
			    		key: state,
			    		value: id,
			    		partTime: partValue
			    	}
	    		 	break;
		    	  default:
	    		  	value = {
			    		key: state,
			    		value: id,
			    		totalTime: totalValue,
			    		partTime: partValue
			    	}  
	    		 	break;
		    	}
		        webSocket.send(JSON.stringify(value));
		    }
		    
		    function pushSwitch(state, id){
    		  	value = {
			    	key: state,
			    	value: id
			    	}
		    	webSocket.send(JSON.stringify(value));
		    }
	  </script>
	</body>
</html>
