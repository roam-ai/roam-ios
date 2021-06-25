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
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    static public func viewController() -> DistanceViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let settingVC = storyBoard.instantiateViewController(withIdentifier: "DistanceViewController") as! DistanceViewController
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
        customOptions.useStandardLocationServices = true
        customOptions.allowBackgroundLocationUpdates = true
        customOptions.pausesLocationUpdatesAutomatically = false
        customOptions.activityType = .fitness
        customOptions.showsBackgroundLocationIndicator = true
        if switchAccuracyFilter.isOn {
            if self.accuraySegment.text != nil && self.accuraySegment.text!.count > 0 {
                customOptions.accuracyFilter = Int(self.accuraySegment.text!)
            }
        }
        if self.distanceSegment.text != nil && self.distanceSegment.text!.count > 0 {
            customOptions.distanceFilter = CLLocationDistance(self.distanceSegment.text!)
        }
        SharedUtil.setDefaultString("Distance base", kTrackingOp)
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

