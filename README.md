# Perfect FCM Server

## Summary

I have created this [Perfect](http://perfect.org/) package in order to send PUSH notification to iOS and Android devices threw the [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging/) system.

## Compatibility with Swift

The master branch of this project currently compiles with **Xcode 9.2** or the **Swift 4.0** toolchain on Ubuntu.

## Building

Add this project as a dependency in your Package.swift file.

```
    .package(url: "https://github.com/iMac0de/Perfect-FCM-Server.git", "1.0.0"..<"2.0.0")
```

## How to use it?

### Firebase Cloud Messaging server key

The first thing to do is to create a project on the [Firebase](https://firebase.google.com/) console in order to retrieve a server key.

### Config

In order to use the [Firebase](https://firebase.google.com/) API from your server side, you need to provide your server key to the Perfect FCM Server package.

```
    let config = PerfectFCM.Config(serverKey: YOUR_SERVER_KEY)
```
   
### Send a notification

Once the Perfect FCM Server is configured, you should be able to send PUSH notification threw the Firebase Cloud Messaging system.

```
    do {
	    try PerfectFCM.send(config, to: "A_FCM_DEVICE_TOKEN_OR_TOPIC", title: "YOUR_TITLE", body: "YOUR_BODY", data: ["CUSTOM_KEY": "CUSTOM_DATA"])
    } catch {
	    print(error.localizedDescription)
    }
```

It is possible to send the PUSH notification to a specific device by providing to the _to_ parameter the device token retrieved with a [Firebase client](https://firebase.google.com/docs/) or to a topic aka _/topics/daily-news_ where this topic send a PUSH notification each day to a group of devices for example.

### Store the device token

It is up to you to create the logic to store the device token once you get it. In my case, I generally create a REST API that allow me to POST some data about the devices and save them in a database. Here is my _Device_ class:

```
    class Device {
	    var name: String
	    var token: String
	    var brand: String
	    var model: String
	    var os: String
	    var version: String

		init() {
			self.name = ""
			self.token = ""
			self.brand = ""
			self.model = ""
			self.os = ""
			self.version = ""
		}

		init(name: String, token: String, brand: String, model: String, os: String, version: String) {
			self.name = name
			self.token = token
			self.brand = brand
			self.model = model
			self.os = os
			self.version = version
		}
    }
```

Then you can collect these data on your client device and store them to a [database](http://perfect.org/docs/databaseConnectors.html) of your choice.

You should know that a token is updated time-to-time for the same device. You should take that in account in order to be able to update the device in your database when the token has been changed.

## Test

If you want to test it, you can create the following script in a file (test.sh for exemple):

```
    #!/bin/sh
    
    export FCM_SERVER_KEY="YOUR_SERVER_KEY"
    export FCM_DEVICE_TOKEN="YOUR_DEVICE_TOKEN"
    swift test
```

Apply the execution right to the file:

```
    chmod +x test.sh
```

And then run the script:

```
    ./test.sh
```

You should receive a PUSH notification to your device with the title "Hello world!" and the body "Perfect FCM PUSH notification!".
    


