## 0.0.1

* First version of new Roam SDK

## 0.0.2

Added:
- isTripSync() Method

Fixed:
- Fixed Location Id generation for Offline Trips

Modified:
- Replaced AWSIOT with CocoaMQTT

## 0.0.3

- Added support for total elevation gain to trip summary along with elevation gain, distance and duration for location date in trip summary.
- Added support new compiler version for Xcode 12.5.1 with Swift v5.4.2
- Fix for #1 and #2 

## 0.0.4

- Refactored to currect framework to support dependancies from local XCFrameworks.

## 0.0.5

- Updated dependency framworks to XCFramworks to avoid build issues during manual integration.

## 0.0.6

- #5 Added support for XCFrameworks
- #4 Added support for Swift Pacakge Manager
- #11 Updated the Docs to support the SPM integration steps

## 0.0.7

- #13  In order to support Apple Silicon M1 Macs, we added arm64 to iOS simulator builds.

## 0.0.8

- Fix for #23

## 0.0.9

Modified:
- #19 Allow meta-data support for updating location ie. updateCurrentLocation method
Removed:
- #20 Combine startTracking and startSelfTracking methods
Added:
- #21 Update location when user comes to stationary

## 0.0.10

Modified:
- #28 Make startTrip independent by combining it with startTracking and createTrip methods

Added:
- `metadata` support for user and trips are added

## 0.0.11

Added:
- Support to listen to location updates of user from different projects which are within same account.

Fixed:
- Multiple location updates recorded when user in stationary across all tracking

## 0.0.12

Modified:
- Custom tracking option will now work in terminated state. (SDK will wait for significant change in device location to restart the tracking again in background)

## 0.0.13

Fixed:
- Location activity was getting updated as stationary for all location points during terminated state.

## 0.0.14

Fixed:
- Improved `Roam.getCurrentLocation()` to return location faster.

## 0.0.15

Fixed:
- Issues in tracking location when the application is forced to terminate by the user, now the SDK will restart the tracking automatically.

## 0.0.16

Modified:
- Added option in `Roam.unSubscribe()`  which will now unsubscribe all users if `user_id` is passed as null or empty.
- Added battery and network details as part of location in location receiver.

## 0.0.17

Fixed:
- Removed the blue bar which was being displayed during active tracking.

## 0.0.18

Fixed:
- Fixed the coordinates arrangment for `Roam.getTripSummary()` on local trips.

## 0.0.19

Fixed:
- Added individual distance, duration and elevation gain for location data inside trip route for local trips.
- Trip summary response for local trip will have route sorted by recorded timestamp.
- Fixed background location tracking for time based tracking mode when location permission is given as 'Allow while using'.

## 0.0.20

Fixed:
- Fixed calculation for distance and duration for individual location data in trip summary route.

## 0.0.21

Added:
- Added new methods for batch configurations in location receiver.
Fixed:
- Updated trip error codes.

## 0.0.22

Added:
- Added callbacks to `Roam.resetBatchReceiverConfig` method to return default config values.

## 0.0.23
Added:
- Added new methods for batch configurations in trips data receiver.
- Trips data in trip receiver is changed from single object to list of updates.
Fixed:
- Fixes for core data for location and trips.

## 0.0.24
Added:
- Added timestamps to the trip listener data.
- Created option to unsubscribe from all the trips in the method `Roam.unsubscribeTripStatus()`
Fixed:
- Fixed trip listener to work independent to location listener.

## 0.0.25
Fixed:
- Fix for #32 and #31

## 0.0.26
Added:
- Added accuracy config methods for `Roam.getCurrentLocation()`, `Roam.updateCurrentLocation()` and Time based custom tracking.

Fixed:
- Fixed blue bar issue for custom tracking modes.
- Fixed location tracking issue when location permission is chnaged.

## 0.0.27
Fixed:
- Fixed build issues with v0.0.26.

## 0.0.28
Fixed:
- Fixed crashing behaviour while changing location permission.

## 0.0.29
Fixed:
- Fixed distance calculation logic for individual route points in `RoamTripsSummary`.

