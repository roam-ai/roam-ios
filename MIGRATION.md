# Migration Guide

## Roam 0.0.x to Roam 0.1.x

- The `Roam.subscribeTripStatus()` method has been renamed to Roam.subscribeTrip() 
- The `Roam.updateTrip()` method is newly added.
- The `Roam.stopTrip()` method has been renamed to Roam.endTrip() 
- All the below trips method will use the new trips v2 logic where origins and destinations are called as stops.
    - `Roam.createTrip()`
    - `Roam.updateTrip()`
    - `Roam.deleteTrip()`
    - `Roam.getTrip()`
    - `Roam.getActiveTrips()`
    - `Roam.startTrip()`
    - `Roam.pauseTrip()`
    - `Roam.resumeTrip()`
    - `Roam.endTrip()`
    - `Roam.syncTrip()`
- The trip methods now returns `RoamTripCompletionhandlers` now returns trip and errors on calls to below method:
    - `Roam.createTrip()`
    - `Roam.updateTrip()`
    - `Roam.getTrip()`
    - `Roam.startTrip()`
    - `Roam.pauseTrip()`
    - `Roam.resumeTrip()`
    - `Roam.endTrip()`
- The trip methods now returns `RoamActiveTripsCompletionHandler ` now returns trips and errors on calls to `Roam.getActiveTrips()`
- The trip methods now returns `RoamDeleteTripCompletionHandler ` now returns trips and errors on calls to `Roam.deleteTrip()`
- The trip methods now returns `RoamSyncTripCompletionHandler ` now returns trips and errors on calls to `Roam.syncTrip()`

## Roam 0.0.8 to Roam 0.0.9

- `Roam.startSelfTracking()` and `Roam.stopSelfTracking()` are removed and converted to `Roam.startTracking()` and `Roam.stopTracking()`.
- The method names are merged together and the functionalities remains same.

## GeoSpark 3.1.x to Roam 0.0.x

- All the method of GeoSpark 3.1.x have been changed from `GeoSpark.METHOD_NAME` to `Roam.METHOD_NAME` in Roam 0.0.x
- The method names and the functionalities remains same.


