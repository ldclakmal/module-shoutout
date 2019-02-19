import ballerina/io;
import ballerina/log;
import ballerina/test;
import ballerina/config;

ShoutOutConfiguration shoutOutConfig = {
    apiKey: config:getAsString("API_KEY"),
    toMobile: config:getAsString("TO_MOBILE"),
    message: "This is a sample SMS sent by Ballerina connector!"
};

Client shoutOutClient = new(shoutOutConfig);

@test:Config
function testSendSMS() {
    log:printInfo("shoutOutClient -> SendSMS");

    var response = shoutOutClient->sendSMS();
    if (response is json) {
        io:println(response);
    } else {
        test:assertFail(msg = <string>response.detail().message);
    }
}
