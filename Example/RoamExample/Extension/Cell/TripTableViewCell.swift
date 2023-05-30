//
//  TripTableViewCell.swift
//  TestExample
//
//  Created by Roam Mac 15 on 10/06/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import UIKit


let colorDefault = UIColor(displayP3Red: 72, green: 141, blue: 251, alpha: 1.0)
protocol TripTableViewCelldelegate {
    func startStopChanged(_ sender: TripTableViewCell)
    func pauseResumeChanged(_ sender: TripTableViewCell)
    func startStopChanged1(_ sender: TripTableViewCell)
    func pauseResumeChanged1(_ sender: TripTableViewCell)
    
    func deleteeChanged(_ sender: TripTableViewCell)
    func syncChanged(_ sender: TripTableViewCell)
    func isSyncChanged(_ sender: TripTableViewCell)
    func tripSummary(_ sender: TripTableViewCell)
    func showTripStop(_ sender: TripTableViewCell)
    func updateTrip(_ sender: TripTableViewCell)
    func subscribeTrip(_ sender: TripTableViewCell)

}

class TripTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tripId: UILabel!
    @IBOutlet weak var isLocalLabel: UILabel!
    @IBOutlet weak var tripCreated: UILabel!
    @IBOutlet weak var tripStatus: UILabel!
    @IBOutlet weak var startStop: GradientButton!
    @IBOutlet weak var startStop1: GradientButton!
    @IBOutlet weak var delete: GradientButton!
    @IBOutlet weak var pauseResume: GradientButton!
    @IBOutlet weak var pauseResume1: GradientButton!
    
    @IBOutlet weak var sync: GradientButton!
    @IBOutlet weak var isSynStatus: GradientButton!
    @IBOutlet weak var tripSummary: GradientButton!
    @IBOutlet weak var showTripStopAction: GradientButton!
    @IBOutlet weak var updateTripAction: GradientButton!
    @IBOutlet weak var subscribeAction: GradientButton!

    
    var delegate:TripTableViewCelldelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func startStopAction(_ sender: Any) {
        if startStop.titleLabel?.textColor == UIColor.white{
            startStop.setTitleColor(.gray, for: .normal)
        }else{
            startStop.setTitleColor(colorDefault, for: .normal)
        }
        delegate?.startStopChanged(self)
    }
    
    @IBAction func pauseResumeAction(_ sender: Any) {
        if pauseResume.titleLabel?.textColor == UIColor.white{
            pauseResume.setTitleColor(.gray, for: .normal)
        }else{
            pauseResume.setTitleColor(colorDefault, for: .normal)
        }
        delegate?.pauseResumeChanged(self)
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        if delete.titleLabel?.textColor == UIColor.white{
            delete.setTitleColor(.gray, for: .normal)
        }else{
            delete.setTitleColor(colorDefault, for: .normal)
        }
        delegate?.deleteeChanged(self)
    }
    
    @IBAction func synsAction(_ sender: Any) {
        if sync.titleLabel?.textColor == UIColor.white{
            sync.setTitleColor(.gray, for: .normal)
        }else{
            sync.setTitleColor(colorDefault, for: .normal)
        }
        delegate?.syncChanged(self)
    }
    
    @IBAction func startStopAction1(_ sender: Any) {
        if startStop1.titleLabel?.textColor == UIColor.white{
            startStop1.setTitleColor(.gray, for: .normal)
        }else{
            startStop1.setTitleColor(colorDefault, for: .normal)
        }
        delegate?.startStopChanged1(self)
    }
    
    @IBAction func pauseResumeAction1(_ sender: Any) {
        if pauseResume1.titleLabel?.textColor == UIColor.white{
            pauseResume1.setTitleColor(.gray, for: .normal)
        }else{
            pauseResume1.setTitleColor(colorDefault, for: .normal)
        }
        delegate?.pauseResumeChanged1(self)
    }
    
    @IBAction func isSyncAction(_ sender: Any) {
        if isSynStatus.titleLabel?.textColor == UIColor.white{
            isSynStatus.setTitleColor(.gray, for: .normal)
        }else{
            isSynStatus.setTitleColor(colorDefault, for: .normal)
        }
        delegate?.isSyncChanged(self)
    }
    
    @IBAction func summaryAction(_ sender: Any) {
        if tripSummary.titleLabel?.textColor == UIColor.white{
            tripSummary.setTitleColor(.gray, for: .normal)
        }else{
            tripSummary.setTitleColor(colorDefault, for: .normal)
        }
        delegate?.tripSummary(self)
    }
    
    @IBAction func stopAction(_ sender: Any) {
        if showTripStopAction.titleLabel?.textColor == UIColor.white{
            showTripStopAction.setTitleColor(.gray, for: .normal)
        }else{
            showTripStopAction.setTitleColor(colorDefault, for: .normal)
        }
        delegate?.showTripStop(self)
    }
    
    @IBAction func udpateAction(_ sender: Any) {
        if updateTripAction.titleLabel?.textColor == UIColor.white{
            updateTripAction.setTitleColor(.gray, for: .normal)
        }else{
            updateTripAction.setTitleColor(colorDefault, for: .normal)
        }
        delegate?.updateTrip(self)
    }

    @IBAction func subscribeTripAction(_ sender: Any) {
        if subscribeAction.titleLabel?.textColor == UIColor.white{
            subscribeAction.setTitleColor(.gray, for: .normal)
        }else{
            subscribeAction.setTitleColor(colorDefault, for: .normal)
        }
        if subscribeAction.titleLabel?.text == "Subscribe"{
            subscribeAction.setTitle("UnSubscribe", for: .normal)
        }else{
            subscribeAction.setTitle("Subscribe", for: .normal)
        }
        delegate?.subscribeTrip(self)
    }
}
