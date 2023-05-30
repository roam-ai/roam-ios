//
//  GetTripViewController.swift
//  TestExample
//
//  Created by Roam on 12/12/22.
//  Copyright © 2022 GeoSpark. All rights reserved.
//

import UIKit
import Roam

class GetTripViewController: UIViewController,UITextViewDelegate {

    @IBOutlet var textView: UITextView!
    var response:RoamTripResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        if response != nil {
            updateTrip()
        }
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
    
    static public func viewController() -> GetTripViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let logsDisplayVC = storyBoard.instantiateViewController(withIdentifier: "GetTripViewController") as! GetTripViewController
        return logsDisplayVC
    }

    func updateTrip(){
        let response = AppUtility.createTripParamter(response!)
        DispatchQueue.main.async {
//            Alert.alertController(title: "Get ", message: response.userJson!, viewController: self)
            self.textView.text = response.userJson!
            UIPasteboard.general.string = self.textView.text
        }

    }

}
