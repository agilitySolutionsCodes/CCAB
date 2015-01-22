function keepAlive()
{
	clearTimeout();
	try
	{
		var http = Ajax.Http.request("Reconnect.aspx");
		window.status = "keep alive performed successfully at " + (new Date()).toString() + "!";
	}
	catch( ex )
	{
		alert( "The following error has occurred while trying to execute the \"keep alive\" function.\r\n\r\n"+ex.message );
	}
	setTimeout("keepAlive()", 300000); // 5 minutes 
}
// check if onload event is set to any function 
if ( typeof(window.onload) == "function" )
{
	if ( typeof(doOnLoad) != "function" ) var doOnLoad = window.onload;
}
// override onload event if any
window.onload = function() {
    try {
        if (typeof (doOnLoad) == "function") doOnLoad();
    }
    catch (ex) {
        alert("[ onload:error ]\r\n\r\nUnable to perform the desired action due to the following error.\r\n\r\n" + ex.message);
    }
    window.status = "keep alive is on!";
    setTimeout("keepAlive()", 300000); // 5 minutes
}
