$(document)
		.ready(
				function() {
					$("button").addClass("btn");
					var totalClock;
					var partClock;
					var totalValue;
					var partValue;
					var audio = new Audio('http://scambuster.info/audio/time_up.wav');

					partValue = parseInt($("#partValue").val() * 60);
					totalValue = parseInt($("#totalValue").val() * 60);

					totalClock = $('.totalClock')
							.FlipClock(totalValue,{
										clockFace : "HourlyCounter",
										autoStart : false,
										countdown : true,
										callbacks : {
											start : function() {
												$(".totalTimeLabel").addClass("text-success");
											},

											stop : function() {
												$(".totalTimeLabel").removeClass("text-success");
											},

											interval : function() {
												var totalTime = totalClock.getTime().time;
												var textarea = document.getElementById("messageWindow");
											}
										}
									});

					partClock = $('.partClock')
							.FlipClock(partValue,{
										clockFace : "HourlyCounter",
										autoStart : false,
										countdown : true,
										callbacks : {
											start : function() {
												$(".partTimeLabel").addClass("text-success");},

											stop : function() {
												$(".partTimeLabel").removeClass("text-success");
											},

											interval : function() {
												var partTime = partClock.getTime().time;
												var textarea = document.getElementById("messageWindow");
												if (partTime === (parseInt($("#partValue").val() * 60)) / 2) {
													textarea.style.color = "Red";
													textarea.value = "Now you spent the half of your time";
													setTimeout('$.text()',10000);
												}
												if (partTime === 60) {
													textarea.style.color = "Red";
													textarea.value = "Now you have 1 mintue. Please conclude your speech.";
												}
												if (partTime === 0) {
													textarea.style.color = "#555";
													textarea.value = "Now time is up. Please end your speech for another speakers.";
												}
											}
										}
									});
					$.text = function() {
						textarea.style.color = "#555";
						textarea.value = "";
					}
					$.start = function(id) {
						switch (id) {
						case "onSwitch":
							audio.play();
							totalClock.start();
							partClock.start();
							break;
						case "onTotalSwitch":
							audio.play();
							totalClock.start();
							break;
						case "onPartSwitch":
							audio.play();
							partClock.start();
							break;
						}
					}
					$.stop = function(id){
						switch (id) {
						case "offSwitch":
							totalClock.stop();
							partClock.stop();
							break;
						case "offTotalSwitch":
							totalClock.stop();
							break;
						case "offPartSwitch":
							partClock.stop();
							break;
						}
					}
					$.reset = function(id){
						switch (id) {
						case "resetSwitch":
							totalClock.stop();
							partClock.stop();
							totalClock.setTime(parseInt($("#totalValue").val() * 60));
							partClock.setTime(parseInt($("#partValue").val() * 60));
							break;
						case "resetTotalSwitch":
							totalClock.stop();
							totalClock.setTime(parseInt($("#totalValue").val() * 60));
							break;
						case "resetPartSwitch":
							partClock.stop();
							partClock.setTime(parseInt($("#partValue").val() * 60));
							break;
						}
					}
					$.timeControl = function(state, section){
						var value = "#" + section + "Value";
						var clock;
						if(section=="total"){
							clock = totalClock;
						}else if(section=="part"){
							clock = partClock;
						}
						switch(state){
						case "add":
							temp = parseInt($(value).val());
							$(value).val(temp + 1);
							clock.setTime(parseInt($(value).val()) * 60);
							break;
						case "remove":
							temp = parseInt($(value).val());
							$(value).val(temp - 1);
							if (temp === 1) {
								$(value).val(1);
							}
							clock.setTime(parseInt($(value).val()) * 60);
							break;
						}
					}
					$.set = function(id, totalValue, partValue) {
						var value;
						switch (id) {
						case "setTotalSwitch":
							$("#totalValue").val(totalValue);
							totalClock.setTime(parseInt(totalValue * 60));
							break;
						case "setPartSwitch":
							$("#partValue").val(partValue);
							partClock.setTime(parseInt(partValue * 60));
							break;
						default:
							$("#totalValue").val(totalValue);
							$("#partValue").val(partValue);
							totalClock.setTime(parseInt(totalValue * 60));
							partClock.setTime(parseInt(partValue * 60));
							break;
						}
					}
				});