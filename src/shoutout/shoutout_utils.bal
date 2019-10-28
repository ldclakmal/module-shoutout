import ballerina/http;

# Check for HTTP response and if response is success parse HTTP response object into json and parse error otherwise.
#
# + response - Http response or HTTP connector error with network related errors
# + return - Json payload or `error` if anything wrong happen when HTTP client invocation or parsing response to json
function parseResponseToJson(http:Response|error response) returns json|error {
    if (response is http:Response) {
        var jsonPayload = response.getJsonPayload();
        if (jsonPayload is json) {
            if (response.statusCode != http:STATUS_OK && response.statusCode != http:STATUS_CREATED) {
                string message = response.statusCode.toString() + " " + response.reasonPhrase + " - "
                    + jsonPayload.toString();
                error err = error(SHOUTOUT_ERROR_CODE, message = message);
                return <@untainted> err;
            }
            return <@untainted> jsonPayload;
        } else {
            string message = "Error occurred when parsing response to json.";
            error err = error(SHOUTOUT_ERROR_CODE, message = message);
            return <@untainted> err;
        }
    } else {
        string message = <string>response.detail()?.message;
        error err = error(SHOUTOUT_ERROR_CODE, message = message);
        return <@untainted> err;
    }
}