## 0.0.30
Fixed:
- Tracking config issue for time based tracking.
- Fixed crash when user received other user location.
- Removed blue bar on user logout without stop tracking.

## 0.0.31
Fixed:
- Making SDK backward compatible to support Xcode 13.x with Swift v5.6.1 along with the fix for crash issue receiving other user location.

## 0.0.32
Fixed:
- Making SDK backward compatible to support Xcode 14.x with Swift v5.7 along with the fix for crash issue receiving other user location.

## 0.0.33
Added:
- Added support for Roam.initialize() with custom configurations. 

## 0.0.34
Fixed:
- Location calibration when used along with accuracy config and time based tracking.
- Added elevation gain parameter to trip listener.
- Added speed parameter to location listener.

## 0.0.35
Fixed:
- Making SDK backward compatible to support Xcode 13.x with Swift v5.6.1.

## 0.0.36
- Added a new `Roam.requestAlwaysAuthorization()` method for location permission control.

## 0.0.37
Fixed:
- Fixed drift issuse for distance-based tracking. 

## 0.1.0
Modified:
- Updated new trip v2 methods. Refer Migration guide for more details.

## 0.1.1

Fixed:
- Crash when `Roam.getTrip()` is called without starting the trip.

Modified:
- Removed user id validation for offline trips.
- Create trip without user id. ie. optional
- Support to update trip based on trip state.

Added:
- Speed parameter to the routes in trips summary.
- Subscribe to online trips.

## 0.1.2

Added:
- Added accuracy config methods for `Roam.getCurrentLocation()`, `Roam.updateCurrentLocation()` and Time based custom tracking.
- Added timestamps to the trip listener data.
- Added option to unsubscribe from all the trips in the method `Roam.unsubscribeTripStatus()`
- Added new methods for batch configurations in trips data receiver.
- Trips data in a trip receiver is changed from a single object to a list of updates.
- Added new methods for batch configurations in location receiver.

Fixed:
- Fixed crashing behavior while changing location permission.
- Fixed blue bar issue for custom tracking modes.
- Fixed location tracking issue when location permission is changed.
- The fixed trip listener works independently of the location listener.
- Fixes core data for location and trips.

## 0.1.3
Added:
- Added elevation gain parameter to trip listener.
- Added speed parameter to location listener.

Fixed:
- Location calibration when used along with accuracy config and time-based tracking.
- Tracking config issue for time-based tracking.
- Fixed crash when user received other user location.
- Removed blue bar on user logout without stop tracking.
- Fixed distance calculation logic for individual route points in RoamTripsSummary.

## 0.1.4
Fixed:
- Fixed total elevation issuse in sync trip.

## 0.1.5
- Added basic ingest publish topic for aws cost optimisation.
- Fixed drift issuse for distance-based tracking.

## 0.1.6
- Tweaked the tracking algorithm for efficient battery consumption: We have made changes to our tracking algorithm to optimize battery consumption. The new algorithm is designed to reduce battery usage while maintaining the same level of accuracy and reliability.

## 0.1.7
In this release, we have made the following improvements to enhance the user experience of our Roam iOS SDK:
- Activity recognition methods: We have added activity recognition methods to the Roam iOS SDK to provide a more accurate and reliable determination of the user's current activity. This will improve the accuracy of location tracking, especially when the user is in motion.
- Improved tracking logic: To further improve battery consumption, we have made some changes to our tracking logic. These changes are aimed at ensuring that the Roam SDK is as efficient as possible in terms of energy usage, while still providing accurate location tracking.
We are confident that these changes will improve the overall experience of our Roam iOS SDK and we hope you enjoy these enhancements. If you have any questions or concerns, please feel free to reach out to us.

## 0.1.8
- Activity recognition permission issuse fixed.

## 0.1.9
- Fixed a number of crashes that occurred while tracking in specific scenarios, improving the overall stability of the SDK.
- Cleared console warnings to improve the developer experience.
- Improved user subscription process for a smoother and more streamlined experience.
- Improved location tracking logic to improve the accuracy and reliability of the SDK.
- Overall performance and stability of the SDK have been improved.

