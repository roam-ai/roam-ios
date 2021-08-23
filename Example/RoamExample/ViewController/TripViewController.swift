//
//  TripViewController.swift
//  TestExample
//
//  Created by Roam Mac 15 on 10/06/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import UIKit
import Roam

enum TripType: String {
    case Start = "Start"
    case End = "End"
    case Pause = "Pause"
    case Resume = "Resume"
}

class TripViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,TripTableViewCelldelegate{
    
    
    
    @IBOutlet var tripSegment: UISegmentedControl!
    var tripStatuVale:Int = 0
    
    @IBAction func tripAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            tripStatuVale = 0
        }else{
            tripStatuVale = 1
        }
        self.loadData()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var localTrips:[RoamTrip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        let nib = UINib(nibName: "TripTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TripTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .white
        
        addStartButtonOnRight()
        
        self.loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    static public func viewController() -> TripViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let logsDisplayVC = storyBoard.instantiateViewController(withIdentifier: "TripViewController") as! TripViewController
        return logsDisplayVC
    }
    
    func loadData(){
        self.showHud()
        Roam.activeTrips(self.activeSelectSegment()) { (trips, status) in
            if trips?.count != 0 && status == nil{
                self.localTrips = trips!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    self.localTrips = []
                    self.tableView.reloadData()
                }
                
                Alert.alertController(title: "Active Trips", message: status?.message, viewController: self)
            }
            self.dismissHud()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localTrips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripTableViewCell", for: indexPath) as? TripTableViewCell
        cell?.delegate = self
        let trip = localTrips[indexPath.row]
        print(trip.deleted)
        print(trip.started)
        print(trip.paused)
        print(trip.ended)
        print(trip.tripId)
        print(trip.syncStatus)
        if trip.syncStatus != nil{
            cell?.tripCreated.text = trip.createdAt.fromUTCToLocalDate() + "      "  + trip.syncStatus
        }else{
            cell?.tripCreated.text = trip.createdAt.fromUTCToLocalDate()
        }
        cell?.tripId.text = trip.tripId
        if tripStatuVale == 0 {
            cell?.delete.isHidden = true
            cell?.sync.isHidden = true
        }else{
            cell?.delete.isHidden = false
            cell?.sync.isHidden = false
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trip = self.localTrips[(indexPath.row)]
        UIPasteboard.general.string = trip.tripId
    }
        
    func startStopChanged(_ sender: TripTableViewCell) {
        let indexPath = self.tableView.indexPath(for: sender)
        let trip = self.localTrips[(indexPath?.row)!]
        
        showHud()
        
        Roam.startTrip(trip.tripId!) { (status,error) in
            print("Start Trip",status?.status)
            print(error?.code)
            print(error?.message)
            Alert.alertController(title: "Start Trip", message: error?.message, viewController: self)
            self.loadData()
        }
    
    }
    
    func pauseResumeChanged(_ sender: TripTableViewCell) {
        let indexPath = self.tableView.indexPath(for: sender)
        let trip = self.localTrips[(indexPath?.row)!]
        
        showHud()
        Roam.pauseTrip(trip.tripId) { (status, error) in
            print("Pause Trip",status)

            print(error?.code)
            print(error?.message)
            
            Alert.alertController(title: "Pause Trip", message: error?.message, viewController: self)
            self.loadData()
        }
  
    }
    
    func activeSelectSegment() -> Bool{
        if tripStatuVale == 0 {
            return false
        }
        return true
    }
    
    func deleteeChanged(_ sender: TripTableViewCell) {
        let indexPath = self.tableView.indexPath(for: sender)
        let trip = self.localTrips[(indexPath?.row)!]
        
        showHud()
        
        Roam.deleteTrip(trip.tripId) { (status, error) in
            print("Delete Trip",status)

            print(error?.code)
            print(error?.message)
            
            if status != nil{
                Alert.alertController(title: "Delete Trip", message: status, viewController: self)
                
            }else{
                Alert.alertController(title: "Delete Trip", message: error?.message, viewController: self)
                
            }
            self.loadData()
        }
    }
    
    func syncChanged(_ sender: TripTableViewCell) {
        self.showHud()
        let indexPath = self.tableView.indexPath(for: sender)
        let trip = self.localTrips[(indexPath?.row)!]
        Roam.syncTrip(trip.tripId) { (message, error) in
            print("Sync Trip",message)
            print(error?.code)
            print(error?.message)
            
            if message != nil{
                Alert.alertController(title: "Sync Trip", message: message, viewController: self)
                
            }else{
                Alert.alertController(title: "Sync Trip", message: error?.message, viewController: self)
                
            }
            self.loadData()
        }

        self.dismissHud()
    }
        
    func startStopChanged1(_ sender: TripTableViewCell) {
        let indexPath = self.tableView.indexPath(for: sender)
        let vc = StopTripViewController.viewController()
        vc.trip = self.localTrips[(indexPath?.row)!]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pauseResumeChanged1(_ sender: TripTableViewCell) {
        let indexPath = self.tableView.indexPath(for: sender)
        let trip = self.localTrips[(indexPath?.row)!]
        
        showHud()
        Roam.resumeTrip(trip.tripId) { (status,error) in
            print("Resume Trip",status)

            print(error?.code)
            print(error?.message)
            
            Alert.alertController(title: "Resume Trip", message: error?.message, viewController: self)
            self.loadData()
        }
        
    }
    
    func addStartButtonOnRight(){
        let button = UIButton(type: .custom)
        button.setTitle("Quick Start Trip ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        button.layer.cornerRadius = 5
        button.backgroundColor = .lightGray
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 25)
        button.addTarget(self, action: #selector(gotSettingPage), for: UIControl.Event.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func gotSettingPage(){
        let vc = CreateTripViewController.viewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
