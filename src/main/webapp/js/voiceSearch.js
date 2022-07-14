var SpeechRecognition = SpeechRecognition || webkitSpeechRecognition
var SpeechRecognitionEvent = SpeechRecognitionEvent || webkitSpeechRecognitionEvent

var recognition = new SpeechRecognition();
recognition.continuous = true;
recognition.lang = 'en-US';
recognition.interimResults = true;
//recognition.maxAlternatives = 1;
var recognizing = false;

var diagnostic = document.querySelector('.output');
var bg = document.querySelector('html');
var hints = document.querySelector('.hints');

//var recognitionCmd = true;

window.onload = function() {
	recognition.start();
	console.log('Onload ready to receive commands.');
	console.log($("#searchForm").attr('action'));
}

$( "#resetV" ).click(function() {
	recognition.start();
	console.log('On reset ready to receive commands.');
});

recognition.onresult = function(event) {

  var last = event.results.length - 1;
  var command = event.results[last][0].transcript.trim();
  diagnostic.textContent = 'Command received: ' + command;
  	
  console.log(command);
//  	if (command == "start") {
//  		recognitionCmd = true;
//	} else if (command == "stop") {
//		recognitionCmd = false;
//	}
  	
//	if(recognitionCmd){

		if (command.includes("start")) {
			
		} else if (command == "home") {
			document.getElementById('homeV').click();
		} else if (command == "vehicle search") {
			document.getElementById('vehicleSearchV').click();
		} else if (command == "person search") {
			document.getElementById('personSearchV').click();
		} else if (command == "logout" || command == "log out") {
			document.getElementById('logoffV').click();
		} else{
			recognition.onnomatch();
		}
//  }
}

recognition.onstart = function() {
	console.log("Recognizing");
	recognizing = true;
  };

//recognition.onspeechend = function() {
//  recognition.stop();
//}

recognition.onnomatch = function(event) {
	console.log("Inside on no match");
	var command = diagnostic.textContent.replace("Command received:", "");
	diagnostic.textContent = "Command not recoginized: " + command;
//	recognition.stop();
//	recognition.abort();
//	recognition.start();
//	recognition.onend();
}

recognition.onerror = function(event) {
	console.log("Inside on error");
	diagnostic.textContent = 'Error occurred in recognition: ' + event.error;
//  recognition.stop();
//	recognition.abort();
//	recognition.start(); 
}

recognition.onend = function() {
	console.log("Inside on end");
	recognizing = false;
	console.log("NOT Recognizing");
    recognition.start();
};