## 0.1.10
- Added few support for new error codes and messages in on `didError` delegate.

## 0.1.11
- Fixed mutiple users creating when calling `setDeviceToken` method.

## 0.1.12
- Fixed the tracking issue during terminated state for SDK only tracking.

## 0.1.13
We're excited to introduce Roam iOS SDK version 0.1.13, which includes a significant enhancement aimed at strengthening security within the SDK. Here's a breakdown of the latest changes:
- New Security Module: Roam
We've incorporated an advanced security module named Roam into the SDK. With this release, developers can take advantage of the toggleSecurity() method provided by Roam. This addition allows for seamless enabling and disabling of enhanced security measures. Protecting sensitive data is of paramount importance, and the Roam security module provides a streamlined way to fortify your application's defenses.
As always, we appreciate your feedback and contributions in helping us refine and enhance the Roam iOS SDK. Please feel free to reach out to our support team if you have any questions, concerns, or suggestions. Stay tuned for more updates as we continue to improve the SDK's capabilities and features.

## 0.1.14
We're excited to announce the latest release of the Roam iOS SDK version 0.1.14. This update brings a significant enhancement that contributes to heightened security and user control. Read on to discover the key highlights of this release:
- New Feature: Motion Detection Security
With Roam iOS SDK v0.1.14, we introduce an innovative security feature—Motion Detection. This cutting-edge capability adds an extra layer of protection to your application's tracking experience. By enabling the verifyMotion parameter in the toggleSecurity() method, developers can now leverage motion patterns to enhance security. This empowers you to monitor and respond to unusual motion activities, ensuring a safer and more reliable tracking environment.
As always, we appreciate your feedback and contributions in helping us refine and enhance the Roam iOS SDK. Please feel free to reach out to our support team if you have any questions, concerns, or suggestions. Stay tuned for more updates as we continue to improve the SDK's capabilities and features.


## 0.1.15
We're thrilled to announce the release of Roam iOS SDK version 0.1.15, bringing powerful enhancements and simplified integration. Here's what's new:

- **Callback Integration:** We've added callbacks to essential methods like `startTracking`, `stopTracking`, `subscribe`, `unSubscribe`, `publishAndSave`, and `stopPublishing`. These callbacks provide clear `onSuccess` and `onError` methods, ensuring you have complete control and real-time feedback for every SDK action.
- **Simplified Initialization:** Now, initializing the Roam SDK is easier than ever. Simply place your publishable key in the `.plist` file, streamlining the setup process and getting you up and running swiftly.

Your feedback has been invaluable in shaping these improvements. For any queries, assistance, or to share your experiences, our support team is here to help.

## 0.1.16
- Minor bug fixes and improvements for a smoother experience.

## 0.1.17
We're thrilled to present Roam iOS SDK version 0.1.17, focusing on bolstering our security module. In this update, we've made significant improvements to enhance the security of location data. Here's what's new:
Efficient Spoofed Location Detection: Our security algorithm has been refined to efficiently discard spoofed locations during the initial location fix. This enhancement ensures that only genuine and accurate location data is captured, enhancing the authenticity of the information gathered.
Addressing False Negatives: We've tackled false negatives during location tracking, ensuring that true locations are not mistakenly identified as spoofed locations. This refinement enhances the precision of location tracking, providing you with reliable and accurate data.
These security enhancements are designed to safeguard your data and ensure the integrity of the location information collected by the Roam iOS SDK. Your security is our priority, and we're committed to providing you with a secure and trustworthy experience. If you have any questions, concerns, or feedback, our support team is always here to assist you.

## 0.1.18
We're excited to introduce Roam iOS SDK version 0.1.18, focusing on enhancing our network module and refining tracking logics. In this update, we've made the following improvements:

