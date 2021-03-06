# ShoutOut Connector

The ShoutOut connector allows you to send targeted, personalized messages and engage with your customers.

## Compatibility

| Ballerina Language Version  |
|:---------------------------:|
| 1.2.0                       |

## Getting started

> Refer the [Getting Started](https://ballerina.io/learn/getting-started/) guide to download and install Ballerina.

> Refer the [Getting Started](https://developers.getshoutout.com/) guide to create ShoutOut API key and learn REST API.

Import the `ldclakmal/shoutout` module into the Ballerina project.
```ballerina
import ldclakmal/shoutout;
```

You can now enter the credentials and configurations in the ShoutOut client configuration record.
```ballerina
shoutout:ShoutOutConfiguration shoutOutConfig = {
    apiKey: ""
};
shoutout:Client shoutOutClient = new(shoutOutConfig);
```

The `sendSMS` function send a SMS to given number with given message.
```ballerina
string toMobile = "94777123456";
string message = "This is a sample SMS sent by Ballerina connector!";
    
var response = shoutOutClient->sendSMS(toMobile, message);
if (response is json) {
    io:println(response);
} else {
    log:printError("Failed to send SMS", err = response);
}
```

## Sample

```ballerina
import ballerina/io;
import ballerina/log;
import ldclakmal/shoutout;

shoutout:ShoutOutConfiguration shoutOutConfig = {
    apiKey: "sample_api_key"
};
shoutout:Client shoutOutClient = new(shoutOutConfig);

public function main() {
    string toMobile = "94777123456";
    string message = "This is a sample SMS sent by Ballerina connector!";
        
    var response = shoutOutClient->sendSMS(toMobile, message);
    if (response is json) {
        io:println(response);
    } else {
        log:printError("Failed to send SMS", err = response);
    }
}
```
