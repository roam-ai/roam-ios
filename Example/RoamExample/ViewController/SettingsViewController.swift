//
//  SettingsViewController.swift
//  TestExample
//
//  Created by Roam Device on 21/07/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import Roam
enum UserDefaultKeys : String {
    case useStandardLocationService = "useStandardLocationServices"
    case geofenceRadius = "geofenceRadius"
    case useSignificantLocationChanges = "useSignificantLocationChanges"
    case desiredAccuracy = "desiredAccuracy"
    case useVisits = "useVisits"
    case showBlueBar = "showBlueBar"
    case distanceFilter = "distanceFilter"
    case regionMonitoring = "regionMonitoring"
    case backgroundLocationUpdate = "backgroundLocationUpdate"
    case pauseLocationUpdate = "pauseLocationUpdate"
    case activityType = "activityType"
    case accuracyFilter = "accuracyFilter"
    case updateInterval = "updateInterval"
}

class SettingsViewController: UIViewController {
    
    var customOptions  = RoamTrackingCustomMethods()
    
    
    @IBOutlet weak var distanceFilterSegment: UISegmentedControl!
    @IBOutlet weak var blueBarSegment: UISegmentedControl!
    @IBOutlet weak var visitsSegment: UISegmentedControl!
    @IBOutlet weak var desiredAccuracySegment: UISegmentedControl!
    @IBOutlet weak var significantSegment: UISegmentedControl!
    @IBOutlet weak var regionMonitoringSegment: UISegmentedControl!
    @IBOutlet weak var backGroundLocationUpdateSegment: UISegmentedControl!
    @IBOutlet weak var pauseLocationUpdateSegment: UISegmentedControl!
    @IBOutlet weak var activityTypeSegment: UISegmentedControl!
    @IBOutlet weak var customGeofenceRadius: UISegmentedControl!
    @IBOutlet weak var useStandardLocation: UISegmentedControl!
    
    @IBOutlet weak var useAccuracyFilter: UISegmentedControl!
    @IBOutlet weak var switchAccuracyFilter: UISwitch!

    @IBOutlet weak var txtFieldTimeBased: UITextField!
    @IBOutlet weak var distanceBaseTextField: UITextField!
    
    @IBAction func clickUseStandardLocationService(_ sender: Any) {
        UserDefaults.standard.set(self.useStandardLocation.selectedSegmentIndex == 0 ? false : true, forKey: UserDefaultKeys.useStandardLocationService.rawValue)
        updateSettings()
    }
    @IBAction func customGeofenceRadiusClick(_ sender: Any) {
        UserDefaults.standard.set(self.customGeofenceRadius.selectedSegmentIndex, forKey: UserDefaultKeys.geofenceRadius.rawValue)
        updateSettings()
    }
    @IBAction func significantSegmentClick(_ sender: Any) {
        UserDefaults.standard.set(self.significantSegment.selectedSegmentIndex == 0 ? false : true, forKey: UserDefaultKeys.useSignificantLocationChanges.rawValue)
        updateSettings()
    }
    @IBAction func desiredAccuracySegmentClick(_ sender: Any) {
        UserDefaults.standard.set(self.desiredAccuracySegment.selectedSegmentIndex, forKey: UserDefaultKeys.desiredAccuracy.rawValue)
        updateSettings()
    }
    @IBAction func visitsSegmentClick(_ sender: Any) {
        UserDefaults.standard.set(self.visitsSegment.selectedSegmentIndex == 0 ? false : true, forKey: UserDefaultKeys.useVisits.rawValue)
        updateSettings()
    }
    @IBAction func blueBarSegmentClick(_ sender: Any) {
        UserDefaults.standard.set(self.blueBarSegment.selectedSegmentIndex == 0 ? false : true, forKey: UserDefaultKeys.showBlueBar.rawValue)
        updateSettings()
    }
    @IBAction func distanceFilterSegmentClick(_ sender: Any) {
        UserDefaults.standard.set(self.distanceFilterSegment.selectedSegmentIndex, forKey: UserDefaultKeys.distanceFilter.rawValue)
        updateSettings()
    }
    
    @IBAction func regionMonitoringSegmentClick(_ sender: Any) {
        UserDefaults.standard.set(self.regionMonitoringSegment.selectedSegmentIndex, forKey: UserDefaultKeys.regionMonitoring.rawValue)
        updateSettings()
    }
    @IBAction func backGroundlocationUpdates(_ sender: Any) {
        UserDefaults.standard.set(self.backGroundLocationUpdateSegment.selectedSegmentIndex, forKey: UserDefaultKeys.backgroundLocationUpdate.rawValue)
        updateSettings()
    }
    @IBAction func pauseLocationUpdatesSegmentClick(_ sender: Any) {
        UserDefaults.standard.set(self.pauseLocationUpdateSegment.selectedSegmentIndex, forKey: UserDefaultKeys.pauseLocationUpdate.rawValue)
        updateSettings()
    }
    @IBAction func activityTypeSegmentClick(_ sender: Any) {
        UserDefaults.standard.set(self.activityTypeSegment.selectedSegmentIndex, forKey: UserDefaultKeys.activityType.rawValue)
        updateSettings()
    }
    func getDistanceFilter(selectedIndex:Int)-> Double {
        
        if selectedIndex == 0 {
            return 10.0
        }
        if selectedIndex == 1 {
            return 100.0
        }
        if selectedIndex == 2 {
            return 500.0
        }
        if selectedIndex == 3 {
            return 1000.0
        }
        if selectedIndex == 4 {
            return 5000.0
        }
        return 0.0
    }
    
