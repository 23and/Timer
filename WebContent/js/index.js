$(document).ready(function(){
$("button").addClass("btn");
  var totalClock;
  var partClock;
  var totalValue;
  var partValue;
  var audio = new Audio('http://scambuster.info/audio/time_up.wav');

  partValue = parseInt($("#partValue").val() * 60);
  totalValue = parseInt($("#totalValue").val() * 60);

  totalClock = $('.totalClock').FlipClock(totalValue,{
		       clockFace: "HourlyCounter",
           autoStart: false,
           countdown: true,
           callbacks: {
            start: function(){
              $(".totalTimeLabel").addClass("text-success");
            },
             
             stop: function(){
              $(".totalTimeLabel").removeClass("text-success");
            },
        
            interval: function(){
              var totalTime = totalClock.getTime().time;
              var textarea = document.getElementById("messageWindow");
            }
           }
 });

  partClock = $('.partClock').FlipClock(partValue,{
      clockFace: "HourlyCounter",
  autoStart: false,
  countdown: true,
  callbacks: {
   start: function(){
     $(".partTimeLabel").addClass("text-success");
   },
    
    stop: function(){
     $(".partTimeLabel").removeClass("text-success");
   },

   interval: function(){
       var partTime = partClock.getTime().time;
       var textarea = document.getElementById("messageWindow");
       if(partTime === (parseInt($("#partValue").val() * 60))/2){
      	  textarea.style.color="Red";
      	  textarea.value = "Now you have 1 mintue. Please conclude your speech.";
        }
       if(partTime === 60){
     	  textarea.style.color="Red";
     	  textarea.value = "Now you have 1 mintue. Please conclude your speech.";
       }
       if(partTime === 0){
    	   textarea.style.color="#555";
      	  textarea.value = "Now time is up. Please end your speech for another speakers.";
        }
   }
  }
 });

  $("#onSwitch").click(function(){
      totalClock.setTime(parseInt($("#totalValue").val() * 60));
      partClock.setTime(parseInt($("#partValue").val() * 60));
      audio.play();
      totalClock.start();
      partClock.start();
  })
  
 $("#onTotalSwitch").click(function(){
      totalClock.setTime(parseInt($("#totalValue").val() * 60));
      audio.play();
      totalClock.start();
  })
  
 $("#onPartSwitch").click(function(){
	 partClock.setTime(parseInt($("#partValue").val() * 60));
     audio.play();
     partClock.start();
  })
  
 $("#setSwitch").click(function(){
	 totalClock.setTime(parseInt($("#totalValue").val() * 60));
	 partClock.setTime(parseInt($("#partValue").val() * 60));
  })  
  
  $("#setTotalSwitch").click(function(){
	 totalClock.setTime(parseInt($("#totalValue").val() * 60));
  })  
  
 $("#setPartSwitch").click(function(){
	 partClock.setTime(parseInt($("#partValue").val() * 60));
  })  
  
 $("#offSwitch").click(function(){
	 	 totalClock.stop();
         partClock.stop();
 })
 
  $("#offTotalSwitch").click(function(){
	 	 totalClock.stop();
 })
 
  $("#offPartSwitch").click(function(){
         partClock.stop();
 })

 $("#resetSwitch").click(function(){
 totalClock.stop();
 partClock.stop();
 totalClock.setTime(parseInt($("#totalValue").val() * 60));
 partClock.setTime(parseInt($("#partValue").val() * 60));

 })
  $("#resetTotalSwitch").click(function(){
 totalClock.stop();
 totalClock.setTime(parseInt($("#totalValue").val() * 60));
 })
 
  $("#resetPartSwitch").click(function(){
 partClock.stop();
 partClock.setTime(parseInt($("#partValue").val() * 60));
 })

  $("#addTotal").click(function(){
  totalValue = parseInt($("#totalValue").val());
  $("#totalValue").val(totalValue + 1);
  totalClock.setTime(parseInt($("#totalValue").val()) * 60);
})
  
  $("#removeTotal").click(function(){
  totalValue = parseInt($("#totalValue").val());
  $("#totalValue").val(totalValue - 1);
    if(totalValue === 1){
      $("#totalValue").val(1);
  }
  totalClock.setTime(parseInt($("#totalValue").val()) * 60);

})

  $("#addPart").click(function(){
  partValue = parseInt($("#partValue").val());
  $("#partValue").val(partValue + 1);
  partClock.setTime(parseInt($("#partValue").val()) * 60);

})
  
  $("#removePart").click(function(){
  partValue = parseInt($("#partValue").val());
  $("#partValue").val(partValue - 1);
  if(partValue === 1){
      $("#partValue").val(1);
  }
  partClock.setTime(parseInt($("#partValue").val()) * 60);

});

});