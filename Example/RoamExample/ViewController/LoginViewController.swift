//
//  ViewController.swift
//  MotionExample
//
//  Created by Roam Mac 15 on 01/06/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import UIKit
import Roam

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var createUserBtn: UIButton!
    @IBOutlet weak var getUserBtn: UIButton!
    @IBOutlet weak var requestLocation: UIButton!
    @IBOutlet weak var startTracking: UIButton!
    @IBOutlet weak var stopracking: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        userIdTextField.delegate = self
        
        if SharedUtil.getDefaultBoolean(kSelfStarTracking){
            startTracking.isHidden = true
            stopracking.isHidden = false
        }else{
            startTracking.isHidden = false
            stopracking.isHidden = true
        }
    }
    
    @IBAction func createUserAction(_ sender: Any) {
        showHud()
        Roam.createUser("", nil) { user, error in
            if error != nil{
                Alert.alertController(title: "Create User", message: error?.message, viewController: self)
            }else{
                AppUtility.saveUserValue(user!)
                DispatchQueue.main.async {
                    let vc = EventsLoginViewController.viewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            self.dismissHud()
        }
    }
    
    @IBAction func getUserAction(_ sender: Any) {
        
        if userIdTextField.text!.isEmpty{
            Alert.alertController(title: "Get User", message: "User id cannot be empty", viewController: self)
        }else{
            showHud()
            Roam.getUser(userIdTextField.text!) { (user, errorStatus) in
                self.dismissHud()
                if errorStatus != nil{
                    Alert.alertController(title: "Get User", message: errorStatus?.message, viewController: self)
                }else{
                    AppUtility.saveUserValue(user!)
                    DispatchQueue.main.async {
                        let vc = EventsLoginViewController.viewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }
    
    
    @IBAction func startSelfTrackingAction(_ sender: Any) {
        updateTracking()
    }
    
    @IBAction func stopSelfTrackingAction(_ sender: Any) {
        SharedUtil.removeKey(kSelfStarTrackingOption)
        Roam.stopTracking()
        updateTrackingValue(false)
    }
    
    @IBAction func trackingLocation(_ sender:Any){
        let vc = MapViewController.viewController()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func requestLocationAction(_ sender: Any) {
        Roam.requestLocation()
    }
    
    func updateTracking(){
        let alert = UIAlertController(title: "Choose Tracking options", message: nil  , preferredStyle: .actionSheet)
        
        
        let powerSaver = UIAlertAction(title: "Passive", style: .default) { (alert) in
            Roam.startTracking(.passive)
            SharedUtil.setDefaultString("Passive", kSelfStarTrackingOption)
            self.updateTrackingValue(true)
        }
        let balanced = UIAlertAction(title: "Active", style: .default) { (alert) in
            Roam.startTracking(.active)
            SharedUtil.setDefaultString("Active", kSelfStarTrackingOption)

            self.updateTrackingValue(true)
        }
        let highPerformance = UIAlertAction(title: "Balanced", style: .default) { (alert) in
            Roam.startTracking(.balanced)
            SharedUtil.setDefaultString("Balanced", kSelfStarTrackingOption)
            self.updateTrackingValue(true)
        }
        let distance = UIAlertAction(title: "Custom Distance", style: .default) { (alert) in
         
            
            let trackingMethod = RoamTrackingCustomMethods()
            
            trackingMethod.allowBackgroundLocationUpdates = true //self.backLocationSegmentAction.selectedSegmentIndex == 1
            trackingMethod.pausesLocationUpdatesAutomatically = false//self.pauseSegmentAction.selectedSegmentIndex == 1
            trackingMethod.showsBackgroundLocationIndicator = true
            trackingMethod.desiredAccuracy = .kCLLocationAccuracyBestForNavigation//self.getDesiredAccuracy()
            trackingMethod.activityType = .fitness//self.getActivity()
            trackingMethod.useVisits = true
            trackingMethod.useSignificant = true
            trackingMethod.useStandardLocationServices = false
            trackingMethod.useRegionMonitoring  = true
            trackingMethod.distanceFilter = 100;

            // Enter update interval in seconds
            Roam.updateLocationWhenStationary(1800);
            SharedUtil.setDefaultString("Custom Distance", kSelfStarTrackingOption)

            Roam.startTracking(.custom, options: trackingMethod)
            self.updateTrackingValue(true)

        }
        let time = UIAlertAction(title: "Custom time", style: .default) { (alert) in
            // Define a custom tracking method
            let trackingMethod = RoamTrackingCustomMethods()
            
            trackingMethod.allowBackgroundLocationUpdates = true //self.backLocationSegmentAction.selectedSegmentIndex == 1
            trackingMethod.pausesLocationUpdatesAutomatically = false//self.pauseSegmentAction.selectedSegmentIndex == 1
            trackingMethod.showsBackgroundLocationIndicator = true
            trackingMethod.desiredAccuracy = .kCLLocationAccuracyBestForNavigation//self.getDesiredAccuracy()
            trackingMethod.activityType = .fitness//self.getActivity()
            trackingMethod.useVisits = true
            trackingMethod.useSignificant = true
            trackingMethod.useStandardLocationServices = false
            trackingMethod.useRegionMonitoring  = true
            trackingMethod.updateInterval = 5
            Roam.updateLocationWhenStationary(1800);
            SharedUtil.setDefaultString("Custom Time", kSelfStarTrackingOption)
            // Start the tracking with the above created custom tracking method
            Roam.startTracking(.custom, options: trackingMethod)
            self.updateTrackingValue(true)

        }
        
    

        
        let cance = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(powerSaver)
        alert.addAction(balanced)
        alert.addAction(highPerformance)
        alert.addAction(distance)
        alert.addAction(time)
        alert.addAction(cance)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func updateTrackingValue(_ value:Bool){
        SharedUtil.setDefaultBoolean(value, kSelfStarTracking)
        startTracking.isHidden = value
        stopracking.isHidden = !value
    }

}

