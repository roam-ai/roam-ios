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
    
    
}
class TripTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tripId: UILabel!
    @IBOutlet weak var tripCreated: UILabel!
    @IBOutlet weak var startStop: GradientButton!
    @IBOutlet weak var startStop1: GradientButton!
    @IBOutlet weak var delete: GradientButton!
    @IBOutlet weak var pauseResume: GradientButton!
    @IBOutlet weak var pauseResume1: GradientButton!
    
    @IBOutlet weak var sync: GradientButton!
    
    
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
    
}
