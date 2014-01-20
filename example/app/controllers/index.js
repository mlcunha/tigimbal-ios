var tigimbal = require('com.stephenfeather.tigimbal');

Ti.API.info("module is => " + tigimbal.moduleId);

function init(e){
	tigimbal.init({
			setAppId: 'c127eb2eb823729a8899d5d212186695cea1811324d5d26dd079dc693b90889a', 
			appSecret:'488927e4e34ff34332126d4c9ee6fc8a56c64f3f5f5aca85ceb2e60d693f22c0', 
			callbackUrl:'tigimbal://authcode'
		});	
	$.startSession.enabled = true;
	$.startService.enabled = true;
	$.startService.on = true;
	$.startService.title = "Stop Service";

}

function startStopService(e){
	if (!$.startService.on){
		$.startSession.enabled = false;
		$.startService.on = true;
		$.startService.title = "Stop Service";
		
		tigimbal.startService();
	} else {
		$.startSession.enabled = true
		$.startService.on = false;
		$.startService.title = "Start Service";
		tigimbal.stopService();
	}
}

function startStopSession(e){
	if (!$.startSession.on){
		$.startService.enabled = false;
		$.startSession.on = true;
		$.startSession.title = "Stop Session";
		tigimbal.startServiceAndAuthorize();
	} else {
		$.startService.enabled = true
		$.startSession.on = false;
		$.startSession.title = "Start Session";
		tigimbal.stopServiceAndDeauthorize();
	}
}

function deleteVisitsAndSightings(){
	tigimbal.deleteVisitsAndSightings();
}

function setFileLogging(e){
	console.log(e.value);
	if (e.value == 1){
		tigimbal.enableFileLogging();
	} else {
		tigimbal.disableFileLogging();
	}
}

$.index.addEventListener('open', function (e) {
    
    if (OS_IOS) {
        
        // Handle the URL in case it opened the app
        console.log(Ti.App.getArguments());
        tigimbal.handleOpenURL(Ti.App.getArguments().url);
        // Handle the URL in case it resumed the app
        Ti.App.addEventListener('resume', function () {
            console.log(Ti.App.getArguments());
            tigimbal.handleOpenURL(Ti.App.getArguments().url);
        });
     }  
    
});

$.startSession.enabled = false;
$.startService.enabled = false;
$.startService.on = false;
$.startSession.on = false;
$.index.open();
