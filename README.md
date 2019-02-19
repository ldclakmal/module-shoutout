# ShoutOut Connector

The ShoutOut connector allows you to send targeted, personalized messages and engage with your customers.

## Compatibility

| Ballerina Language Version  |
|:---------------------------:|
| 0.990.3                     |

## Getting started

> Refer the [Getting Started](https://ballerina.io/learn/getting-started/) guide to download and install Ballerina.
> Refer the [Getting Started](https://developers.getshoutout.com/) guide to create ShoutOut API key and learn REST API.

Import the `chanakal/shoutout` module into the Ballerina project.
```ballerina
import chanakal/shoutout;
```

You can now enter the credentials and configurations in the ShoutOut client configuration record.
```ballerina
shoutout:ShoutOutConfiguration shoutOutConfig = {
    apiKey: "",
    toMobile: "",
    message: "This is a sample SMS sent by Ballerina connector!"
};

shoutout:Client shoutOutClient = new(shoutOutConfig);
```

The `sendSMS` function send a SMS to initialized number.
```ballerina
    var response = shoutOutClient->sendSMS();
    if (response is json) {
        io:println(response);
    } else {
        test:assertFail(msg = <string>response.detail().message);
    }
```
