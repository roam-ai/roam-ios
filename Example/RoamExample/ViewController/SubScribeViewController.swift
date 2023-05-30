//
//  SubScribeViewController.swift
//  TestExample
//
//  Created by Roam Mac 15 on 22/07/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import UIKit
import Roam

class SubScribeViewController: UIViewController {
    
    @IBOutlet weak var event: UISwitch!
    @IBOutlet weak var location: UISwitch!
    @IBOutlet weak var otherLocation: UISwitch!
    @IBOutlet weak var userId: UITextField!
    @IBOutlet var tripListener: UISwitch!
    @IBOutlet var tripListenerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if SharedUtil.getDefaultBoolean(kOtherLocationSub){
            otherLocation.isOn = true
        }
        if SharedUtil.getDefaultBoolean(kLocationSub){
            location.isOn = true
        }
        if SharedUtil.getDefaultBoolean(kEventSub){
            event.isOn = true
        }
        if SharedUtil.getDefaultString(kTripStatusListener).isEmpty == false{
            tripListener.isOn = true
            self.updateLabel(SharedUtil.getDefaultString(kTripStatusListener))
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    static public func viewController() -> SubScribeViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let logsDisplayVC = storyBoard.instantiateViewController(withIdentifier: "SubScribeViewController") as! SubScribeViewController
        return logsDisplayVC
    }
    
    @IBAction func eventAction(_ sender: Any) {
        let state = event.isOn
        SharedUtil.setDefaultBoolean(state, kEventSub)
        print("Event \(state)")
        if state == true{
            Roam.subscribe(.Events, SharedUtil.getDefaultString(kUserId))
        }else{
            Roam.unsubscribe(.Events, SharedUtil.getDefaultString(kUserId))
        }
        
    }
    
    @IBAction func locationAction(_ sender: Any) {
        let state = location.isOn
        SharedUtil.setDefaultBoolean(state, kLocationSub)
        
        if state == true{
            Roam.subscribe(.Location, SharedUtil.getDefaultString(kUserId))
        }else{
            Roam.unsubscribe(.Location, SharedUtil.getDefaultString(kUserId))
        }
        
        print("location \(state)")
        
    }
    
    @IBAction func otherAction(_ sender: Any) {
        
        openAlert()
        
        let state = otherLocation.isOn
        SharedUtil.setDefaultBoolean(state, kOtherLocationSub)
        
    }
    
    @IBAction func tripListenerAction(_ sender: Any){
        if tripListener.isOn{
            openAlert2()
        }else{
            let str = SharedUtil.getDefaultString(kTripStatusListener)
            if str.isEmpty == false{
                Roam.unsubscribeTrip(str)
                self.updateLabel("")
                SharedUtil.removeKey(kTripStatusListener)
            }
        }
        
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func openAlert2(){
        let alertController = UIAlertController(title: "Trip Listener", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter trip id"
        }
        let saveAction = UIAlertAction(title: "Subscibe", style: .default, handler: { alert -> Void in
            if let textField = alertController.textFields?[0] {
                if textField.text!.count > 0 {
                    let str = textField.text!
                    self.updateLabel(str)
                    Roam.subscribeTrip(str)
                    SharedUtil.setDefaultString(str, kTripStatusListener)
                }else{
                    self.tripListener.isOn = false
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style:.cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func updateLabel(_ userId:String){
        self.tripListenerLabel.text = "Trip Listener  " + userId
        
    }
    
    func openAlert(){
        let alertController = UIAlertController(title: "Other User Location ", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter User id"
        }
        var title = ""
        if self.otherLocation.isOn == false{
            title = "UnSubscibe"
        }else{
            title = "Subscibe"
        }
        
        let saveAction = UIAlertAction(title: title, style: .default, handler: { alert -> Void in
            let state = self.otherLocation.isOn

            if let textField = alertController.textFields?[0] {
                let str = textField.text!
                if state{
                    SharedUtil.setDefaultBoolean(state, kOtherLocationSub)
                    Roam.subscribe(.Location, str)
                }else{
                    Roam.unsubscribe(.Location, str)
                    SharedUtil.setDefaultBoolean(state, kOtherLocationSub)
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style:.cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    

    @IBAction func unsubscribeAction(_ sender: Any) {
        Roam.stopPublishing()
    }
    
}
