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
			<div class="row text-center flip-clock-wrapper">
				<div class="pull-left ">
					<span class="settings-head">Total Time</span>
					<h5 class="text-center">
						<span>&nbsp;<button id="removeTotal">-</button></span>
						<span class="durationvalue" id="totalValue">25</span> 
						<span>&nbsp;<button id="addTotal">+</button></span>
					</h5>
				</div>
				<div class="pull-right">
					<span class="settings-head">Part Time</span>
					<h5 class="text-center">
						<span>&nbsp;<button id="removePart">-</button></span>
						<span class="durationvalue" id="partValue">5</span>
						<span>&nbsp;<button id="addPart">+</button></span>
					</h5>
				</div>		
				<div class="controls">
					<button class="btn-sm btn-success" id="setSwitch" onclick="set()">SET</button>
					<button class="btn-sm btn-primary" id="onTotalSwitch" onclick="pushSwitch(this.id)">Total START</button>
					<button class="btn-sm btn-info" id="onPartSwitch" onclick="pushSwitch(this.id)">Part START</button>
					<button class="btn-sm btn-warning" id="offSwitch" onclick="pushSwitch(this.id)">STOP</button>
					<button class="btn-sm btn-danger" id="resetSwitch" onclick="pushSwitch(this.id)">RESET</button><br><br>
					<button class="btn-sm btn-default" id="1" onclick="sessionTitle(1)">Session 1</button>
					<button class="btn-sm btn-default" id="2" onclick="sessionTitle(2)">Session 2</button>
					<button class="btn-sm btn-default" id="3" onclick="sessionTitle(3)">Session 3</button>
					<button class="btn-sm btn-default" id="4" onclick="sessionTitle(4)">Session 4</button>
				</div>
			    <fieldset>
			        <textarea class="form-control" id="messageWindow" rows="3" cols="50" readonly="true"></textarea><br>
			        <div class=pull-left>
			        	<input class="form-control" id="inputMessage" type="text"/>
			        </div>
			        <div class=pull-right>
			        	<input class="btn btn-round color-1 material-design" type="submit" value="send" onclick="send()" />
			        </div>
			    </fieldset>
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
		    function set() {
		        var totalValue = $("#totalValue").html();
		        var partValue = $("#partValue").html();
		    	var value = {
		    		key: "setting",
		    		totalTime: totalValue,
		    		partTime: partValue
		    	}
		        webSocket.send(JSON.stringify(value));
		    }
		    function sessionTitle(session) {
		    	var value;
		    	switch (session) {
		    	  case 1:
	    		  	value = {
			    		key: "sessiontext",
			    		sessiontitle: "session1 title",
			    		sessiontime: 25
			    	}
		    	    break;
		    	  case 2: 
	    		  	value = {
			    		key: "sessiontext",
			    		sessiontitle: "session2 title",
			    		sessiontime: 30
			    	}  
	    		 	break;
		    	  case 3:
	    		  	value = {
			    		key: "sessiontext",
			    		sessiontitle: "session3 title",
			    		sessiontime: 35
			    	}  
	    		 	break;
		    	  case 4:
	    		  	value = {
			    		key: "sessiontext",
			    		sessiontitle: "session4 title",
			    		sessiontime: 40
			    	}  
	    		 	break;
		    	  default:
	    		  	value = {
			    		key: "sessiontext",
			    		sessiontitle: "session title",
			    		sessiontime: 25
			    	}  
	    		 	break;
		    	}
		        webSocket.send(JSON.stringify(value));
		    }
	  </script>
	</body>
</html>
