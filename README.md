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

- Create a project and add an iOS app to the project.
- You need the SDK_KEY in your project settings which you’ll need to initialize the SDK.
- Now you’re ready to integrate the SDK into your iOS application.
- The Roam iOS SDK requires Xcode 10.0 or later and it compatible with apps targeting iOS version 10 and above.

### Xcode Setup

To integrate the Roam SDK, you need a Roam account.

1. Go to Xcode > File > New Project

2. Configure the information property list file `Info.plist` with an XML snippet that contains data about your app. You need to add strings for `NSLocationWhenInUseUsageDescription` in the `Info.plist` file to prompt the user during location permissions for foreground location tracking. For background location tracking, you also need to add a string for `NSLocationAlwaysUsageDescription` and `NSLocationAlwaysAndWhenInUseUsageDescription` in the same` Info.plist` file.

   ```
   <key>NSLocationWhenInUseUsageDescription</key>
   <string>Add description for foreground only location usage.</string>


   <key>NSLocationAlwaysUsageDescription</key>
   <string>Add description for background location usage. iOS 10 and below"</string>


   <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
   <string>Add description for background location usage. iOS 11 and above</string>
   ```

3. Next you need to enable`Background fetch` and` Location updates` under `Project Setting` > `Capabilities` > `Background Modes`.

### CocoaPods Installation

Follow the steps below to add the SDK to the project using CocoaPods. Add the below to the `Podfile`

```
pod 'roam-ios'
```

Then run `pod install`.

This will add the Roam SDK and its dependencies to your project. The Roam SDK depends on `CoreLocation`, `AWSMobileClient` and `AWSIoT` for fetching locations and its transmission to our servers. The SDK supports iOS 10 and above.

### Manual Installation

