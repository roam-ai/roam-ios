//
//  HomeViewController.swift
//  TestExample
//
//  Created by Roam Mac 15 on 08/06/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import UIKit
import Roam
import CoreLocation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var publishSegement: UISegmentedControl!
    @IBOutlet weak var accuracySegment: UISegmentedControl!

    @IBOutlet weak var publishLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var userDescTextField: UITextField!
    @IBOutlet weak var setUserDescBtn: UIButton!
    @IBOutlet weak var startTrackingBtn: UIButton!
    @IBOutlet weak var StopTrackingBtn: UIButton!
    @IBOutlet weak var requestLocationBtn: UIButton!
    @IBOutlet weak var getLocationBtn: UIButton!
    @IBOutlet weak var udpateLocationBtn: UIButton!
    @IBOutlet weak var trackedLocationBtn: UIButton!
    @IBOutlet weak var eventsBtn: UIButton!
    @IBOutlet weak var logoutsBtn: UIButton!
    @IBOutlet weak var logsBtn: UIButton!
    @IBOutlet weak var changeTrackingBtn: UIButton!
    @IBOutlet weak var trackingSettingBtn: UIButton!
    @IBOutlet weak var subScribeBtn: UIButton!
    @IBOutlet weak var trackingLabel: UILabel!
    @IBOutlet weak var otherLocationBtn: GradientButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if SharedUtil.getDefaultBoolean(kDisabledPublishingsave){
            self.publishSegement.selectedSegmentIndex = 1
            self.publishLabel.text = "Publish On"
        }

        if SharedUtil.getDefaultBoolean(kEnableAccuracyEngine){
            self.accuracySegment.selectedSegmentIndex = 1
            self.accuracyLabel.text = "Accuracy Engine On"
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.userIdTextField.text = SharedUtil.getDefaultString(kUserId)
        self.userDescTextField.text = SharedUtil.getDefaultString(kUserdescription)
        if SharedUtil.getDefaultString(kTrackingOp).isEmpty == false {
            trackingLabel.text = "Tracking " + SharedUtil.getDefaultString(kTrackingOp)
            self.enableButton()
            self.startTrackingBtn.isEnabled = false
            self.StopTrackingBtn.isEnabled = true
            self.changeTrackingBtn.isEnabled = true
        }
        else{
            resetDefault(true)
        }
    }

    func resetDefault(_ isValue:Bool){
        
        setUserDescBtn.isEnabled = isValue
        requestLocationBtn.isEnabled = isValue
        startTrackingBtn.isEnabled = isValue
        StopTrackingBtn.isEnabled = isValue
        StopTrackingBtn.isEnabled = isValue
        udpateLocationBtn.isEnabled = isValue
        getLocationBtn.isEnabled = isValue
        trackedLocationBtn.isEnabled = isValue
        logsBtn.isEnabled = isValue
        logoutsBtn.isEnabled = isValue
        eventsBtn.isEnabled = isValue
        
        if isValue{
            self.enableButton()
        }
    }
    
    func enableButton(){
        if Roam.isLocationEnabled(){
            requestLocationBtn.isEnabled = false
        }
   
        if Roam.isLocationTracking(){
            self.startTrackingBtn.isEnabled = false
            self.StopTrackingBtn.isEnabled = true
            self.changeTrackingBtn.isEnabled = true
            
        }else{
            self.startTrackingBtn.isEnabled = true
            self.StopTrackingBtn.isEnabled = false
            self.changeTrackingBtn.isEnabled = false

        }
    }
    
    @IBAction func setDescAction(_ sender: Any) {
        if userDescTextField.text!.isEmpty{
            Alert.alertController(title: "User", message: "User description cannot be empty", viewController: self)
        }else{
            Roam.setDescription(userDescTextField.text!)
        }
    }
    
    @IBAction func requestLocationAction(_ sender: Any) {
        if Roam.isLocationEnabled() == false && CLLocationManager.locationServicesEnabled(){
            Roam.requestLocation()
            requestLocationBtn.isEnabled = false
        }else{
            Alert.alertController(title: "Check ", message: "location is not enable", viewController: self)
        }
        
    }
    
    @IBAction func startTrackingAction(_ sender: Any) {
        if Roam.isLocationEnabled(){
            showDropDown()
        }else{
            requestLocationBtn.isEnabled = true
            Alert.alertController(title: "Start Tracking", message: "Enable location permission before start tracking ", viewController: self)
        }
        
        enableButton()
    }
    
    @IBAction func stopTrackingAction(_ sender: Any) {
        Roam.stopTracking()
        enableButton()
        SharedUtil.setDefaultString("", kTrackingOp)
        trackingLabel.text = "Tracking"
    }
    
    @IBAction func updateLocationAction(_ sender: Any) {
        Roam.updateCurrentLocation(100)
    }
    
    @IBAction func getCurrentLocationAction(_ sender: Any) {
        showHud()
        Roam.getCurrentLocation(100) { (location, errorStatus) in
            Alert.alertController(title: "Get Current Location", message: location?.description, viewController: self)
            self.dismissHud()
        }
    }
    
    @IBAction func trackedLocationAction(_ sender: Any) {
        let vc = MapViewController.viewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func eventsAction(_ sender: Any) {
        let vc = EventsViewController.viewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        showHud()
        Roam.logoutUser { (status,erroe) in
            self.dismissHud()
            if status == "Success."{
                AppUtility.resetDefaults()
                DispatchQueue.main.async {
                    Roam.setLoggerEnabled(logger: true)
                    Roam.initialize(KPublishableKey)
                    let story = UIStoryboard(name: "Main", bundle:nil)
                    let vc = story.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    let nav = UINavigationController(rootViewController: vc)
                    UIApplication.shared.windows.first?.rootViewController = nav
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
                
            }else{
                Alert.alertController(title: "Logout ", message: status, viewController: self)
            }
        }
    }
    
    
    @IBAction func tripsAction(_ sender: Any) {
        let vc = TripViewController.viewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showDropDown(){
        let alert = UIAlertController(title: "Choose Tracking options", message: nil  , preferredStyle: .actionSheet)
        
        let defaul = UIAlertAction(title: "Custom", style: .default) { (alert) in
            let vc = SettingsViewController.viewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let powerSaver = UIAlertAction(title: "Passive", style: .default) { (alert) in
            
            Roam.startTracking(.passive)
            self.saveTracking("Passive")
            self.startTrackingBtn.isEnabled = false
            self.StopTrackingBtn.isEnabled = true
            self.changeTrackingBtn.isEnabled = true
        }
        let balanced = UIAlertAction(title: "Active", style: .default) { (alert) in
            self.saveTracking("Active")
            Roam.startTracking(.active)
            self.startTrackingBtn.isEnabled = false
            self.StopTrackingBtn.isEnabled = true
            self.changeTrackingBtn.isEnabled = true
        }
        let highPerformance = UIAlertAction(title: "Balanced", style: .default) { (alert) in
            Roam.startTracking(.balanced)
            self.saveTracking("Balanced")
            self.startTrackingBtn.isEnabled = false
            self.StopTrackingBtn.isEnabled = true
            self.changeTrackingBtn.isEnabled = true
        }
    
        let timeBase = UIAlertAction(title: "Time Base", style: .default) { (alert) in
            let vc = TimeBasedViewController.viewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let distanceBase = UIAlertAction(title: "Distance Base", style: .default) { (alert) in
            let vc = DistanceViewController.viewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let cance = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(powerSaver)
        alert.addAction(balanced)
        alert.addAction(highPerformance)
        alert.addAction(timeBase)
        alert.addAction(distanceBase)
        alert.addAction(defaul)
        alert.addAction(cance)

        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func saveTracking(_ str:String){
        SharedUtil.setDefaultString(str, kTrackingOp)
        trackingLabel.text = "Tracking " + str
    }
    
    @IBAction func changeTrackingAction(_ sender: Any) {
        showDropDown()
    }

    @IBAction func subscrAction(_ sender: Any) {
        let vc = SubScribeViewController.viewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickOtherLocationBtn(_ sender: Any) {
        let vc = OtherLocationViewController.viewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func tripDetailsAction(_ sender: Any) {
        let vc = TripDetailsViewController.viewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func trackingSettingAction(_ sender: Any) {
        let vc = TrackingSettingViewController.viewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func publicSegmentAction(_ sender: Any) {
        if publishSegement.selectedSegmentIndex == 0{
            Roam.stopPublishing()
            self.publishLabel.text = "Publish Off"
            SharedUtil.setDefaultBoolean(false, kDisabledPublishingsave)
        }else if publishSegement.selectedSegmentIndex == 1{
            self.publishLabel.text = "Publish On"
            Roam.publishSave()
            SharedUtil.setDefaultBoolean(true, kDisabledPublishingsave)
        }
    }

    @IBAction func accuracySegmentAction(_ sender: Any) {
        if accuracySegment.selectedSegmentIndex == 0{
            UserDefaults.standard.set(false, forKey: kEnableAccuracyEngine)
            self.accuracyLabel.text = "Accuracy Engine Off"
            Roam.disableAccuracyEngine()
        }else if accuracySegment.selectedSegmentIndex == 1{
            UserDefaults.standard.set(true, forKey: kEnableAccuracyEngine)
            self.accuracyLabel.text = "Accuracy Engine On"
            Roam.enableAccuracyEngine()
        }
    }
}