    func getDesiredAccuracy(selectedIndex:Int)-> LocationAccuracy{
        
        if selectedIndex == 0 {
            return .kCLLocationAccuracyBestForNavigation
        }
        if selectedIndex == 1 {
            return .kCLLocationAccuracyBest
        }
        if selectedIndex == 2 {
            return .kCLLocationAccuracyNearestTenMeters
        }
        if selectedIndex == 3 {
            return .kCLLocationAccuracyHundredMeters
        }
        if selectedIndex == 4 {
            return .kCLLocationAccuracyKilometer
        }
        if selectedIndex == 5 {
            return .kCLLocationAccuracyThreeKilometers
        }
        return .kCLLocationAccuracyBestForNavigation
    }
    
    func getActivity(selectedIndex:Int)-> CLActivityType {
        
        if selectedIndex == 0 {
            return .automotiveNavigation
        }
        if selectedIndex == 1 {
            return .fitness
        }
        if selectedIndex == 2 {
            return .otherNavigation
        }
        if selectedIndex == 3 {
            return .airborne
        }
        if selectedIndex == 4 {
            return .other
        }
        return .automotiveNavigation
    }
    
    func getGeofenceRadius(selectedIndex:Int)-> Int {
        
        if selectedIndex == 0 {
            return 100
        }
        if selectedIndex == 1 {
            return 200
        }
        if selectedIndex == 2 {
            return 300
        }
        if selectedIndex == 3 {
            return 500
        }
        return 0
    }
    
    
    func updateSettings() {
        self.customOptions.useStandardLocationServices = UserDefaults.standard.bool(forKey: UserDefaultKeys.useStandardLocationService.rawValue)
        self.customOptions.geofenceRadius = self.getGeofenceRadius(selectedIndex: UserDefaults.standard.integer(forKey: UserDefaultKeys.geofenceRadius.rawValue))
        self.customOptions.useVisits = UserDefaults.standard.bool(forKey: UserDefaultKeys.useVisits.rawValue)
        self.customOptions.useSignificant = UserDefaults.standard.bool(forKey: UserDefaultKeys.useSignificantLocationChanges.rawValue)
        self.customOptions.showsBackgroundLocationIndicator = UserDefaults.standard.bool(forKey: UserDefaultKeys.showBlueBar.rawValue)
        self.customOptions.distanceFilter = self.getDistanceFilter(selectedIndex: UserDefaults.standard.integer(forKey: UserDefaultKeys.distanceFilter.rawValue));
        self.customOptions.desiredAccuracy = self.getDesiredAccuracy(selectedIndex: UserDefaults.standard.integer(forKey: UserDefaultKeys.desiredAccuracy.rawValue))
        self.customOptions.useRegionMonitoring = UserDefaults.standard.bool(forKey: UserDefaultKeys.regionMonitoring.rawValue)
        self.customOptions.allowBackgroundLocationUpdates = UserDefaults.standard.bool(forKey: UserDefaultKeys.backgroundLocationUpdate.rawValue)
        self.customOptions.pausesLocationUpdatesAutomatically = UserDefaults.standard.bool(forKey: UserDefaultKeys.pauseLocationUpdate.rawValue)
        self.customOptions.activityType = self.getActivity(selectedIndex: UserDefaults.standard.integer(forKey: UserDefaultKeys.activityType.rawValue));
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtFieldTimeBased.delegate = self
        self.customGeofenceRadius.selectedSegmentIndex = UserDefaults.standard.integer(forKey: UserDefaultKeys.geofenceRadius.rawValue)
        
        self.useStandardLocation.selectedSegmentIndex = UserDefaults.standard.bool(forKey: UserDefaultKeys.useStandardLocationService.rawValue) == true ? 1 : 0
        
        self.significantSegment.selectedSegmentIndex = UserDefaults.standard.bool(forKey: UserDefaultKeys.useSignificantLocationChanges.rawValue) == true ? 1 : 0
        
        self.visitsSegment.selectedSegmentIndex = UserDefaults.standard.bool(forKey: UserDefaultKeys.useVisits.rawValue) == true ? 1 : 0
        
        self.desiredAccuracySegment.selectedSegmentIndex = UserDefaults.standard.integer(forKey: UserDefaultKeys.desiredAccuracy.rawValue)
        
        self.distanceFilterSegment.selectedSegmentIndex = UserDefaults.standard.integer(forKey: UserDefaultKeys.distanceFilter.rawValue)
        
        self.blueBarSegment.selectedSegmentIndex = UserDefaults.standard.bool(forKey: UserDefaultKeys.showBlueBar.rawValue) == true ? 1 : 0
        
        self.activityTypeSegment.selectedSegmentIndex = UserDefaults.standard.integer(forKey: UserDefaultKeys.activityType.rawValue)
        
        self.regionMonitoringSegment.selectedSegmentIndex = UserDefaults.standard.bool(forKey: UserDefaultKeys.regionMonitoring.rawValue) == true ? 1 : 0
        
        self.backGroundLocationUpdateSegment.selectedSegmentIndex = UserDefaults.standard.bool(forKey: UserDefaultKeys.backgroundLocationUpdate.rawValue) == true ? 1 : 0
        
        self.pauseLocationUpdateSegment.selectedSegmentIndex = UserDefaults.standard.bool(forKey: UserDefaultKeys.pauseLocationUpdate.rawValue) == true ? 1 : 0
        
        if (UserDefaults.standard.integer(forKey: UserDefaultKeys.accuracyFilter.rawValue) != 0) {
            switchAccuracyFilter.setOn(true, animated: true)
        }
        else{
            switchAccuracyFilter.setOn(false, animated: true)
        }
        
        self.getAccuracyFilter(selectedIndex: UserDefaults.standard.integer(forKey: UserDefaultKeys.accuracyFilter.rawValue))
        
        if (UserDefaults.standard.integer(forKey: UserDefaultKeys.updateInterval.rawValue)) > 0 {
            self.txtFieldTimeBased.text = "\(UserDefaults.standard.integer(forKey: UserDefaultKeys.updateInterval.rawValue))"
        }
        // Do any additional setup after loading the view.
    }
    static public func viewController() -> SettingsViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let settingVC = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        return settingVC
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.addStartButtonOnRight()
        
    }
    
    
    func addStartButtonOnRight(){
        let button = UIButton(type: .custom)
        button.setTitle("Start Tracking", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        button.layer.cornerRadius = 5
        button.backgroundColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 25)
        button.addTarget(self, action: #selector(gotSettingPage), for: UIControl.Event.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func gotSettingPage(){
        SharedUtil.setDefaultString("Custom", kTrackingOp)
        let customOptions  = RoamTrackingCustomMethods()
        customOptions.allowBackgroundLocationUpdates = true
        customOptions.pausesLocationUpdatesAutomatically = false
        customOptions.showsBackgroundLocationIndicator = true
        customOptions.desiredAccuracy = .kCLLocationAccuracyBestForNavigation
        customOptions.activityType = .fitness
        customOptions.useVisits = true
        customOptions.useSignificant = true
        customOptions.useStandardLocationServices = false
        customOptions.useRegionMonitoring  = true
        customOptions.useDynamicGeofencRadius = true
        
        
        if self.txtFieldTimeBased.text != nil && self.txtFieldTimeBased.text!.count > 0 {
            customOptions.updateInterval = Int(self.txtFieldTimeBased.text!)
            UserDefaults.standard.set(self.txtFieldTimeBased.text!, forKey: UserDefaultKeys.updateInterval.rawValue)
        }
        
        if self.distanceBaseTextField.text != nil && self.distanceBaseTextField.text!.count > 0 {
            let time =  Double(distanceBaseTextField.text!) ?? 0.0
            customOptions.distanceFilter = time
        }
        
        Roam.startTracking(.custom, options: customOptions)
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func accuracyFilterClick(_ sender: Any) {
        UserDefaults.standard.set(self.useAccuracyFilter.titleForSegment(at: useAccuracyFilter.selectedSegmentIndex), forKey: UserDefaultKeys.accuracyFilter.rawValue)
        updateSettings()
    }
    
    func getAccuracyFilter(selectedIndex:Int){
        
        if selectedIndex == 20 {
            self.useAccuracyFilter.selectedSegmentIndex = 0
        }
        if selectedIndex == 30 {
            self.useAccuracyFilter.selectedSegmentIndex = 1
        }
        if selectedIndex == 40 {
            self.useAccuracyFilter.selectedSegmentIndex = 2
        }
        if selectedIndex == 50 {
            self.useAccuracyFilter.selectedSegmentIndex = 3
        }
        if selectedIndex == 60 {
            self.useAccuracyFilter.selectedSegmentIndex = 4
        }
        if selectedIndex == 100 {
            self.useAccuracyFilter.selectedSegmentIndex = 5
        }
    }
    
    
    @IBAction func clickAccuracyOnOff(_ sender: Any) {
        if switchAccuracyFilter.isOn{
            useAccuracyFilter.isUserInteractionEnabled =  true
        }
        else{
            useAccuracyFilter.isUserInteractionEnabled = false
            UserDefaults.standard.removeObject(forKey: UserDefaultKeys.accuracyFilter.rawValue)
        }
    }
}
