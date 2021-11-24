//
//  TimeBasedViewController.swift
//  RoamExample
//
//  Created by GeoSpark on 25/06/21.
//

import UIKit
import Roam

class TimeBasedViewController: UIViewController {
    
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var accurayTextfield: UITextField!
    @IBOutlet weak var switchAccuracyFilter: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func startTracking(_ sender: Any) {
        
        if self.timeTextField.text != nil && self.timeTextField.text!.count > 0 {
            
            
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
            
            if self.timeTextField.text != nil && self.timeTextField.text!.count > 0 {
                customOptions.updateInterval = Int(self.timeTextField.text!)
            }
            if switchAccuracyFilter.isOn {
                if self.accurayTextfield.text != nil && self.accurayTextfield.text!.count > 0 {
                    customOptions.accuracyFilter = Int(self.accurayTextfield.text!)
                }
            }else{
                customOptions.accuracyFilter = 50
            }
            SharedUtil.setDefaultString("Time base", kTrackingOp)
            Roam.startTracking(.custom, options: customOptions)
        }else{
            Alert.alertController(title: "Error", message: "Enter time in seconds", viewController: self)
        }
        self.navigationController?.popViewController(animated: true)        
    }
    
    static public func viewController() -> TimeBasedViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let settingVC = storyBoard.instantiateViewController(withIdentifier: "TimeBasedViewController") as! TimeBasedViewController
        return settingVC
    }
    
}
