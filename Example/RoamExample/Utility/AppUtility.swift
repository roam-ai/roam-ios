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
    
    
    static func saveLocationToLocal(_ motion:RoamLocation) {
        let dataDictionary = ["latitude" : motion.location.coordinate.latitude, "longitude" : motion.location.coordinate.longitude,"activity":motion.activity!,"timeStamp" : AppUtility.currentTimestampWithHours()] as [String : Any]
        var dataArray = UserDefaults.standard.array(forKey: "RoamKeyForLatLongInfo")
        if let _ = dataArray {
            dataArray?.append(dataDictionary)
        }else{
            dataArray = [dataDictionary]
        }
        UserDefaults.standard.set(dataArray, forKey: "RoamKeyForLatLongInfo")
        UserDefaults.standard.synchronize()
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
    
}
