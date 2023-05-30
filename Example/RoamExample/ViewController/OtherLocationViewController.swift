//
//  OtherLocationViewController.swift
//  TestExample
//
//  Created by Roam Device on 22/07/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import UIKit
import MapKit
import Roam

class OtherLocationViewController: UIViewController,MKMapViewDelegate {
    
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
    var last:CLLocationCoordinate2D?
    var dataCount:[Dictionary<String,Any>] = []
    
    static public func viewController() -> OtherLocationViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let otherLocationVC = storyBoard.instantiateViewController(withIdentifier: "OtherLocationViewController") as! OtherLocationViewController
        return otherLocationVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.tblView.estimatedRowHeight = 44.0
        self.tblView.rowHeight = UITableView.automaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateView), name: Notification.Name("UserLoggedIn"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTripEvent), name: Notification.Name("tripStatus"), object: nil)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .white
        self.updateView()
    }
    
    @objc func updateView() {
        
        DispatchQueue.main.async {
            if self.mapView.annotations.count > 0 {
                self.mapView.removeAnnotations(self.mapView.annotations)
            }
            if self.mapView.overlays.count > 0 {
                self.mapView.removeOverlays(self.mapView.overlays)
            }
            
            if self.segmentedControl.selectedSegmentIndex == 1 {
                self.tblView.isHidden = true
                self.mapView.isHidden = false
                self.label.isHidden = true
                self.setAnnotations(AppUtility.currentTimestamp(), key: "RoamKeyForLatLongInfo")
            }
            else if self.segmentedControl.selectedSegmentIndex == 2 {
                self.setAnnotations(AppUtility.currentTimestamp(), key: "RoamKeyForLatLongInfoOthers")
                self.tblView.isHidden = true
                self.mapView.isHidden = false
                self.label.isHidden = true
            }else if self.segmentedControl.selectedSegmentIndex == 3{
                self.tblView.isHidden = true
                self.mapView.isHidden = true
                self.label.isHidden = false

            } else{
                self.getEvents(AppUtility.currentTimestamp())
                if self.dataCount.count > 0 {
                    self.tblView.reloadData()
                }
                self.label.isHidden = true
                self.tblView.isHidden = false
                self.tblView.reloadData()
                self.mapView.isHidden = true
            }
        }
        
    }
    
    @objc func updateTripEvent(notification: NSNotification){
        if let image = notification.userInfo?["trip"] as? RoamTripStatus {
            let str = "Trip id:  \(image.tripId) \n\n" + "  Speed: \(image.speed) \n\n" + "  Distance:\(image.distance)\n\n" + "  Duration:\(image.duration)\n\n" + "  StartedAt:\(image.startedTime)\n\n" + "  pace:\(image.pace)\n\n" + "  latitude:\(image.latitude)\n\n" + " longitude:\(image.longitude)\n\n"
            
            self.label.text = str
        }

    }
    
    @IBAction func clickSegmentedControl(_ sender: Any) {
        self.updateView()
    }
    
    func getEvents(_ dateStr:String){
        let datas  = UserDefaults.standard.array(forKey: "RoamKeyForLatLongInfoEvents") as? [[String:Any]]
        if  datas != nil{
            var _:[[String:Any]] = []
            for data in (datas?.enumerated())! {
                let dateVal = data.element
                let dateString = dateVal["timeStamp"] as! String
                print(dateString)
                if dateString.contains(dateStr){
                    dataCount.append(dateVal)
                }
            }
        }
    }
    
    func setAnnotations(_ dateStr:String,key:String){
        
        let datas  = UserDefaults.standard.array(forKey: key) as? [[String:Any]]
        if  datas != nil{
            var dataValue:[[String:Any]] = []
            for data in (datas?.enumerated())! {
                let dateVal = data.element
                let dateString = dateVal["timeStamp"] as! String
                print(dateString)
                if dateString.contains(dateStr){
                    dataValue.append(dateVal)
                }
            }
            
            let annotations = getMapAnnotations(dataValue)
            mapView.addAnnotations(annotations)
            for annotation in annotations {
                points.append(annotation.coordinate)
                if (annotations.last != nil){
                    last = CLLocationCoordinate2D(latitude: (annotations.last?.latitude)!, longitude: (annotations.last?.longitude)!)
                    zoomToRegion(last!)
                }
            }
            
            if points.count != 0 {
                let polyline = MKPolyline(coordinates: &points, count: points.count)
                mapView.addOverlay(polyline)
                points.removeAll()
            }            
        }
    }
    
    func zoomToRegion(_ location:CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000.0, longitudinalMeters: 7000.0)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        
        if overlay is MKPolyline {
            polylineRenderer.strokeColor = UIColor.blue
            polylineRenderer.lineWidth = 1
        }
        return polylineRenderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            let title = annotation.title!! as NSString
            if title.contains("M") {
                annotationView.image = UIImage(named: "marker-moving")
            }
            else{
                annotationView.image = UIImage(named: "marker-stop")
            }
        }
        
        return annotationView
    }
    
    //MARK:- Annotations
    
    func getMapAnnotations(_ dict:[[String:Any]]) -> [Station] {
        var annotations:Array = [Station]()
        
        for item in dict.enumerated() {
            let locDict = item.element
            let lat = locDict["latitude"] as! Double
            let long = locDict["longitude"] as! Double
            let annotation = Station(latitude: lat, longitude: long)
            annotation.title = "Activity : \((locDict["activity"] as? String) ?? ""),At : \(locDict["timeStamp"] as? String ?? "")"
            annotations.append(annotation)
        }
        return annotations
    }
    
}
extension OtherLocationViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as? LocationTableViewCell
        let dict = dataCount[indexPath.row]
        cell?.firstLabel.text = dict["description"] as? String
        return cell!
    }
    
}
class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
