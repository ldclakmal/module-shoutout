import ballerina/io;
import ballerina/log;
import ballerina/test;
import ballerina/config;

ShoutOutConfiguration shoutOutConfig = {
    apiKey: config:getAsString("API_KEY")
};
Client shoutOutClient = new(shoutOutConfig);

@test:Config{}
function testSendSMS() {
    log:printInfo("shoutOutClient -> SendSMS");

    string toMobile = config:getAsString("TO_MOBILE");
    string message = "This is a sample SMS sent by Ballerina connector!";

    var response = shoutOutClient->sendSMS(toMobile, message);
    if (response is json) {
        io:println(response);
    } else {
        test:assertFail(msg = <string>response.detail()?.message);
    }
}
