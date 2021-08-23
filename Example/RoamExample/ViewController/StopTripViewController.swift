//
//  StopTripViewController.swift
//  RoamExample
//
//  Created by GeoSpark on 23/08/21.
//

import UIKit
import Roam
class StopTripViewController: UIViewController {
    
    @IBOutlet weak var forceStop: UISwitch!
    @IBOutlet weak var tripIdTextfield: UITextField!
    @IBOutlet weak var TimeTextfield: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    var trackigMode:RoamTrackingMode = .active
    var trip:RoamTrip?
    var trackinhOption:RoamTrackingCustomMethods?
    
    @IBOutlet weak var trackingModeSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tripIdTextfield.text = trip?.tripId
        // Do any additional setup after loading the view.
    }
    
    static public func viewController() -> StopTripViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let logsDisplayVC = storyBoard.instantiateViewController(withIdentifier: "StopTripViewController") as! StopTripViewController
        return logsDisplayVC
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
    
    @IBAction func trackingModeAction(_ sender: Any) {
        let selectedIndex = trackingModeSegment.selectedSegmentIndex
        if selectedIndex == 0{
            self.isHidden(true)
            trackigMode = .active
            trackinhOption = nil
        }else if selectedIndex == 1{
            self.isHidden(true)
            trackigMode = .balanced
            trackinhOption = nil
        }else if selectedIndex == 2{
            self.isHidden(false)
            trackigMode = .custom
            self.customTracking()
        }else if selectedIndex == 3{
            self.isHidden(true)
            trackigMode = .passive
            trackinhOption = nil
        }
        
    }
    @IBAction func stopTrip(_ sender: Any) {
        self.showHud()
        Roam.stopTrip((trip?.tripId)!, forceStopTracking: forceStop.isOn, trackigMode, trackinhOption) { status, error in
            if error == nil{
                Alert.alertController(title: "Stop Trip", message: status, viewController: self)
            }else{
                Alert.alertController(title: "Stop Trip", message: error?.code, viewController: self)
            }
            self.dismissHud()
        }
    }
    
    
    func isHidden(_ value:Bool){
        self.distanceTextField.isHidden = value
        self.TimeTextfield.isHidden = value
    }
    
    func customTracking(){
        trackinhOption = RoamTrackingCustomMethods()
        trackinhOption?.useStandardLocationServices = true
        trackinhOption?.allowBackgroundLocationUpdates = true
        trackinhOption?.pausesLocationUpdatesAutomatically = false
        trackinhOption?.desiredAccuracy = .kCLLocationAccuracyBest
        trackinhOption?.activityType = .fitness
        if ((distanceTextField.text?.isEmpty) != nil){
            let distance =  Double(distanceTextField.text!) ?? 0.0
            trackinhOption?.distanceFilter = distance
        }
        else{
            let time =  Int(TimeTextfield.text!) ?? 0
            trackinhOption?.updateInterval = time
        }
        trackinhOption?.showsBackgroundLocationIndicator = true
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
