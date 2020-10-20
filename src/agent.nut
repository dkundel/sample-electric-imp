// Log the URLs we need
server.log("Turn LED On:  " + http.agenturl() + "?led=1");
server.log("Turn LED Off: " + http.agenturl() + "?led=0");

function requestHandler(request, response) {
    try {
        // Check if the user sent led as a query parameter
        if ("led" in request.query) {
            // If they did, and led = 1 or 0, set our variable to 1
            if (request.query.led == "1" || request.query.led == "0") {
                // Convert the led query parameter to a Boolean
                local ledState = (request.query.led == "0") ? false : true;

                // Send "set.led" message to device, and send ledState as the data
                device.send("set.led", ledState); 
            }
        }
    
        // Send a response back to the browser saying everything was OK.
        response.send(200, "OK");
  } catch (ex) {
        response.send(500, "Internal Server Error: " + ex);
  }
}

// Register the HTTP handler to begin watching for HTTP requests from your browser
http.onrequest(requestHandler);

function triggerFlow(callback = null) {
    local url = "https://studio.twilio.com/v2/Flows/FW9feacf5ebdf005eaf3a3a0ae4b4c24dd/Executions"

    local auth = http.base64encode(__VARS.ACCOUNT_SID + ":" + __VARS.AUTH_TOKEN);
    local headers = { "Authorization": "Basic " + auth };

    local body = http.urlencode({
        From = __VARS.TWILIO_PHONE_NUMBER,
        To = __VARS.MY_PHONE_NUMBER,
        Parameters = "{\"instructions\":\"Please come and pick it up.\"}"
    });

    local request = http.post(url, headers, body);
    if (callback == null) return request.sendsync();
    else request.sendasync(callback);
}

device.on("triggerFlow", triggerFlow);