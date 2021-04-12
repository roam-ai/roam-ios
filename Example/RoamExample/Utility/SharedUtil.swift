//
//  SharedUtil.swift
//  RoamExample
//
//  Created by Roam Mac #1 on 17/07/18.
//  Copyright © 2018 Roam, Inc. All rights reserved.
//

import UIKit

internal class SharedUtil: NSObject {
    
    static var userDefaultValue:UserDefaults = UserDefaults.standard
    
    // Setting the String Value
    static func setDefaultString(_ value:String,_ key:String){
        userDefaultValue.set(value, forKey: key)
        userDefaultValue.synchronize()
    }
    // Getting the String Value
    static func getDefaultString(_ key:String) -> String{
        if userDefaultValue.object(forKey: key) != nil {
            return userDefaultValue.object(forKey: key) as! String
        }
        return ""
    }
    
    // Setting the Integer Value
    static func setDefaultInteger(_ value:Int,_ key:String){
        userDefaultValue.set(value, forKey: key)
        userDefaultValue.synchronize()
    }
    
    // Getting the Integer Value
    static func getDefaultInteger(_ key:String) -> Int {
        return userDefaultValue.integer(forKey: key)
    }
    // Setting the Double Value
    static func setDefaultDouble(_ value:Double,_ key:String){
        userDefaultValue.set(value, forKey: key)
        userDefaultValue.synchronize()
    }
    
    // Getting the Double Value
    static func getDefaultDouble(_ key:String) -> Double {
        return userDefaultValue.double(forKey: key)
    }
    
    // Setting the Date
    static func setDefaultDate(_ value:Date,_ key:String){
        userDefaultValue.set(value, forKey: key)
        userDefaultValue.synchronize()
    }
    
    // Getting the Date
    static func getDefaultDate(_ key:String) -> Date {
        if userDefaultValue.object(forKey: key) != nil{
            return userDefaultValue.object(forKey: key) as! Date
        }
        return Date()
    }
    
    // Setting the Array of Strings
    static func setDefaultArray(_ value:[String],_ key:String){
        userDefaultValue.set(value, forKey: key)
        userDefaultValue.synchronize()
    }
    
    // Getting the Array of Strings
    static func getDefaultArray(_ key:String) -> [String]{
        let arrayString:[String] = []
        if userDefaultValue.object(forKey: key) != nil{
            return userDefaultValue.array(forKey: key) as! [String]
        }
        return arrayString
    }
    
    // Setting the Boolean Value
    static func setDefaultBoolean(_ value:Bool,_ key:String){
        userDefaultValue.set(value, forKey: key)
        userDefaultValue.synchronize()
    }
    
    // getting the Boolean Value
    static func getDefaultBoolean(_ key:String) -> Bool{
        if (userDefaultValue.object(forKey: key) != nil){
            return userDefaultValue.bool(forKey: key)
        }
        return false
    }

    // Setting the Dictionary Value
    static func setDefaultDictionary(_ dict:Dictionary<String,Any>,_ key:String){
        userDefaultValue.set(dict, forKey: key)
        userDefaultValue.synchronize()
    }
    // Getting the Dictionary Value
    static func getDefaultDictionary(_ key:String) -> Dictionary<String,Any>{
        var dict:Dictionary<String,Any> = [:]
        if let dictValue = userDefaultValue.object(forKey: key){
            dict = dictValue as! Dictionary<String,Any>
        }
        return dict
    }

    static func removeKey(_ key:String){
        userDefaultValue.removeObject(forKey: key)
        userDefaultValue.synchronize()
    }

    // Reset all userdefaults
    
    static func resetDefaults() {
        let defaults = userDefaultValue
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
}

