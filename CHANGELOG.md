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