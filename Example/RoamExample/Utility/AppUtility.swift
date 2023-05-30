//
//  AppUtility.swift
//  TestExample
//
//  Created by Roam Mac 15 on 08/06/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import Foundation
import UIKit
import Roam

internal class AppUtility: NSObject {
    
    static func saveUserValue(_ user:RoamUser){
        SharedUtil.setDefaultBoolean(true, kFirstTime)
        SharedUtil.setDefaultString(user.userId, kUserId)
        if user.userDescription?.isEmpty == false{
            SharedUtil.setDefaultString(user.userDescription!, kUserdescription)
        }
        SharedUtil.setDefaultBoolean(user.geofenceEvents, kGeofence_events)
        SharedUtil.setDefaultBoolean(user.tripsEvents, kTrip_events)
        SharedUtil.setDefaultBoolean(user.locationEvents, kLocation_events)
        SharedUtil.setDefaultBoolean(user.nearbyEvents , kNearbyEvent_events)
        SharedUtil.setDefaultBoolean(user.eventsListener, kEvent_listeners)
        SharedUtil.setDefaultBoolean(user.locationListener, kLocation_listeners)
    }
    
    
    static func saveLocationToLocal(_ locations:[RoamLocation]) {
        
        locations.forEach { location in
            let dataDictionary = ["latitude" : location.location.coordinate.latitude, "longitude" : location.location.coordinate.longitude,"activity":location.activity!,"timeStamp" : AppUtility.currentTimestampWithHours()] as [String : Any]
            var dataArray = UserDefaults.standard.array(forKey: "RoamKeyForLatLongInfo")
            if let _ = dataArray {
                dataArray?.append(dataDictionary)
            }else{
                dataArray = [dataDictionary]
            }
            UserDefaults.standard.set(dataArray, forKey: "RoamKeyForLatLongInfo")
            UserDefaults.standard.synchronize()
        }
    }
    static func saveLocationToLocal(_ motion:RoamLocationReceived) {
        
        let dataDictionary = ["latitude" : motion.latitude ?? 0.0, "longitude" : motion.longitude ?? 0.0,"activity": motion.activity ?? "","timeStamp" : AppUtility.currentTimestampWithHours()] as [String : Any]
        var dataArray = UserDefaults.standard.array(forKey: "RoamKeyForLatLongInfoOthers")
        if let _ = dataArray {
            dataArray?.append(dataDictionary)
        }else{
            dataArray = [dataDictionary]
        }
        UserDefaults.standard.set(dataArray, forKey: "RoamKeyForLatLongInfoOthers")
        UserDefaults.standard.synchronize()
    }
    
    static func saveEventsToLocal(_ motion:RoamEvents) {
        let dataDictionary = ["description" : self.getTripEventDict(event: motion).description,"timeStamp" : AppUtility.currentTimestampWithHours()] as [String : Any]
        var dataArray = UserDefaults.standard.array(forKey: "RoamKeyForLatLongInfoEvents")
        if let _ = dataArray {
            dataArray?.append(dataDictionary)
        }else{
            dataArray = [dataDictionary]
        }
        UserDefaults.standard.set(dataArray, forKey: "RoamKeyForLatLongInfoEvents")
        UserDefaults.standard.synchronize()
    }
    
    
    
    static func SaveData(_ tracked:TrackedLocation){
        var loca = getData()
        loca.append(tracked)
        UserDefaults.standard.setStructArray(loca, forKey: allTrackedLocation)
    }
    
    static func getData() -> [TrackedLocation]{
        let location: [TrackedLocation] = UserDefaults.standard.structArrayData(TrackedLocation.self, forKey: allTrackedLocation)
        return location
    }
    
