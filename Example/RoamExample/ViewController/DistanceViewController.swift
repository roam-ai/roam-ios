//
//  DistanceViewController.swift
//  RoamExample
//
//  Created by GeoSpark on 25/06/21.
//

import UIKit
import Roam
import CoreLocation

class DistanceViewController: UIViewController{
    
    @IBOutlet weak var distanceSegment: UITextField!
    @IBOutlet weak var accuraySegment: UITextField!
    @IBOutlet weak var switchAccuracyFilter: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    static public func viewController() -> DistanceViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let settingVC = storyBoard.instantiateViewController(withIdentifier: "DistanceViewController") as! DistanceViewController
        return settingVC
    }
    

    @IBAction func startTracking(_ sender: Any) {
        SharedUtil.setDefaultString("Custom", kTrackingOp)
        let customOptions = RoamTrackingCustomMethods()
        customOptions.allowBackgroundLocationUpdates = true
        customOptions.pausesLocationUpdatesAutomatically = false
        customOptions.showsBackgroundLocationIndicator = true
        customOptions.desiredAccuracy = .kCLLocationAccuracyBestForNavigation//self.getDesiredAccuracy()
        customOptions.activityType = .fitness//self.getActivity()
        customOptions.useVisits = true
        customOptions.useSignificant = true
        customOptions.useStandardLocationServices = false
        customOptions.useRegionMonitoring  = true
        customOptions.useDynamicGeofencRadius = true
        if self.distanceSegment.text != nil && self.distanceSegment.text!.count > 0 {
            customOptions.distanceFilter = CLLocationDistance(self.distanceSegment.text!)
        }
        SharedUtil.setDefaultString("Distance base", kTrackingOp)
        if switchAccuracyFilter.isOn {
            if self.accuraySegment.text != nil && self.accuraySegment.text!.count > 0 {
                customOptions.accuracyFilter = Int(self.accuraySegment.text!)
            }
        }
        Roam.startTracking(.custom, options: customOptions)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case distanceSegment:
            distanceSegment.resignFirstResponder()
        case accuraySegment:
            accuraySegment.resignFirstResponder()
            
        default:
            break
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
}

