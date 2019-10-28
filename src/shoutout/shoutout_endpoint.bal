import ballerina/http;
import ballerina/mime;

# Object for ShoutOut endpoint.
#
# + shoutOutClient - Http client endpoint for API
# + apiKey - ShoutOut API key
public type Client client object {

    http:Client shoutOutClient;
    string apiKey;

    public function __init(ShoutOutConfiguration shoutOutConfig) {
        self.apiKey = shoutOutConfig.apiKey;
        self.shoutOutClient = new(SHOUTOUT_API_URL);
    }

    # Returns all the authenticated user's task lists.
    #
    # + toMobile - Destination mobile number
    # + message - Message of SMS
    # + return - If success, returns json with of task list, else returns `error` object
    public remote function sendSMS(string toMobile, string message) returns json|error {
        http:Client httpClient = self.shoutOutClient;
        string requestPath = SMS_API;
        json payload = {
            'source: "ShoutDEMO",
            destinations: [toMobile],
            content: {
                sms: message
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
};

# Object for ShoutOut configuration.
#
# + apiKey - ShoutOut API key
public type ShoutOutConfiguration record {
    string apiKey;
};
