//
//  EventsLoginViewController.swift
//  RoamExample
//
//  Created by GeoSpark on 25/06/21.
//

import UIKit
import Roam
class EventsLoginViewController: UIViewController {

    var locationListener:Bool = false
    var eventListener:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func locationListenerToggle(_ sender: UISwitch) {
        let loc:Bool = sender.isOn
        self.locationListener = sender.isOn
        Roam.toggleListener(Events: self.eventListener, Locations: loc)
    }
    
    @IBAction func eventListToggle(_ sender: UISwitch) {
        let loc:Bool = sender.isOn
        self.eventListener = sender.isOn
        Roam.toggleListener(Events: loc, Locations: self.locationListener)
    }
    
    @IBAction func eventsubToggle(_ sender: UISwitch) {
        SharedUtil.setDefaultBoolean(sender.isOn, kEventSub)

        if sender.isOn{
            Roam.subscribe(.Events, SharedUtil.getDefaultString(kUserId))
        }else{
            Roam.unsubscribe(.Events, SharedUtil.getDefaultString(kUserId))
        }
        
    }
    @IBAction func locationsubToggle(_ sender: UISwitch) {
        SharedUtil.setDefaultBoolean(sender.isOn, kLocationSub)
        if sender.isOn{
            Roam.subscribe(.Location, SharedUtil.getDefaultString(kUserId))
        }else{
            Roam.unsubscribe(.Location, SharedUtil.getDefaultString(kUserId))
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func nextAction(_ sender: Any) {
        self.rootViewController()
    }
    
    static public func viewController() -> EventsLoginViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let logsDisplayVC = storyBoard.instantiateViewController(withIdentifier: "EventsLoginViewController") as! EventsLoginViewController
        return logsDisplayVC
    }
    
    
    func rootViewController(){
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let  navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            navigationController.viewControllers = [rootViewController] as [UIViewController]
            navigationController.modalPresentationStyle = .fullScreen
            UIApplication.topViewController()?.present(navigationController, animated: true, completion: nil)
        }
    }
    
}