If you’re not familiar with using Cocoapods or prefer manual installation, we’ve added a ZIP file to the SDK. Use this link to download the [Roam.zip](https://github.com/roam-ai/roam-ios/releases/download/0.0.1/Roam.zip) file.

Unzip the file and add the Roam `Roam.framework` to your Xcode project by dragging the file into your Project Navigator.

You can do this by selecting the project file in the navigator on the left side of the Xcode window, and then navigating to the Linked Frameworks and Libraries section. From there, click the “+” button to add the Roam framework.

### Initialize SDK

Add the following code in `AppDelegate.`. This code imports the SDK and allows the SDK to use other methods.

```
import roam-ios
```

After import, add the below code under `application(_:didFinishLaunchingWithOptions:) `in your `AppDelegate` class. The SDK must be initialized before calling any of the other SDK methods using your project's SDK key.

```
Roam.initialize("YOUR-SDK-KEY-GOES-HERE")
```

### Creating Users

Once the SDK is initialised, you need to *create* or *get a user* to start the tracking and use other methods. Every user created will have a unique Roam identifier which will be used to login and access developer APIs. We call this Roam `user_Id`.

```
Roam.createUser("SET-USER-DESCRIPTION-HERE") { (RoamUser, error) in
            //   access roam user id with roamUser?.userId
            //   access roam user description with roamUser?.userDescription
            //   access roam error code with error?.code
            //   access roam error message with error?.message
  }
```

The option *user description* can be used to update user information such as name, address or add an existing user ID. Make sure the information is encrypted if you are planning to save personal information like an email or phone number.

You can always set or update user descriptions later using the below code.

```
Roam.setDescription("SET-USER-DESCRIPTION-HERE")
```

### Get User

If you already have a Roam `user_ID` which you would like to reuse instead of creating a new user, use the code below to get a user session.

```
Roam.getUser("ROAM USER ID") { (roamUser, error) in
            //   access roam user id with roamUser?.userId
            //   access roam user description with roamUser?.userDescription
            //   access roam user description with error?.code
            //   access roam user description with error?.message
        }
```

### **Listeners**

Now that the location tracking is set up, you can subscribe to locations and events and use the data locally on your device or send it directly to your own backend server.

To do that, you need to toggle the location and event listener to `true`. By default, the status will set to `false` and needs to be set to `true` in order to stream the location and events updates to the same device or other devices.



```
Roam.toggleListener(Events: true, Locations: true) { (roamUser, error) in
      // access location lister status with roamUser?.locationListener
      // access events lister status roamUser?.eventListener
      // access roam error code with error?.code
      // access roam error message with error?.message
 }
```

### Request Permissions

Before you start location tracking, you need to get permission from the user for your application to access locations.

1. Import `CoreLocation` at the top of the `AppDelegate`. file.

   ```
   import CoreLocation
   ```

2. Make the below class declaration for Location Manager.

   ```
   let locationManager = CLLocationManager()
   ```

3.  Open `AppDelegate.` and add this line before the return statement in `application(_:didFinishLaunchingWithOptions:).` With this line, you ask users to allow the app to access location data both in the background and the foreground.

   ```
    locationManager.requestLocation()
   ```

### Location Tracking

#### Start Tracking

```
Roam.startTracking(TrackingMode)
```

Use the tracking modes while you use the startTracking method `Roam.startTracking`

#### Tracking Modes

You can now start tracking your users. Roam has three default tracking modes along with a custom version. They are different based on the frequency of location updates and battery consumption. The higher the frequency, the higher the battery consumption.

| **Mode** | **Battery usage** | **Updates every** | **Optimised for/advised for** |
| -------- | ----------------- | ----------------- | ----------------------------- |
| Active   | 6% - 12%          | 25 ~ 250 meters   | Ride Hailing / Sharing        |
| Balanced | 3% - 6%           | 50 ~ 500 meters   | On Demand Services            |
| Passive  | 0% - 1%           | 100 ~ 1000 meters | Social Apps                   |

```
//active tracking
Roam.startTracking(RoamTrackingMode.active);
// balanced tracking
Roam.startTracking(RoamTrackingMode.balanced);
// passive tracking
Roam.startTracking(RoamTrackingMode.passive);
```

#### Custom Tracking Modes

The SDK also provides a custom tracking mode which allows you to customize and build your own tracking mode as per your requirement.

| **Type**          | **Unit** | **Unit Range** |
| ----------------- | -------- | -------------- |
| Distance Interval | Meters   | 1m ~ 2500m     |

**Distance between location updates example code:**

```
// define a custom tracking method
let trackingMethod = RoamTrackingMethods.custom
// update the settings for the created method as per need
trackingMethod.activityType = .fitness
trackingMethod.pausesLocationUpdatesAutomatically = true
trackingMethod.showsBackgroundLocationIndicator = true
trackingMethod.distanceFilter = 10
trackingMethod.useSignificantLocationChanges = false
trackingMethod.useRegionMonitoring = false
trackingMethod.useVisits = false
trackingMethod.useSignificantLocationChanges = false
trackingMethod.desiredAccuracy = .nearestTenMeters
Roam.startTracking(.custom, options: trackingMethod)
```

**Time between location updates example code:**

```
// define a custom tracking method
let trackingMethod = RoamTrackingMethods.custom
trackingMethod.allowBackgroundLocationUpdates = true
trackingMethod.desiredAccuracy = kCLLocationAccuracyBest
// Update interval in seconds
trackingMethod.updateInterval = 10
Roam.startTracking(.custom, options: trackingMethod)
```

#### Stop Tracking

To stop the tracking use the below method.

```
Roam.stopTracking()
```

### Publish Messages

It will publish location data and these data will be sent to roam-ios servers for further processing and data will be saved in our database servers.

```
var roamPublish = RoamPublish()
Roam.publishSave(roamPublish)
```

To stop publishing the location data to other clients.

```
Roam.stopPublishing();
```

### Subscribe Messages

Now that you have enabled the location listener, use the below method to subscribe to your own or other user's location updates and events.

#### **Subscribe**

```
Roam.subscribe(TYPE, "USER-ID");
```

#### **UnSubscribe**

```
Roam.unSubscribe(TYPE, "USER-ID");
```

| **Type**               | **Description**                                              |
| ---------------------- | ------------------------------------------------------------ |
| RoamSubscribe.Events   | Subscribe to your own events.                                |
| RoamSubscribe.Location | Subscribe to your own location (or) other user's location updates. |
| RoamSubscribe.Both     | Subscribe to your own events and location (or) other user's location updates. |

## Documentation

See the full documentation [here](https://docs.roam.ai/ios).

## Example
See a Swift example app in `Example/`.
To run the example app, clone this repository, add your sdk "YOUR-SDK-KEY" key in `AppDelegate.swift`, and build the app.

## Need Help?
If you have any problems or issues over our SDK, feel free to create a github issue or submit a request on [Roam Help](https://geosparkai.atlassian.net/servicedesk/customer/portal/2).
