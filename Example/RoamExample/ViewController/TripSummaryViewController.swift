//
//  TripSummaryViewController.swift
//  TestExample
//
//  Created by Roam Mac 15 on 01/09/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import UIKit
import MapKit
import Roam

class TripSummaryViewController: UIViewController,MKMapViewDelegate{
    
    
    @IBOutlet var labelStatus: UILabel!
    @IBOutlet var mapView: MKMapView!
    var summary:RoamTripSummary? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self

        Roam.getCurrentLocation(100) { (location, error) in
            if error  != nil{
                Alert.alertController(title: "Error Getting current location", message: (error?.message)! +  (error?.code)!, viewController: self)
            }else{
                let region = MKCoordinateRegion(center: location!.coordinate, latitudinalMeters: 5000.0, longitudinalMeters: 7000.0)
                self.mapView.setRegion(region, animated: true)
            }
        }

        DispatchQueue.main.async {
                         self.labelStatus.text = "Distance : \(String(describing: self.summary!.distanceCovered)) \("   Meter ")\n " + "Duration : \(String(describing: self.summary!.duration)) \("  Seconds")"
                     }
                     
                     if summary != nil {
                         let annotations = getMapAnnotations()
                         mapView.addAnnotations(annotations)
                     }
   
    }
    
    
    static public func viewController() -> TripSummaryViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let logsDisplayVC = storyBoard.instantiateViewController(withIdentifier: "TripSummaryViewController") as! TripSummaryViewController
        return logsDisplayVC
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .white
    }

    func getMapAnnotations()  -> [Capital]{
        var annotations:Array = [Capital]()
    
        summary?.route.forEach({ (route) in
            print(route)
            let cap = Capital(title: route.activity!, coordinate:CLLocationCoordinate2D(latitude: route.coordinates.first!, longitude: route.coordinates.last!) , info: route.recordedAt!)
            annotations.append(cap)
        })
        
        return annotations
    
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


}

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String

    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