- **Enhanced Connectivity during Location Tracking:** We've revamped the network module to handle few edge-cases on connectivity during location tracking. Expect smoother and more reliable communication between your app and Roam's services, ensuring a seamless experience for users even in challenging network conditions.
- **Minor Improvements to Tracking Logics:** We've implemented minor refinements to our tracking logics. These subtle enhancements aim to fine-tune the tracking mechanisms, resulting in improved accuracy and efficiency when capturing and processing location data.

These improvements are geared towards providing a more robust and consistent experience for developers and users alike. We're dedicated to optimizing your tracking capabilities and ensuring a smoother operational experience. Should you have any inquiries or feedback, our support team is readily available to assist you.

## 0.1.19
We're pleased to announce Roam iOS SDK version 0.1.19, primarily focused on resolving issues related to crashes occurring with Core Data and AWS IoT during location tracking in the background state and other rare scenarios. In this update, we've made the following fixes:

- **Core Data and AWS-IoT Crash Fixes:** Addressed crashes occurring during location tracking in the background state and other infrequent scenarios related to Core Data and AWS IoT integrations. Users can now expect improved stability and reliability when utilizing these features.

These fixes aim to enhance the overall stability of the SDK, ensuring a smoother experience for developers and users alike. We're committed to providing a robust and dependable SDK. If you encounter any further issues or have feedback to share, please reach out to our support team. We're here to assist you promptly.

## 0.1.20
We're excited to introduce Roam iOS SDK version 0.1.20, featuring the addition of a new feature called Custom MQTT Connector. This update enables developers to register custom MQTT endpoints to forward location updates directly from the SDK to the configured MQTT broker. Here's what's new:

- **Custom MQTT Connector:** Developers now have the capability to register custom MQTT endpoints, allowing seamless forwarding of location updates from the SDK to the specified MQTT broker. This feature provides greater flexibility and customization options for integrating location data into your applications.

These enhancements expand the capabilities of the Roam iOS SDK, empowering developers with more control over how location updates are managed and transmitted. We're committed to providing a versatile and robust SDK experience. For any inquiries or feedback regarding this new feature, our support team is here to assist you.

## 0.1.21
We're thrilled to announce Roam iOS SDK version 0.1.21, now compatible with the new compiler version for Xcode 15.3. This update ensures seamless integration and compatibility with the latest development environment. Here's what's new:

- **Compatibility with Xcode 15.3**: The Roam iOS SDK now fully supports the latest compiler version for Xcode 15.3. Developers can now leverage the latest tools and features offered by Xcode for an enhanced development experience.

We're committed to providing developers with the most up-to-date tools and resources to streamline their development process. If you have any questions or encounter any issues with the SDK integration, our support team is here to assist you.

## 0.1.22
We're pleased to announce the release of Roam iOS SDK version 0.1.22, addressing a critical crash issue encountered during location tracking. This fix ensures stability and reliability without impacting any other functionality of the SDK. Here's what's been resolved:

- **Fix for Crash During Location Tracking** : We've resolved an issue causing crashes during location tracking. This fix ensures uninterrupted performance and stability during location tracking, enhancing the overall tracking functionality.

We remain committed to delivering a seamless and reliable SDK experience for developers and users alike. If you encounter any further issues or have feedback to share, please don't hesitate to reach out to our support team. We're here to assist you every step of the way.

## 0.1.23
We're pleased to announce the release of Roam iOS SDK version 0.1.23, addressing a specific issue related to Roam.updateLocationWhenStationary() functionality. This fix ensures that the updateLocationWhenStationary() method continues to work seamlessly even when tracking is restarted during stationary periods, without impacting other SDK functionalities. Here's what's been resolved:

- **Fix for Roam.updateLocationWhenStationary() Issue**: We've resolved an issue where the updateLocationWhenStationary() method stopped working correctly when tracking was restarted during stationary periods. This fix ensures uninterrupted functionality and reliability for location updates, maintaining a smooth user experience.

We're committed to delivering a dependable and efficient SDK experience. If you have any further issues or feedback to share, our support team is available to assist you promptly.

