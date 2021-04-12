//
//  MapViewController.swift
//  TestExample
//
//  Created by Roam Device on 12/06/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import UIKit
import MapKit
import Roam

class MapViewController: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locations: [[String: Any]]?
    //let annotation = MKPointAnnotation()
    var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
    var last:CLLocationCoordinate2D?
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    
    static public func viewController() -> MapViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let logsDisplayVC = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        return logsDisplayVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .white
        self.setAnnotations(AppUtility.currentTimestamp())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    func setAnnotations(_ dateStr:String){
        
        let datas  = UserDefaults.standard.array(forKey: "RoamKeyForLatLongInfo") as? [[String:Any]]
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
            }else {
                clearMonitoring()
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
    
    @IBAction func selectDate(){
        doDatePicker()
    }
    
    func doDatePicker(){
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: self.view.frame.size.height - 200, width: self.view.frame.size.width, height: 200))
        self.datePicker?.backgroundColor = UIColor.white
        self.datePicker?.datePickerMode = .date
        view.addSubview(self.datePicker)
        
        // ToolBar
        
        toolBar.frame = CGRect(x: 0, y: self.view.frame.size.height - 240, width: self.view.frame.size.width, height: 40)
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        self.view.addSubview(toolBar)
        self.toolBar.isHidden = false
        
    }
    
    @objc func doneClick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormatter.string(from: datePicker.date)
        print(dateStr)
        setAnnotations(dateStr)
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    
    @objc func cancelClick() {
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    
    func clearMonitoring(){
        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove )
        DispatchQueue.main.async {
            let overlays = self.mapView.overlays.filter{ $0 !== self.mapView.userLocation }
            self.mapView.removeOverlays(overlays)
        }
    }
}

class Station: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var latitude: Double
    var longitude:Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}


