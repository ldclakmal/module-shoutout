import ballerina/http;
import ballerina/mime;

# Object for ShoutOut endpoint.
#
# + shoutOutClient - Http client endpoint for API
# + apiKey - ShoutOut API key
# + toMobile - Destination mobile number
# + message - SMS message
public type Client client object {

    http:Client shoutOutClient;
    string apiKey;
    string toMobile;
    string message;

    public function __init(ShoutOutConfiguration shoutOutConfig) {
        self.apiKey = shoutOutConfig.apiKey;
        self.toMobile = shoutOutConfig.toMobile;
        self.message = shoutOutConfig.message;
        self.shoutOutClient = new(SHOUTOUT_API_URL, config = shoutOutConfig.clientConfig);
    }

    # Returns all the authenticated user's task lists.
    #
    # + return - If success, returns json with of task list, else returns `error` object
    public remote function sendSMS() returns json|error;
};

# Object for ShoutOut configuration.
#
# + apiKey - ShoutOut API key
# + toMobile - Destination mobile number
# + message - SMS message
# + clientConfig - The http client endpoint
public type ShoutOutConfiguration record {
    string apiKey;
    string toMobile;
    string message;
    http:ClientEndpointConfig? clientConfig = {};
};

public remote function Client.sendSMS() returns json|error {
    http:Client httpClient = self.shoutOutClient;
    string requestPath = SMS_API;
    json payload = {
        source: "ShoutDEMO",
        destinations: [self.toMobile],
        content: {
            sms: self.message
        },
        transports: ["SMS"]
    };
    http:Request req = new;
    req.addHeader("Accept", mime:APPLICATION_JSON);
    req.addHeader("Authorization", "Apikey " + self.apiKey);
    req.setPayload(payload);

    var response = httpClient->post(SMS_API, req);
    var jsonResponse = parseResponseToJson(response);
    return jsonResponse;
}
