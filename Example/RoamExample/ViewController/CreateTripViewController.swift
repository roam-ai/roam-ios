//
//  CreateTripViewController.swift
//  RoamExample
//
//  Created by GeoSpark on 23/08/21.
//

import UIKit
import Roam

class CreateTripViewController: UIViewController {

    @IBOutlet weak var isTripLocal: UISwitch!
    @IBOutlet weak var trackingModeSegment: UISegmentedControl!
    @IBOutlet weak var coordinateSegment: UISegmentedControl!

    @IBOutlet weak var timeIntervalTextfield: UITextField!
    @IBOutlet weak var distanceTextfield: UITextField!
    var trackigMode:RoamTrackingMode = .active
    var trackinhOption:RoamTrackingCustomMethods?
    var destination:[[Double]]?
    var origin:[[Double]]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    static public func viewController() -> CreateTripViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let logsDisplayVC = storyBoard.instantiateViewController(withIdentifier: "CreateTripViewController") as! CreateTripViewController
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
            trackinhOption = nil
            trackigMode = .active
        }else if selectedIndex == 1{
            self.isHidden(true)
            trackinhOption = nil
            trackigMode = .balanced
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
    
    @IBAction func coordinateAction(_ sender: Any) {
        let selectedIndex = coordinateSegment.selectedSegmentIndex
        if selectedIndex == 0{
            origin = []
            destination = []
        }else if selectedIndex == 1 {
            destination = [[77.677210,13.000048]]
            origin = [[77.635536,12.914478]]

        }else if selectedIndex == 2 {
            origin = [[77.635536,12.914478]]
            destination = []
        }else if selectedIndex == 3{
            destination = [[77.677210,13.000048]]
            origin = []
        }
    }
    
    func isHidden(_ value:Bool){
        self.distanceTextfield.isHidden = value
        self.timeIntervalTextfield.isHidden = value
    }
    
    @IBAction func createTripAction(_ sender: Any) {
        self.showHud()
        Roam.startTrip(nil, isTripLocal.isOn, trackigMode, "", origin, destination, trackinhOption) { roamTrip, error in
            
            if error?.message == nil {
                Alert.alertController(title: "Start Trip", message: roamTrip?.status, viewController: self)
            }else{
                Alert.alertController(title: "Start Trip", message: error?.message, viewController: self)
            }
            self.dismissHud()
        }
    }
    
    func customTracking(){
        trackinhOption = RoamTrackingCustomMethods()
        trackinhOption?.useStandardLocationServices = true
        trackinhOption?.allowBackgroundLocationUpdates = true
        trackinhOption?.pausesLocationUpdatesAutomatically = false
        trackinhOption?.desiredAccuracy = .kCLLocationAccuracyBest
        trackinhOption?.activityType = .fitness
        if ((distanceTextfield.text?.isEmpty) != nil){
            let distance =  Double(distanceTextfield.text!) ?? 0.0
            trackinhOption?.distanceFilter = distance
        }
        else{
            let time =  Int(timeIntervalTextfield.text!) ?? 0
            trackinhOption?.updateInterval = time
        }
        trackinhOption?.showsBackgroundLocationIndicator = true        
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
