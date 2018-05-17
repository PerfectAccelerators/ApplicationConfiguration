# ApplicationConfiguration
A simple and codable way to configure a Perfect Application.

** This module is a part of PerfectAcelerators brought to you by the Perfect Community!**

## Installation
Using Swift Package Manager, add the following to your packages.swift

`.package(url: "https://github.com/PerfectAccelerators/ApplicationConfiguration.git", .branch("master"))`

Run `swift package update` and if you use Xcode run `swift package generate-xcodeproj`

## Usage
Create a file that includes the configuration for your application, for instance:

	{
	    "server": {
	        "baseURL": "localhost:8181",
	        "baseDomain": "localhost",
	        "port": 8181,
	        "secure": 0
	    },
	    "os": 2,
	    "environment": 1,
	    "ssl": {
	        "port": 443,
	        "originCertificatePath": "",
	        "privateKeyPath": "",
	        "verifyMode": "peer"
	    },
	    "logging": {
	        "requestLoggingPath": "./perfectRequests.log",
	        "logPath": "./perfect.log"
	    },
	    "db": {
	        "name": "perfect",
	        "host": "localhost",
	        "port": 3306,
	        "user": "",
	        "pass": "",
	        "driverType": 1
	    }
	}

Then modify your main.swift:

	import ApplicationConfiguration
	
	#if os(Linux)
	let fileRoot = "/perfect-deployed/Perfect/"
	let filePath = "./config/ApplicationConfigurationLinux.json"
	#endif
	
	let app = Application(name: "Perfect", path: filePath)
	
	do {
	    try HTTPServer.launch(app.server())
	} catch {
	    fatalError("\(error)")
	}

## Documentation
[Jazzy][1] generated documentation can be found [here][2]

## Contributing
To contribute a feature or idea to **ApplicationConfiguration**, fork the project, make your changes and submit a pull request :)

[1]:	https://github.com/realm/jazzy
[2]:    https://perfectaccelerators.github.io/ApplicationConfiguration/