## 0.1.24
We're excited to introduce Roam iOS SDK version 0.1.24, featuring the addition of two new modules to enhance your location tracking capabilities. In this update, we've made the following improvements:

- **RoamMQTTConnector:** This module enables custom MQTT connections, allowing developers to register custom MQTT endpoints for forwarding location updates directly from the SDK to the configured MQTT broker.
- **RoamBatchConnector:** This module allows for publishing location data in batches instead of in real-time using the pub/sub model. This enhancement provides flexibility in managing location data transmission and can help optimize performance and data usage.

These improvements are geared towards providing a more robust and versatile experience for developers and users alike. We're dedicated to optimizing your tracking capabilities and ensuring a smoother operational experience. Should you have any inquiries or feedback, our support team is readily available to assist you.

## 0.1.25
We're excited to introduce Roam iOS SDK version 0.1.25, focusing on aligning our response parameters with the Android SDK and enhancing stability. In this update, we've made the following improvements:

1. **Response Parameters for Roam.getTripSummary():** We've updated the response parameters for Roam.getTripSummary() to be consistent with our Android SDK, ensuring a seamless cross-platform experience for developers.
2. **Fixes for Background Mode Crashes:** We've addressed crashes that occurred when tracking with Background Modes - Location Updates capabilities disabled, enhancing the stability and reliability of the SDK.

These improvements are geared towards providing a more robust and consistent experience for developers and users alike. We're dedicated to optimizing your tracking capabilities and ensuring a smoother operational experience. Should you have any inquiries or feedback, our support team is readily available to assist you.

## 0.1.26
We're excited to introduce Roam iOS SDK version 0.1.26, focusing on resolving dependency and compilation issues. In this update, we've made the following improvements:

1. **Podspec Dependency Fixes:** We've updated the podspec to correctly include third-party frameworks as dependencies, ensuring a smoother integration process for developers using CocoaPods.
2. **Module Compiler Issue Fixes:** We've addressed module compiler issues, improving the overall stability and performance of the SDK.

These improvements are geared towards providing a more robust and consistent experience for developers and users alike. We're dedicated to optimizing your development process and ensuring a smoother operational experience. Should you have any inquiries or feedback, our support team is readily available to assist you.

## 0.1.27
We're excited to introduce Roam iOS SDK version 0.1.27, focusing on enhancing compatibility and refining the SDK setup. In this update, we've made the following improvements:

1. **Minimum Deployment Target Update for RoamMQTTConnector:** We've updated the minimum deployment target for the RoamMQTTConnector module to iOS 13.0, ensuring compatibility with newer iOS versions.
2. **Podspec Configuration Update:** We've refined the podspec to include only the core Roam SDK by default, simplifying the integration process for developers.

These updates are designed to provide a more streamlined and efficient experience for developers. We're committed to continuously improving the Roam iOS SDK to meet your needs. Should you have any inquiries or feedback, our support team is readily available to assist you.

## 0.1.28
We're pleased to announce the release of Roam iOS SDK version 0.1.28, with key fixes and enhancements aimed at improving tracking reliability and system performance. In this update, we've focused on the following areas:

1. **Resolved Tracking Issues in Airplane Mode**: We've addressed an issue where location tracking wasn't functioning correctly when the device was in Airplane mode. This fix ensures that tracking continues to operate smoothly, maintaining accurate location data even in offline scenarios.
2. **Improvements to AWSIoTDataManager Handling**: Enhancements have been made to AWSIoTDataManager, optimizing its performance and ensuring more efficient data transmission and handling. This update helps improve system stability and responsiveness during data communication.

These changes reflect our ongoing commitment to providing a reliable and efficient SDK for developers. If you have any questions or need further support, our team is available to assist.

## 0.1.29
Updates to React Native Wrapper Method
We're excited to introduce Roam iOS SDK version 0.1.29, with a focus on enhancing our React Native support. In this update, we've made the following improvements:

**React Native Wrapper Method Update**: We've updated the code for the React Native wrapper method to improve integration and streamline communication between the native iOS SDK and React Native apps. This update ensures better compatibility and smoother operation for developers using React Native.

