import ballerina/http;

# Check for HTTP response and if response is success parse HTTP response object into json and parse error otherwise.
#
# + response - Http response or HTTP connector error with network related errors
# + return - Json payload or `error` if anything wrong happen when HTTP client invocation or parsing response to json
function parseResponseToJson(http:Response|error response) returns json|error {
    if (response is http:Response) {
        var jsonPayload = response.getJsonPayload();
        if (jsonPayload is json) {
            if (response.statusCode != http:OK_200 && response.statusCode != http:CREATED_201) {
                map<string> details = { message: response.statusCode + WHITE_SPACE
                    + response.reasonPhrase + DASH_WITH_WHITE_SPACES_SYMBOL + jsonPayload.toString() };
                error err = error(SHOUTOUT_ERROR_CODE, details);
                return err;
            }
            return jsonPayload;
        } else {
            map<string> details = { message: "Error occurred when parsing response to json." };
            error err = error(SHOUTOUT_ERROR_CODE, details);
            return err;
        }
    } else {
        map<string> details = { message: <string>response.detail().message };
        error err = error(SHOUTOUT_ERROR_CODE, details);
        return err;
    }
}
