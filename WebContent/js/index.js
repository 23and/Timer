$(document).ready(function(){
$("button").addClass("btn");
  var totalClock;
  var partClock;
  var totalValue;
  var partValue;
  var audio = new Audio('http://scambuster.info/audio/time_up.wav');

  partValue = parseInt($("#partValue").html() * 60);
  totalValue = parseInt($("#totalValue").html() * 60);

  totalClock = $('.totalClock').FlipClock(totalValue,{
		       clockFace: "MinuteCounter",
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
              if(totalTime === 55){
            	  textarea.style.color="Red";
            	  textarea.value = "The finish total time is coming";
              }
              if(totalTime === 0){
           	   textarea.style.color="#555";
             	  textarea.value = "finish";
               }
            }
           }
 });

  partClock = $('.partClock').FlipClock(totalValue,{
      clockFace: "MinuteCounter",
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
       if(partTime === 55){
     	  textarea.style.color="Red";
     	  textarea.value = "The finish part time is coming";
       }
       if(partTime === 0){
    	   textarea.style.color="#555";
      	  textarea.value = "finish";
        }
   }
  }
 });

 $("#onTotalSwitch").click(function(){
      totalClock.setTime(parseInt($("#totalValue").html() * 60));
      audio.play();
      totalClock.start();


  })
  
 $("#onPartSwitch").click(function(){
	 partClock.setTime(parseInt($("#partValue").html() * 60));
     audio.play();
     partClock.start();


  })  
 $("#setSwitch").click(function(){
	 totalClock.setTime(parseInt($("#totalValue").html() * 60));
	 partClock.setTime(parseInt($("#partValue").html() * 60));
  })  

 $("#offSwitch").click(function(){
	 	 totalClock.stop();
         partClock.stop();
 })

 $("#resetSwitch").click(function(){
 totalClock.stop();
 partClock.stop();
 totalClock.setTime(parseInt($("#totalValue").html() * 60));
 partClock.setTime(parseInt($("#partValue").html() * 60));

 })

  $("#addTotal").click(function(){
  totalValue = parseInt($("#totalValue").html());
  $("#totalValue").html(totalValue + 1);
  totalClock.setTime(parseInt($("#totalValue").html()) * 60);

})
  
  $("#removeTotal").click(function(){
  totalValue = parseInt($("#totalValue").html());
  $("#totalValue").html(totalValue - 1);
    if(totalValue === 1){
      $("#totalValue").html(1);
  }
  totalClock.setTime(parseInt($("#totalValue").html()) * 60);

})

  $("#addPart").click(function(){
  partValue = parseInt($("#partValue").html());
  $("#partValue").html(partValue + 1);
  partClock.setTime(parseInt($("#partValue").html()) * 60);

})
  
  $("#removePart").click(function(){
  partValue = parseInt($("#partValue").html());
  $("#partValue").html(partValue - 1);
  if(partValue === 1){
      $("#partValue").html(1);
  }
  partClock.setTime(parseInt($("#partValue").html()) * 60);

});

});