//
//  Alert.swift
//  TestExample
//
//  Created by Roam Mac 15 on 08/06/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import Foundation
import UIKit

class Alert: NSObject {
    
    static func alertController(title: String?,message:String?, viewController:UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let firstAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(firstAction)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
}
