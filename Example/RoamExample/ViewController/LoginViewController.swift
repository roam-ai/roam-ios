//
//  ViewController.swift
//  MotionExample
//
//  Created by Roam Mac 15 on 01/06/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import UIKit
import Roam

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var userDescTextField: UITextField!
    @IBOutlet weak var createUserBtn: UIButton!
    @IBOutlet weak var getUserBtn: UIButton!
    @IBOutlet weak var startSelfTracking: UIButton!
    @IBOutlet weak var requestLocation: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        userIdTextField.delegate = self
        userDescTextField.delegate = self
        
    }
    
    @IBAction func createUserAction(_ sender: Any) {
        showHud()
        Roam.createUser(userDescTextField.text!) { (user, errorStatus) in
            if errorStatus != nil{
                Alert.alertController(title: "Create User", message: errorStatus?.message, viewController: self)
            }else{
                AppUtility.saveUserValue(user!)
                DispatchQueue.main.async {
                    let vc = EventsLoginViewController.viewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            self.dismissHud()
        }
    }
    
    @IBAction func getUserAction(_ sender: Any) {
        
        if userIdTextField.text!.isEmpty{
            Alert.alertController(title: "Get User", message: "User id cannot be empty", viewController: self)
        }else{
            showHud()
            Roam.getUser(userIdTextField.text!) { (user, errorStatus) in
                self.dismissHud()
                if errorStatus != nil{
                    Alert.alertController(title: "Get User", message: errorStatus?.message, viewController: self)
                }else{
                    AppUtility.saveUserValue(user!)
                    let vc = EventsLoginViewController.viewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    
    @IBAction func startSelfTrackingAction(_ sender: Any) {
        
    }
    
    @IBAction func requestLocationAction(_ sender: Any) {
        
    }

}

