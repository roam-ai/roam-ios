//
//  AppDelegate.swift
//  RoamExample
//
//  Created by Roam Mac 15 on 07/04/21.
//

import UIKit
import Roam
import CoreLocation

@main


class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,RoamDelegate{
    
    
    
    let nc = NotificationCenter.default
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        Roam.setLoggerEnabled(logger: true)
        Roam.initialize("6e6d7628940bfcf95c1ede51767717d70abd5ea45c7da83ebea812dc89ae0499")
        Roam.delegate = self
        UNUserNotificationCenter.current().delegate = self;
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("D'oh: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Roam.setDeviceToken(deviceToken)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for notifications: \(error.localizedDescription)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound,.banner])
    }
    
    func didUpdateLocation(_ locations: [RoamLocation]) {
        print("didUpdateLocation",locations[0])
        showNotification(locations)
        AppUtility.saveLocationToLocal(locations)
        nc.post(name: Notification.Name("UserLoggedIn"), object: nil)

    }
        
    func didReceiveEvents(_ events: RoamEvents) {
        AppUtility.saveEventsToLocal(events)
        nc.post(name: Notification.Name("UserLoggedIn"), object: nil)
    }

    func didReceiveUserLocation(_ location: RoamLocationReceived) {
        print("didReceiveUserLocation",location.description)
        AppUtility.saveLocationToLocal(location)
        nc.post(name: Notification.Name("UserLoggedIn"), object: nil)
    }

    func onReceiveTrip(_ tripStatus: [RoamTripStatus]) {
        nc.post(name: Notification.Name("tripStatus"), object: nil, userInfo: ["trip":tripStatus])
    }

    func onError(_ error: RoamError) {
        print("onError \(String(describing: error.message))")
    }

    
    func showNotification(_ locations:[RoamLocation]){
            let content = UNMutableNotificationContent()
            content.title = locations[0].userId!
            content.subtitle = locations[0].location.description
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    
    func showNotification(_ dictionary:Dictionary<String,Any> ){
        
            let location = CLLocation(latitude: dictionary["latitude"] as! Double, longitude: dictionary["longitude"] as! Double)
        
            let content = UNMutableNotificationContent()
            content.title = location.description
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }

}


