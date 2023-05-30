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
    case Start = "start"
    case End = "end"
    case Pause = "pause"
    case Resume = "resume"
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
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: Notification.Name("UserLoggedIn1"), object: nil)
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .white
        addStartButtonOnRight()
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
    
    @objc func loadData(){
        self.showHud()
        Roam.getActiveTrips(self.activeSelectSegment()) { (trip, status) in
            let trips = trip?.trips
            if trips?.count != 0 && status == nil{
                self.localTrips = trips ?? []
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
        print("TripId \(trip.tripId) Local trip  \(trip.isLocal)")
        cell?.tripId.text = trip.tripId! + " Stop count \(trip.stops.count)"
        cell?.tripCreated.text = "Created At : " + (trip.createdAt?.fromUTCToLocalDate())! + "\n "
                                        + "Trip Name:  " + trip.tripName! + "\n"
                                        + "Trip Descr : " + trip.tripDescription!
        cell?.tripStatus.text = trip.tripState!
        cell?.delete.isHidden = false
        if tripStatuVale == 0 {
            cell?.sync.isHidden = true
        }else{
            cell?.sync.isHidden = false
        }
        
        if SharedUtil.getDefaultString(kTripStatusListener) ==  trip.tripId {
            cell?.subscribeAction.setTitle("UnSubscribe", for: .normal)
        }else{
            cell?.subscribeAction.setTitle("Subscribe", for: .normal)
        }
        cell?.isLocalLabel.text = "isLocal \(trip.isLocal)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trip = self.localTrips[(indexPath.row)]
        UIPasteboard.general.string = trip.tripId
    }
        
    func startStopChanged(_ sender: TripTableViewCell) {
        let indexPath = self.tableView.indexPath(for: sender)
        let trip = self.localTrips[(indexPath?.row)!]
        
        promptForAnswer(trip)
    }
    
    func pauseResumeChanged(_ sender: TripTableViewCell) {
        let indexPath = self.tableView.indexPath(for: sender)
        let trip = self.localTrips[(indexPath?.row)!]
        
        showHud()
        
        Roam.pauseTrip(trip.tripId!) { trip, error in
            
            var message:String?
            if trip == nil{
                message = error?.message
            }else{
                message = AppUtility.createTripParamter(trip!).userJson!
            }
            Alert.alertController(title: "Pause Trip", message: message, viewController: self)
            
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
        
        
        Roam.deleteTrip(trip.tripId!) { trip, error in
            
            if trip == nil {
                Alert.alertController(title: "Delete Trip", message: error?.message, viewController: self)
            }else{
                Alert.alertController(title: "Delete Trip", message: trip?.messageDescription, viewController: self)
            }
            self.loadData()
        }
    }
    
    func syncChanged(_ sender: TripTableViewCell) {
        self.showHud()
        let indexPath = self.tableView.indexPath(for: sender)
        let trip = self.localTrips[(indexPath?.row)!]
        Roam.syncTrip(trip.tripId!) { trip, error in
            if trip == nil {
                Alert.alertController(title: "Sync Trip", message: error?.errorDescription, viewController: self)
            }else{
                Alert.alertController(title: "Sync Trip", message: trip?.messageDescription, viewController: self)
            }
            self.loadData()

        }
        self.dismissHud()
    }
        
    func startStopChanged1(_ sender: TripTableViewCell) {
        let indexPath = self.tableView.indexPath(for: sender)
        let trip = self.localTrips[(indexPath?.row)!]
        let alert = UIAlertController(title: "End Trip", message: "Do you want forceStopTracking ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default , handler:{ (UIAlertAction)in
            self.endTrip(trip.tripId!, true)
        }))
        
        alert.addAction(UIAlertAction(title: "NO", style: .default , handler:{ (UIAlertAction)in
            self.endTrip(trip.tripId!, false)
        }))
        
        self.present(alert, animated:true)
    }
    
    func endTrip(_ tripId:String,_ boolV:Bool){
        showHud()
        Roam.endTrip(tripId,boolV) { trip, error in
            var message:String?
            if trip == nil{
                message = error?.message
            }else{
                message = AppUtility.createTripParamter(trip!).userJson!
            }
            Alert.alertController(title: "End Trip", message: message, viewController: self)
            self.loadData()
        }
    }
    
    func pauseResumeChanged1(_ sender: TripTableViewCell) {
        let indexPath = self.tableView.indexPath(for: sender)
        let trip = self.localTrips[(indexPath?.row)!]
        
        showHud()
        Roam.resumeTrip(trip.tripId!) { trip, error in
            var message:String?
            if trip == nil{
                message = error?.message
            }else{
                message = AppUtility.createTripParamter(trip!).userJson!
            }
            Alert.alertController(title: "Resume Trip", message: message, viewController: self)
            self.loadData()
        }
    }
    
    func isSyncChanged(_ sender: TripTableViewCell) {
        let indexPath = self.tableView.indexPath(for: sender)
        let trip = self.localTrips[(indexPath?.row)!]
        Roam.getTrip(trip.tripId!) { trip, error in
            if trip != nil {
                let vc = GetTripViewController.viewController()
                vc.response = trip
                self.navigationController?.pushViewController(vc, animated: true)

            }else{
                Alert.alertController(title: "Get Trip Error ", message: "\(error?.code)\("   ")\(error?.message)", viewController: self)
            }
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
    
    
    func promptForAnswer(_ trip:RoamTrip) {
        showHud()
        Roam.startTrip(trip.tripId!) { trip, error in
            var message:String?
            if trip == nil{
                message = error?.message
            }else{
                message = AppUtility.createTripParamter(trip!).userJson!
            }
            Alert.alertController(title: "Start Trip", message: message, viewController: self)
            self.loadData()
        }
    }
    
    func tripSummary(_ sender: TripTableViewCell) {
        let indexPath = self.tableView.indexPath(for: sender)
        let trip = self.localTrips[(indexPath?.row)!]

        showHud()
        
        Roam.getTripSummary(trip.tripId!) { tripVal, error in
            self.dismissHud()
            if tripVal == nil {
                self.updateLabelError(error!, "Trip Summary")
            }else{
                self.updateLabel(tripVal!, "Trip Summary")
            }

        }
    }
    
    func updateLabel(_ respons:RoamTripResponse, _ str:String){
        let response = AppUtility.createTripParamter(respons)
        DispatchQueue.main.async {
            Alert.alertController(title: str, message: response.userJson!, viewController: self)
            UIPasteboard.general.string = response.userJson!
        }
    }
    
    func updateLabelError(_ respons:RoamTripError, _ str:String){
        var response:String = respons.errorDescription! + respons.message!
        respons.errors.forEach { erro in
            response += "\(erro.field) \("       ") \(erro.message)"
        }
        DispatchQueue.main.async {
            Alert.alertController(title: str, message: response, viewController: self)
            UIPasteboard.general.string = response
        }
    }
    
    func showTripStop(_ sender: TripTableViewCell) {
//        let indexPath = self.tableView.indexPath(for: sender)
//        let trip = self.localTrips[(indexPath?.row)!]
//
//        let vc = ShowStopsViewController.viewController()
//        vc.dataCount = trip.stops
//        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func updateTrip(_ sender: TripTableViewCell) {
        let indexPath = self.tableView.indexPath(for: sender)
        let trip = self.localTrips[(indexPath?.row)!]

        let vc = StopMapViewController.viewController()
        vc.tripId = trip.tripId
        vc.isCreateTrip = false
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func subscribeTrip(_ sender: TripTableViewCell) {
        let indexPath = self.tableView.indexPath(for: sender)
         let trip = self.localTrips[(indexPath?.row)!]
        if (sender.subscribeAction.titleLabel?.text)! == "Subscribe" {
            Roam.subscribeTrip(trip.tripId!)
            SharedUtil.setDefaultString(trip.tripId!, kTripStatusListener)
        }else{
            Roam.unsubscribeTrip()
            SharedUtil.removeKey(kTripStatusListener)
        }
        self.loadData()
    }
    
    
}