    static func currentTimestampWithHours() -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date()
        return dateFormatter.string(from: date)
    }
    
    static func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    static func currentTimestamp() -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        return dateFormatter.string(from: date)
    }
    
    static func getTripEventDict(event:RoamEvents)->[String:Any]{
        
        return [ "activity":event.activity as Any,
                 "altitude":event.altitude as Any,
                 "course":event.course as Any,
                 "createdAt":event.createdAt as Any,
                 "distance":event.distance as Any,
                 "eventSource":event.eventSource as Any,
                 "eventType":event.eventType as Any,
                 "geofenceId":event.geofenceId as Any,
                 "horizontalAccuracy":event.horizontalAccuracy as Any,
                 "coordinates":event.coordinates as Any,
                 "locationId":event.locationId as Any,
                 "userId":event.userId as Any,
                 "nearbyUserId":event.nearbyUserId as Any,
                 "recordedAt":event.recordedAt as Any,
                 "speed":event.speed as Any,
                 "tripId":event.tripId as Any,
                 "veritcalAccuracy":event.veritcalAccuracy as Any
            ] as [String : Any]
    }
    
    static func getStops(name:String? = nil,desc:String? = nil, address:String? = nil) -> RoamTripStop
    {
        let stop = RoamTripStop()
        stop.geometryCoordinates = [80.925026,16.6601249]
        stop.geometryRadius  = 1000
        stop.stopDescription = desc
        stop.address = address
        stop.stopName = name
        return stop
    }
    
    static func createTripParamter(_ response:RoamTripResponse) -> Dictionary<String,Any>{
        guard let trip = response.trip else {
            return [:]
        }
        var dict:Dictionary<String,Any> = [:]
        dict["description"] = response.errorDescription
        dict["message"] = response.message
        dict["code"] = response.code
        
        
        var tripDic:Dictionary<String,Any> = [:]
        tripDic["id"] = trip.tripId
        tripDic["description"] = trip.tripDescription
        tripDic["name"] = trip.tripName
        tripDic["trip_state"] = trip.tripState
        tripDic["total_elevation_gain"] = trip.totalElevationGain
        tripDic["total_distance"] = trip.totalDistance
        tripDic["total_duration"] = trip.totalDuration
        
        tripDic["createdAt"] = trip.createdAt
        tripDic["updatedAt"] = trip.updatedAt
        tripDic["startedAt"] = trip.startedAt
        tripDic["endedAt"] = trip.endedAt
        
        tripDic["isLocal"] = trip.isLocal
        tripDic["endedAt"] = trip.endedAt
        tripDic["metadata"] = trip.metadata
        
        let userDic:Dictionary<String,Any> = ["user_id":trip.user?.userId]
        tripDic["user"] = userDic
        
        if trip.stops.count != 0 {
            var stopDict:[Dictionary<String,Any>] = []
            trip.stops.forEach { stop in
                let dict = self.stopParameter(stop)
                stopDict.append(dict)
            }
            tripDic["stops"] = stopDict
        }
        
        if trip.events.count != 0 {
            var stopDict:[Dictionary<String,Any>] = []
            trip.events.forEach { stop in
                let dict = self.eventParameter(stop)
                stopDict.append(dict)
            }
            tripDic["events"] = stopDict
            
        }
        
        if trip.routes.count != 0 {
            var stopDict:[Dictionary<String,Any>] = []
            trip.routes.forEach { stop in
                let dict = self.tripRouteParameter(stop)
                stopDict.append(dict)
            }
            tripDic["route"] = stopDict
        }
        
        dict["trip"] = tripDic
        return dict
    }
    
    private static func stopParameter(_ tripStop:RoamTripStop) -> Dictionary<String,Any> {
        var stopDict:Dictionary<String,Any> = [:]
        stopDict["id"] = tripStop.stopId
        stopDict["metadata"] = tripStop.metadata
        stopDict["description"] = tripStop.stopDescription
        stopDict["name"] = tripStop.stopName
        stopDict["address"] = tripStop.address
        stopDict["geometry_radius"] = tripStop.geometryRadius
        var geometryDic:Dictionary<String,Any> = ["type":"Point"]
        geometryDic["coordinates"] = tripStop.geometryCoordinates
        stopDict["geometry"] = geometryDic
        return stopDict
    }
    
    private static func eventParameter(_ event:RoamTripEvents) -> Dictionary<String,Any> {
        var eventDict:Dictionary<String,Any> = [:]
        eventDict["id"] = event.eventsId
        eventDict["trip_id"] = event.eventsId
        eventDict["user_id"] = event.userId
        eventDict["event_type"] = event.eventType
        eventDict["event_source"] = event.eventSource
        eventDict["created_at"] = event.createAt
        eventDict["event_version"] = event.eventVersion
        return eventDict
    }
    
    
    private static func tripRouteParameter(_ route:RoamTripRoutes) -> Dictionary<String,Any> {
        var eventDict:Dictionary<String,Any> = [:]
        eventDict["recorded_at"] = route.recordedAt
        eventDict["activity"] = route.activity
        eventDict["duration"] = route.duration
        eventDict["distance"] = route.distance
        eventDict["altitude"] = route.altitude
        eventDict["elevation_gain"] = route.elevationGain
        let dict:Dictionary<String,Any> = ["type":"Point","coordinates":route.coordinates]
        eventDict["coordinates"] = dict
        return eventDict
    }
    
}
