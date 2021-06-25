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
            let option = RoamTrackingCustomMethods()
            option.pausesLocationUpdatesAutomatically = false
            option.allowBackgroundLocationUpdates = true
            
            if self.timeTextField.text != nil && self.timeTextField.text!.count > 0 {
                    option.updateInterval = Int(self.timeTextField.text!)
            }
            if switchAccuracyFilter.isOn {
                if self.accurayTextfield.text != nil && self.accurayTextfield.text!.count > 0 {
                    option.accuracyFilter = Int(self.accurayTextfield.text!)
                }
            }else{
                option.accuracyFilter = 50
            }
            SharedUtil.setDefaultString("Time base", kTrackingOp)
            Roam.startTracking(.custom, options: option)
        }else{
            Alert.alertController(title: "Error", message: "Enter time in seconds", viewController: self)
        }
 
    }
    
    static public func viewController() -> TimeBasedViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let settingVC = storyBoard.instantiateViewController(withIdentifier: "TimeBasedViewController") as! TimeBasedViewController
        return settingVC
    }

}
