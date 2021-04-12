//
//  Extension.swift
//  TestExample
//
//  Created by Roam Mac 15 on 08/06/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
extension UIButton {
    override open var isEnabled: Bool {
        didSet {
            DispatchQueue.main.async {
                if self.isEnabled {
                    self.alpha = 1.0
                }
                else {
                    self.alpha = 0.6
                }
            }
        }
    }
}

extension String {
    func fromUTCToLocalDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var formattedString = self.replacingOccurrences(of: "Z", with: "")
        if let lowerBound = formattedString.range(of: ".")?.lowerBound {
            formattedString = "\(formattedString[..<lowerBound])"
        }
        
        guard let date = dateFormatter.date(from: formattedString) else {
            return self
        }
        
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    
    func fromUTCToLocalDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var formattedString = self.replacingOccurrences(of: "Z", with: "")
        if let lowerBound = formattedString.range(of: ".")?.lowerBound {
            formattedString = "\(formattedString[..<lowerBound])"
        }
        
        guard let date = dateFormatter.date(from: formattedString) else {
            return self
        }
        
        dateFormatter.dateFormat = "dd MMM yyyy, hh:mm"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
}

extension UserDefaults {
    open func setStruct<T: Codable>(_ value: T?, forKey defaultName: String){
        let data = try? JSONEncoder().encode(value)
        set(data, forKey: defaultName)
    }
    
    open func structData<T>(_ type: T.Type, forKey defaultName: String) -> T? where T : Decodable {
        guard let encodedData = data(forKey: defaultName) else {
            return nil
        }
        
        return try! JSONDecoder().decode(type, from: encodedData)
    }
    
    open func setStructArray<T: Codable>(_ value: [T], forKey defaultName: String){
        let data = value.map { try? JSONEncoder().encode($0) }
        
        set(data, forKey: defaultName)
    }
    
    open func structArrayData<T>(_ type: T.Type, forKey defaultName: String) -> [T] where T : Decodable {
        guard let encodedData = array(forKey: defaultName) as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
}

extension UIViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
