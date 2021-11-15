<p align="center">
  <a href="https://roam.ai" target="_blank" align="left">
    <img src="https://github.com/geosparks/roam-flutter/blob/master/logo.png?raw=true" width="180"> 
  </a>
  <br />
</p>

[![Pod version](https://badge.fury.io/co/roam-ios.svg)](https://badge.fury.io/co/roam-ios) [![CocoaPod Publish](https://github.com/roam-ai/roam-ios/actions/workflows/publish.yml/badge.svg?branch=0.0.1)](https://github.com/roam-ai/roam-ios/actions/workflows/publish.yml)

# Official Roam iOS SDK
This is the official [Roam](https://roam.ai) iOS SDK developed and maintained by Roam B.V

Note: Before you get started [signup to our dashboard](https://roam.ai) to get your API Keys. 

## Quickstart
The Roam iOS SDK makes it quick and easy to build a location tracker for your iOS app. We provide powerful and customizable tracking modes and features that can be used to collect your users’ location updates.

### Requirements
To use the Roam SDK, the following things are required:
Get yourself a free Roam Account. No credit card required.

- [x] Create a project and add an iOS app to the project.
- [x] You need the SDK_KEY in your project settings which you’ll need to initialize the SDK.
- [x] Now you’re ready to integrate the SDK into your iOS application.
- [x] The Roam iOS SDK requires Xcode 10.0 or later and it compatible with apps targeting iOS version 10 and above.

### Xcode Setup

To integrate the Roam SDK, you need a Roam account.

1. Go to Xcode > File > New Project

2. Configure the information property list file `Info.plist` with an XML snippet that contains data about your app. You need to add strings for `NSLocationWhenInUseUsageDescription` in the `Info.plist` file to prompt the user during location permissions for foreground location tracking. For background location tracking, you also need to add a string for `NSLocationAlwaysUsageDescription` and `NSLocationAlwaysAndWhenInUseUsageDescription` in the same` Info.plist` file.

   ```xml
   <key>NSLocationWhenInUseUsageDescription</key>
   <string>Add description for foreground only location usage.</string>
   <key>NSLocationAlwaysUsageDescription</key>
   <string>Add description for background location usage. iOS 10 and below"</string>
   <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
   <string>Add description for background location usage. iOS 11 and above</string>
   ```
   
   ![Screenshot 2021-06-25 at 8 40 46 PM](https://user-images.githubusercontent.com/19217956/123445597-aa8cf380-d5f5-11eb-9188-15ad742f11a8.png)


3. Next you need to enable`Background fetch` and` Location updates` under `Project Setting` > `Capabilities` > `Background Modes`.
    
   ![Screenshot 2021-06-25 at 8 38 24 PM](https://user-images.githubusercontent.com/19217956/123445386-74e80a80-d5f5-11eb-85d6-e06ef4300734.png)
  
  

### Include the SDK for iOS in an Existing Application

There are several ways to integrate the Roam Mobile SDK for iOS into your own project:

- [x] Swift Package Manager
- [x] CocoaPods
- [ ] Carthage (Will be added soon)
- [x] Dynamic Frameworks

#### Swift Package Manager Installation

1. Swift Package Manager is distributed with Xcode. To start adding the AWS SDK to your iOS project, open your project in Xcode and select File > Swift Packages > Add Package Dependency.

![image](https://user-images.githubusercontent.com/19217956/123749908-9259f480-d8d3-11eb-8193-1a02d940a298.png)

2. Enter the URL for the Roam SDK for iOS Swift Package Manager GitHub repo (https://github.com/roam-ai/roam-ios) into the search bar and click Next.

![Screenshot 2021-06-29 at 12 17 45 PM](https://user-images.githubusercontent.com/19217956/123750283-0d230f80-d8d4-11eb-9bfc-7f2004b612c5.png)

3. You'll see the repository rules for which version of the SDK you want Swift Package Manager to install. Choose the first rule, Version, and select Up to Next Minor as it will use the latest compatible version of the dependency that can be detected from the main branch, then click Next.

![Screenshot 2021-06-29 at 12 20 11 PM](https://user-images.githubusercontent.com/19217956/123750579-612df400-d8d4-11eb-918a-48799fa7999b.png)

4. Select all that are appropriate, then click Finish.

![Screenshot 2021-06-29 at 12 22 38 PM](https://user-images.githubusercontent.com/19217956/123750894-b8cc5f80-d8d4-11eb-9bdc-e809ad706702.png)

You can always go back and modify which SPM packages are included in your project by opening the Swift Packages tab for your project: Click on the Project file in the Xcode navigator, then click on your project's icon, then select the Swift Packages tab.


#### CocoaPods Installation

Follow the steps below to add the SDK to the project using CocoaPods. Add the below to the `Podfile`

```
pod 'roam-ios'
```

Then run `pod install`.

This will add the Roam SDK and its dependencies to your project. The Roam SDK depends on `CoreLocation`, `AWSMobileClient` and `AWSIoT` for fetching locations and its transmission to our servers. The SDK supports iOS 10 and above.

#### Manual Installation

If you’re not familiar with using Cocoapods or prefer manual installation, we’ve added a ZIP file to the SDK. Use this link to download the [Roam.zip](https://github.com/roam-ai/roam-ios/releases/download/0.0.12/Roam.xcframework.zip) file.

Unzip the file and add the Roam `Roam.framework` to your Xcode project by dragging the file into your Project Navigator.

You can do this by selecting the project file in the navigator on the left side of the Xcode window, and then navigating to the Linked Frameworks and Libraries section. From there, click the “+” button to add the Roam framework. You will also want to add the following frameworks from this [link](https://github.com/aws-amplify/aws-sdk-ios).

```
AWSAuthCore.xcframework
AWSCognitoIdentityProvider.xcframework
AWSCognitoIdentityProviderASF.xcframework
AWSCore.xcframework
AWSIoT.xcframework
AWSMobileClientXCF.xcframework
```
Make sure the the added frameworks under Linked Frameworks and Libraries section are selected as `Embed & Sign`

![Screenshot 2021-06-25 at 8 45 56 PM](https://user-images.githubusercontent.com/19217956/123446788-d8bf0300-d5f6-11eb-96e2-d88e432c209c.png)

### Initialize SDK

Add the following code in `AppDelegate` file. This code imports the SDK and allows the SDK to use other methods.

```swift
import Roam
```

After import, add the below code under `application(_:didFinishLaunchingWithOptions:) `in your `AppDelegate` file. The SDK must be initialized before calling any of the other SDK methods using your project's publishable key.

```swift
Roam.initialize("YOUR-SDK-KEY-GOES-HERE")
```

### Creating Users

Once the SDK is initialised, you need to *create* or *get a user* to start the tracking and use other methods. Every user created will have a unique Roam identifier which will be used to login and access developer APIs. We call this Roam `user_Id`.

```swift
Roam.createUser("YOUR-USER-DESCRIPTION-GOES-HERE") {(RoamUser, Error) in
            // Access Roam user data below
            // RoamUser?.userId
            // RoamUser?.description
            // RoamUser?.locationListener
            // RoamUser?.eventsListener
            // RoamUser?.locationEvents
            // RoamUser?.geofenceEvents
            // RoamUser?.tripsEvents
            // RoamUser?.nearbyEvents
            
            // Access error code & message below
            // Error?.code
            // Error?.message
        }
```

The option *user description* can be used to update user information such as name, address or add an existing user ID. Make sure the information is encrypted if you are planning to save personal information like an email or phone number.

You can always set or update user descriptions later using the below code.

```swift
Roam.setDescription("SET-USER-DESCRIPTION-HERE")
```

### Get User

If you already have a Roam `user_ID` which you would like to reuse instead of creating a new user, use the code below to get a user session.

```swift
Roam.getUser("YOUR-ROAM-USER-ID") {(RoamUser, Error) in
            // Access Roam user data below
            // RoamUser?.userId
            // RoamUser?.description
            // RoamUser?.locationListener
            // RoamUser?.eventsListener
            // RoamUser?.locationEvents
            // RoamUser?.geofenceEvents
            // RoamUser?.tripsEvents
            // RoamUser?.nearbyEvents
            
            // Access error code & message below
            // Error?.code
            // Error?.message
        }
```

### Request Permissions

Before you start location tracking, you need to get permission from the user for your application to access locations.

1. Import `CoreLocation` at the top of the `AppDelegate` file.

   ```swift
   import CoreLocation
   ```
2. Make the below class declaration for Location Manager and add this line before the return statement in `application(_:didFinishLaunchingWithOptions:)` With this line, you ask users to allow the app to access location data both in the background and the foreground.

   ```swift
   let locationManager = CLLocationManager()
   locationManager.requestLocation()
   ```

### SDK Configurations

#### Accuracy Engine

For enabling accuracy engine for Passive, Active, and Balanced tracking.

```swift
Roam.enableAccuracyEngine()
```

For Custom tracking mores, you can pass the desired accuracy values in integers ranging from 25-150m.

```swift
Roam.enableAccuracyEngine(50)
```
To disable accuracy engine

```swift
Roam.disableAccuracyEngine()
```

#### Offline Location Tracking

To modify the offline location tracking configuration, which will enabled by default. 

```swift
Roam.offlineLocationTracking(true)
```


### Location Tracking

#### Start Tracking

Use the below tracking modes while you use the startTracking method `Roam.startTracking`

#### Tracking Modes

You can now start tracking your users. Roam has three default tracking modes along with a custom version. They are different based on the frequency of location updates and battery consumption. The higher the frequency, the higher the battery consumption.

| **Mode** | **Battery usage** | **Updates every** | **Optimised for/advised for** |
| -------- | ----------------- | ----------------- | ----------------------------- |
| Active   | 6% - 12%          | 25 ~ 250 meters   | Ride Hailing / Sharing        |
| Balanced | 3% - 6%           | 50 ~ 500 meters   | On Demand Services            |
| Passive  | 0% - 1%           | 100 ~ 1000 meters | Social Apps                   |

```swift
//active tracking
Roam.startTracking(RoamTrackingMode.active)
// balanced tracking
Roam.startTracking(RoamTrackingMode.balanced)
// passive tracking
Roam.startTracking(RoamTrackingMode.passive)
```

#### Custom Tracking Modes

The SDK also provides a custom tracking mode which allows you to customize and build your own tracking mode as per your requirement.

| **Type**          | **Unit** | **Unit Range** |
| ----------------- | -------- | -------------- |
| Distance Interval | Meters   | 1m ~ 2500m     |

**Distance between location updates example code:**

```swift
// Define a custom tracking method
let trackingMethod = RoamTrackingCustomMethods()

// Update the settings for the created method as per need
trackingMethod.activityType = .fitness
trackingMethod.pausesLocationUpdatesAutomatically = true
trackingMethod.showsBackgroundLocationIndicator = true
trackingMethod.useSignificant = false
trackingMethod.useRegionMonitoring = false
trackingMethod.useVisits = false
trackingMethod.accuracyFilter = 10
trackingMethod.desiredAccuracy = .kCLLocationAccuracyNearestTenMeters

// Update the distance intervel as per the use case in meters
trackingMethod.distanceFilter = 10

// Start the tracking with the above created custom tracking method
Roam.startTracking(.custom, options: trackingMethod)
```

**Time between location updates example code:**

```swift
// Define a custom tracking method
let trackingMethod = RoamTrackingCustomMethods()

// Update the settings for the created method as per need
trackingMethod.activityType = .fitness
trackingMethod.pausesLocationUpdatesAutomatically = true
trackingMethod.showsBackgroundLocationIndicator = true
trackingMethod.useSignificant = false
trackingMethod.useRegionMonitoring = false
trackingMethod.useVisits = false
trackingMethod.accuracyFilter = 10
trackingMethod.desiredAccuracy = .kCLLocationAccuracyNearestTenMeters

// Update the time intervel as per the use case in seconds
trackingMethod.updateInterval = 10

// Start the tracking with the above created custom tracking method
Roam.startTracking(.custom, options: trackingMethod)
```

#### Stop Tracking

To stop the tracking use the below method.

```swift
Roam.stopTracking()
```

### Publish Messages

It will publish location data and these data will be sent to roam-ios servers for further processing and data will be saved in our database servers.

```swift
let locationData = RoamPublish()
Roam.publishSave(locationData)
```

To stop publishing the location data to other clients.

```swift
Roam.stopPublishing()
```

### Subscribe Messages

Now that you have enabled the location listener, use the below method to subscribe to your own or other user's location updates and events.

#### Subscribe

```swift
Roam.subscribe(TYPE, "ROAM-USER-ID")
```

#### UnSubscribe

```swift
Roam.unsubscribe(TYPE, "ROAM-USER-ID")
```

| **Type**               | **Description**                                              |
| ---------------------- | ------------------------------------------------------------ |
| RoamSubscribe.Events   | Subscribe to your own events.                                |
| RoamSubscribe.Location | Subscribe to your own location (or) other user's location updates. |
| RoamSubscribe.Both     | Subscribe to your own events and location (or) other user's location updates. |

### Listeners

Now that the location tracking is set up, you can subscribe to locations and events and use the data locally on your device or send it directly to your own backend server.

To do that, you need to toggle the location and event listener to `true`. By default, the status will set to `false` and needs to be set to `true` in order to stream the location and events updates to the same device or other devices.

```swift
Roam.toggleListener(Events: true, Locations: true) {(RoamUser, Error) in
            // Access Roam user data below
            // RoamUser?.userId
            // RoamUser?.description
            // RoamUser?.locationListener
            // RoamUser?.eventsListener
            // RoamUser?.locationEvents
            // RoamUser?.geofenceEvents
            // RoamUser?.tripsEvents
            // RoamUser?.nearbyEvents
            
            // Access error code & message below
            // Error?.code
            // Error?.message
        }
```

Once the listener toggles are set to true, to listen to location updates create a class that implements RoamDelegate and then call Roam.delegate.

Set your `RoamDelegate` in a code path that will be initialized and executed in the background. For example, make your AppDelegate implement GeoSparkDelegate, not a ViewController. AppDelegate will be initialized in the background, whereas a ViewController may not be.

```swift
import UIKit
import Roam
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate, RoamDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Roam.delegate = self
        Roam.initialize("YOUR-SDK-KEY-GOES-HERE")
        return true
    }
    func didUpdateLocation(_ location: RoamLocation) {
        // Do something with the user location
    }
    func didReceiveEvents(_ events: RoamEvents) {
        // Do smoething with user events
    }
    func didReceiveUserLocation(_ location: RoamLocationReceived) {
        // Do something with location of other users' subscribed location
    }
```

## Example
See a Swift example app in `Example/`.
To run the example app, clone this repository, add your sdk "YOUR-SDK-KEY" key in `AppDelegate.swift`, and build the app.

## Need Help?
If you have any problems or issues over our SDK, feel free to create a github issue or submit a request on [Roam Help](https://geosparkai.atlassian.net/servicedesk/customer/portal/2).
