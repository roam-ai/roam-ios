//
//  TrackingViewController.swift
//  TestExample
//
//  Created by Roam Mac 15 on 14/10/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import UIKit
import Roam

class TrackingSettingViewController: UIViewController {
    
    @IBOutlet weak var alwaysSegment: UISegmentedControl!
    @IBOutlet weak var locationTrackerSegment: UISegmentedControl!
    @IBOutlet weak var offlineSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alwaysSegment.selectedSegmentIndex = SharedUtil.getDefaultInteger(kValeUserAppState)
        self.offlineSegment.selectedSegmentIndex = SharedUtil.getDefaultInteger(kValueOfflineLocation)
        self.locationTrackerSegment.selectedSegmentIndex = SharedUtil.getDefaultInteger(kLocationTracker)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    static public func viewController() -> TrackingSettingViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let logsDisplayVC = storyBoard.instantiateViewController(withIdentifier: "TrackingSettingViewController") as! TrackingSettingViewController
        return logsDisplayVC
    }
    
    @IBAction func locationAction(_ sender: Any) {
//        let selected = locationTrackerSegment.selectedSegmentIndex
//        SharedUtil.setDefaultInteger(selected, kLocationTracker)
//        if selected == 0{
//            Roam.locationPublisher(true)
//        }else{
//            Roam.locationPublisher(false)
//        }
    }
    
    @IBAction func OfflineAction(_ sender: Any) {
        let selected = offlineSegment.selectedSegmentIndex
        SharedUtil.setDefaultInteger(selected, kValueOfflineLocation)
        if selected == 0 {
            Roam.offlineLocationTracking(true)
        }else if selected == 1 {
            Roam.offlineLocationTracking(false)
        }
        
    }
    
    @IBAction func alwaysAction(_ sender: Any) {
        let selected = alwaysSegment.selectedSegmentIndex
        SharedUtil.setDefaultInteger(selected, kValeUserAppState)
        if selected == 0 {
            Roam.setTrackingInAppState(.AlwaysOn)
        }else if selected == 1 {
            Roam.setTrackingInAppState(.Foreground)
        }else if selected == 2{
            Roam.setTrackingInAppState(.Background)
        }
    }
    
}
