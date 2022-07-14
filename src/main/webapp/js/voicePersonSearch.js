var SpeechRecognition = SpeechRecognition || webkitSpeechRecognition
var SpeechRecognitionEvent = SpeechRecognitionEvent || webkitSpeechRecognitionEvent

var recognition = new SpeechRecognition();
recognition.continuous = true;
recognition.lang = 'en-US';
recognition.interimResults = true;
recognition.maxAlternatives = 1;
var recognizing = false;

var diagnostic = document.querySelector('.output');
var bg = document.querySelector('html');
var hints = document.querySelector('.hints');

window.onload = function() {
	recognition.start();
	console.log('Onload ready to receive commands.');
}

$( "#resetV" ).click(function() {
	recognition.start();
	console.log('On reset ready to receive commands.');
});

recognition.onresult = function(event) {

  var last = event.results.length - 1;
  var command = event.results[last][0].transcript.trim();
  diagnostic.textContent = 'Command received: ' + command;
  var regExpr = /[^a-zA-Z0-9-. ]/g;
  
		if (command == "home") {
			document.getElementById('homeV').click();
		} else if (command == "vehicle search") {
			document.getElementById('vehicleSearchV').click();
		} else if (command == "person search") {
			document.getElementById('personSearchV').click();
		} else if (command == "logout" || command == "log out") {
			document.getElementById('logoffV').click();
		} else if(command.includes("first name")){
			var firstName = command.replace("first","").replace("name","").replace("search","").replace(/\s/g, "").replace(regExpr,"");
			document.getElementById("fname").value=firstName;
			if(command.includes("search")){
				$("#searchForm").submit();
			}
		} else if(command.includes("middle name")){
			var middleName = command.replace("middle","").replace("name","").replace("search","").replace(/\s/g, "").replace(regExpr,"");
			document.getElementById("mname").value=middleName;
			if(command.includes("search")){
				$("#searchForm").submit();
			}
		} else if(command.includes("last name")){
			var lastName = command.replace("last","").replace("name","").replace("search","").replace(/\s/g, "").replace(regExpr,"");
			document.getElementById("lname").value=lastName;
			if(command.includes("search")){
				$("#searchForm").submit();
			}
		} else if(command == "search"){
			$("#searchForm").submit();
		} else{
			recognition.onnomatch();
		}
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
	recognition.start();
};

$(function() {
	if ($('#resultId').val() != undefined && $('#resultId').val() != ''){
		recognition.stop();
		speak($('#resultId').val());
	}
});

function speak(text, callback) {
	var u = new SpeechSynthesisUtterance();
    u.text = text;
    u.lang = 'en-US';
    u.onend = function () {
        if (callback) {
            callback();
        }
    };
    u.onerror = function (e) {
        if (callback) {
            callback(e);
        }
    };
    speechSynthesis.speak(u);
}
