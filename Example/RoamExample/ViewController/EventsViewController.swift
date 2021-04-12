//
//  EventsViewController.swift
//  TestExample
//
//  Created by Roam Mac 15 on 16/06/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import UIKit
import Roam

let geofenceEvent = "Geofence Event"
let tripEvent     = "Trip Event"
let nearbyEvent   = "NearBy Event"
let motionEvent   = "Location Event"
let event_Listener  = "Event Listener"
let location_Listener  = "Location Listener"


class EventsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView1: UITableView!
    
    var allEventCharacters:[Character] = []
    var allListenerCharacters:[Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allEventCharacters = [Character(name: geofenceEvent),Character(name: tripEvent),Character(name: nearbyEvent),Character(name: motionEvent)]
        allListenerCharacters = [Character(name: event_Listener),Character(name: location_Listener)]
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    
    static public func viewController() -> EventsViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let logsDisplayVC = storyBoard.instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
        return logsDisplayVC
    }
    
    var allCharacters:[Character] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1 {
            return allListenerCharacters.count
        }else{
            return allEventCharacters.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        }
        
        if tableView == tableView1{
            cell?.textLabel?.text = allListenerCharacters[indexPath.row].name
            if allListenerCharacters[indexPath.row].isSelected
            {
                cell?.accessoryType = .checkmark
            }
            else
            {
                cell?.accessoryType = .none
            }
            cell?.selectionStyle = .none
            
        }else{
            cell?.textLabel?.text = allEventCharacters[indexPath.row].name
            if allEventCharacters[indexPath.row].isSelected
            {
                cell?.accessoryType = .checkmark
            }
            else
            {
                cell?.accessoryType = .none
            }
            cell?.selectionStyle = .none
            
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tableView1{
            allListenerCharacters[indexPath.row].isSelected = !allListenerCharacters[indexPath.row].isSelected
        }else{
            allEventCharacters[indexPath.row].isSelected = !allEventCharacters[indexPath.row].isSelected
        }
        tableView.reloadData()
    }
    
    func reset(){
        allEventCharacters[0].isSelected = false
        allEventCharacters[1].isSelected = false
        allEventCharacters[2].isSelected = false
        allEventCharacters[3].isSelected = false
        
        allListenerCharacters[0].isSelected = false
        allListenerCharacters[1].isSelected = false
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView1.reloadData()
            self.dismissHud()
        }
        
    }
    
    @IBAction func getEventsAction(_ sender: Any) {
        showHud()
        Roam.getEventsStatus { (user, errorStatus) in
            self.updateEvents(user!)
        }
    }
    
    @IBAction func setEventsAction(_ sender: Any) {
        
        var geofence:Bool = false
        var trip:Bool = false
        var nearby:Bool = false
        var motion:Bool = false
        
        allEventCharacters.forEach { (value) in
            if value.name == geofenceEvent{
                geofence = value.isSelected
            }
            if value.name == tripEvent{
                trip = value.isSelected
            }
            if value.name == nearbyEvent{
                nearby = value.isSelected
            }
            if value.name == motionEvent{
                motion = value.isSelected
            }
            
        }
        showHud()
        
        Roam.toggleEvents(Geofence: geofence, Trip: trip, Location: motion, MovingGeofence: nearby) { (user, errorStatus) in
            self.dismissHud()
            if errorStatus == nil {
                self.reset()
            }else{
                Alert.alertController(title: "Events", message: errorStatus?.message, viewController: self)
            }
        }
        
    }
    
    func updateEvents(_ user:RoamUser){
        if user.geofenceEvents{
            allEventCharacters[0].isSelected = true
        }
        if user.tripsEvents{
            allEventCharacters[1].isSelected = true
        }
        if user.nearbyEvents{
            allEventCharacters[2].isSelected = true
        }
        if user.locationEvents{
            allEventCharacters[3].isSelected = true
        }
        
        if user.eventsListener{
            allListenerCharacters[0].isSelected = true
        }
        if user.locationListener{
            allListenerCharacters[1].isSelected = true
        }
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView1.reloadData()
            self.dismissHud()
        }
    }
    
    
    @IBAction func getListenersAction(_ sender: Any) {
        showHud()
        Roam.getListenerStatus { (user, errorStatus) in
            self.updateEvents(user!)
        }
    }
    
    @IBAction func setListenersAction(_ sender: Any) {
        var location_listener_value:Bool = false
        var event_listener_value:Bool = false
        
        allListenerCharacters.forEach { (value) in
            if value.name ==  location_Listener{
                location_listener_value = value.isSelected
            }
            if value.name == event_Listener{
                event_listener_value = value.isSelected
            }
        }
        
        showHud()
        
        Roam.toggleListener(Events: event_listener_value, Locations: location_listener_value) { (user, errorStatus) in
            self.dismissHud()
            if errorStatus == nil {
                self.reset()
            }else{
                Alert.alertController(title: "Listener", message: errorStatus?.message, viewController: self)
            }
        }
    }
}

struct Character
{
    var name:String
    var isSelected:Bool! = false
    init(name:String) {
        self.name = name
    }
}
