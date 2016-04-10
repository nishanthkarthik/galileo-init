var mraa = require('mraa');
console.log('MRAA Version: ' + mraa.getVersion());

var myOnboardLed = new mraa.Gpio(3, false, true);
myOnboardLed.dir(mraa.DIR_OUT);
var ledState = true;

periodicActivity();

function periodicActivity() {
	myOnboardLed.write(ledState ? 1 : 0);
	ledState = !ledState;
	setTimeout(periodicActivity, 500);
}