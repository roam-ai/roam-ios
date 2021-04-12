//
//  TripDetailsViewController.swift
//  TestExample
//
//  Created by Roam Mac 15 on 18/08/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import UIKit
import Roam

class TripDetailsViewController: UIViewController {
    
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var responseString: UILabel!
    @IBOutlet var tripStatus: UISegmentedControl!
    var tripStatuVale:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
    
    static public func viewController() -> TripDetailsViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let logsDisplayVC = storyBoard.instantiateViewController(withIdentifier: "TripDetailsViewController") as! TripDetailsViewController
        return logsDisplayVC
    }
    
    @IBAction func getTrip(_ sender: Any) {
        openAlert1()
    }
    
    @IBAction func createTrip(_ sender: Any) {
        
        self.showHud()
        if segmentControl.selectedSegmentIndex  == 3{
            Roam.createTrip(self.selectSegment()) {
                (response,error) in
                self.dismissHud()
                if response!.userId  != nil{
                    let create = "Create trip  " + "   createdAt \(String(describing: response!.createdAt))"  + "   isDeleted \(response!.isDeleted)" + "   isStarted \(response!.isStarted)" + "   isEnded \(response!.isEnded)" + "   tripId \(String(describing: response!.tripId)) " + "   tripTrackingUrl \(String(describing: response!.tripTrackingUrl))" + "   updatedAt \(String(describing: response!.updatedAt))" + "   origins \(response!.origins.count)" + " destinations \(response!.destinations.count)"
                    self.alert("Create Trip", create)
                }else{
                    self.dismissHud()
                    self.alert("Create Trip", (error?.message)!)
                }
            }
        }else{
            var dict:Dictionary<String,Any> = [:]
            //origin[77.635536,12.914478] destination [[77.677210,13.000048],[77.708614,13.192067]]
            let index = segmentControl.selectedSegmentIndex
            if index == 0 {
                dict = ["destinations":[[77.677210,13.000048]],"origins":[[77.635536,12.914478]]]
            }else if index == 1{
                dict = ["origins":[[77.635536,12.914478]]]
            }else if index == 2{
                dict = ["destinations":[[77.677210,13.000048]]]
            }
            Roam.createTrip(self.selectSegment(),dict) { (response,error) in
                self.dismissHud()
                if response!.userId  != nil{
                    let create = "Create trip  " + "   createdAt \(String(describing: response!.createdAt))"  + "   isDeleted \(response!.isDeleted)" + "   isStarted \(response!.isStarted)" + "   isEnded \(response!.isEnded)" + "   tripId \(String(describing: response!.tripId)) " + "   tripTrackingUrl \(String(describing: response!.tripTrackingUrl))" + "   updatedAt \(String(describing: response!.updatedAt))" + "   origins \(response!.origins.count)" + " destinations \(response!.destinations.count)"
                    self.alert("Create Trip", create)
                }else{
                    self.dismissHud()
                    self.alert("Create Trip", (error?.message)!)
                }
            }
        }
        
        
    }
    
    @IBAction func tripSummary(_ sender: Any) {
        openAlert()
        
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        self.responseString.text = ""
    }
    
    @IBAction func tripSummaryListner(_ sender: Any) {
        openAlert2()
    }
    
    func alert(_ title:String,_ message:String){
        DispatchQueue.main.async {
            self.responseString.text = message
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func openAlert(){
        let alertController = UIAlertController(title: "Get Trip Summary", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter trip"
        }
        
        let saveAction = UIAlertAction(title: "Get", style: .default, handler: { alert -> Void in
            if let textField = alertController.textFields?[0] {
                if textField.text!.count > 0 {
                    self.showHud()
                    Roam.getTripSummary(textField.text!) { (response, error) in
                        if response?.userId  != nil {
                            DispatchQueue.main.async {
                                self.dismissHud()
                            let vc = TripSummaryViewController.viewController()
                            vc.summary = response
                            self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }else{
                            self.dismissHud()
                            self.alert("Trip Summary", "\(String(describing: error?.code))\(String(describing: error?.message))")
                        }
                    }
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style:.cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        alertController.preferredAction = saveAction
        self.present(alertController, animated: true, completion: nil)
    }
    
    func openAlert1(){
        let alertController = UIAlertController(title: "Get Trip details", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter trip id"
        }
        
        let saveAction = UIAlertAction(title: "Get", style: .default, handler: { alert -> Void in
            if let textField = alertController.textFields?[0] {
                if textField.text!.count > 0 {
                    self.showHud()
                    Roam.getTripDetails(textField.text!) { (trip, error) in
                        self.dismissHud()
                        if trip?.tripId != nil{
                            let str =  " Get Trip details : Trip Id   \((trip!.tripId)!)" + " \n created :\((trip!.createdAt)!) " + " \n destination: \(String(describing: trip!.destinations.count))" + " \n  Distance covered:  \(String(describing: trip!.distanceCovered))" + "  \n Duration:\(String(describing: trip!.duration))" + "  \n  events:\(trip!.events.count)" + " \n  origins: \(String(describing: trip!.origins.count))" + " \n Started & ended & updated \((trip!.tripStartedAt)!)\((trip!.updatedAt)!)"
                            self.alert("Trip Summary", str)
                        }else{
                            self.dismissHud()
                            self.alert("Get Trip Detail", "\(String(describing: error?.code))\(String(describing: error?.message))")
                        }
                    }
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style:.cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        alertController.preferredAction = saveAction
        self.present(alertController, animated: true, completion: nil)
    }
    
    func openAlert2(){
        let alertController = UIAlertController(title: "Get Trip Status", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter trip id"
        }
        
        let saveAction = UIAlertAction(title: "Get", style: .default, handler: { alert -> Void in
            if let textField = alertController.textFields?[0] {
                if textField.text!.count > 0 {
                    Roam.getTripStatus(textField.text!) { (trip, error) in
                        if error == nil{
                            let str = "Get Trip Status  \n Duration  " + String(trip!.duration) + "\n   Distance  " + String(trip!.distance)
                            self.alert("Get Trip Status", str)
                        }else{
                            self.alert((error?.code)!, (error?.message)!)
                        }
                    }
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style:.cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        alertController.preferredAction = saveAction
        self.present(alertController, animated: true, completion: nil)
    }
    
    func selectSegment() -> Bool{
        if tripStatuVale == 0{
            return false

        }else{
            return true
        }
    }
    
    @IBAction func segmentTripAction(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            tripStatuVale = 0
        }else{
            tripStatuVale = 1
        }
    }
}