These improvements are aimed at delivering a more seamless experience for developers working with React Native and Roam SDK. As always, if you have any questions or need assistance, our support team is here to help.


## 0.1.30-beta.1
**Active Tracking Performance Enhancement:** We've optimized the Active tracking mode with improved algorithms for location updates, resulting in more accurate tracking and better battery efficiency. This enhancement delivers more reliable location data while maintaining optimal device performance.
These improvements are aimed at providing developers with enhanced tracking capabilities while maintaining our commitment to efficient resource usage. As always, if you have any questions or need assistance, our support team is here to help.


## 0.1.30-beta.2

** Enhancements to Dynamic Geofence and Bug Fixes:** We're excited to introduce Roam iOS SDK version 0.1.30-beta.2, focusing on improving dynamic geofence functionality and resolving key issues. Here's what's new:

**Dynamic Geofence Enhancements:**
- Support for All Tracking Modes: Dynamic geofence now supports all three tracking modes, offering flexibility and precision for diverse use cases.
- Visits Horizontal Accuracy Location Filter: A new filter refines visit detection based on horizontal accuracy, delivering more precise location-based insights.
**Parameter Additions:**
- Additional parameters have been introduced to provide greater customization, enhancing functionality for developers.
**Bug Fixes:**
- Initialization Issue Resolved: Fixed a bug that caused issues during initialization, ensuring improved stability and reliability of the dynamic geofence feature.

These updates reflect our commitment to enhancing geofence capabilities and delivering a seamless experience. For any questions or feedback, our support team is ready to assist.

## 0.1.30-beta.3
** Framework Update for Xcode 16 Compatibility** 

We're excited to introduce Roam iOS SDK version 0.1.30-beta.3, focusing on ensuring compatibility with the latest development tools. Here's what's new:

Updated Framework for Xcode 16:
The framework has been updated to support Xcode 16, ensuring seamless integration and optimal performance with the latest version of Apple's development environment.
This update reflects our commitment to keeping the SDK compatible with the latest tools and technologies. If you have any questions or feedback, our support team is readily available to assist.

## 0.1.30-beta.4
** Enhancements in Location Precision and Data Enrichment ** 

We're thrilled to present Roam iOS SDK version 0.1.30-beta.4, introducing new features to improve location accuracy and data collection. Here's what's new:

** Data Enrichment** :Enhanced data collection capabilities to gather comprehensive device data from both Android and iOS platforms, enabling richer insights.

** Centroid Method** :Introduced a centroid calculation method to derive a representative central coordinate from clusters of geographical positions, offering a more reliable reference point.

These updates are designed to provide a more accurate and enriched tracking experience. If you have any questions, concerns, or feedback, our support team is always here to assist.

## 0.1.30-beta.5
**Enhancements in Visits, Geofence, and Data Enrichment**
We're excited to introduce Roam iOS SDK version 0.1.30-beta.5, with updates to improve functionality and enrich data insights. Here's what's new:

**Visits Improvements**:
Enhanced visit tracking logic for better accuracy and reliability in location-based insights.

**Location Fetch Logic Update**:
Refined logic for fetching location data when the app is open, ensuring smoother operation and improved accuracy.

**Flower Geofence Enhancement**:
Added an additional outer layer to the flower geofence, expanding its functionality and use cases.

**Centroid Data in Data Enrichment**:
Incorporated centroid calculation into data enrichment, offering a representative central coordinate for clustered geographical positions.

These updates are part of our commitment to providing robust and precise tracking capabilities. If you have any questions or feedback, our support team is always here to assist.

## 0.1.30-beta.6
**Enhanced Data Integrity with Core Data Model Migration**
We're pleased to announce Roam iOS SDK version 0.1.30-beta.6, which introduces support for Core Data model migration, ensuring seamless updates and enhanced data integrity.

This improvements is geared towards providing a more robust and consistent experience for developers, leveraging the latest features while maintaining a stable and consistent data layer. As always, if you need assistance or have feedback, our support team is here to help!
