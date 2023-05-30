//
//  StopMapViewController.swift
//  TestExample
//
//  Created by GeoSpark on 29/03/22.
//  Copyright © 2022 GeoSpark. All rights reserved.
//

import UIKit
import MapKit
import Roam

class StopMapViewController: UIViewController,MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    var longPressRecognizer = UILongPressGestureRecognizer()
    var tripStops:[RoamTripStop] = []
    var isLocalTrip:Bool = false
    var tripId:String?
    var isCreateTrip:Bool = false
    @IBOutlet weak var updateTripBtn: GradientButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.mapView.mapType = .standard
        self.mapView.isZoomEnabled = true
        self.mapView.showsUserLocation = true
        
        longPressRecognizer = UILongPressGestureRecognizer(target: self,
                                                           action: #selector(self.longPress))
        longPressRecognizer.minimumPressDuration = 0.5
        longPressRecognizer.delegate = self
        mapView.addGestureRecognizer(longPressRecognizer)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        Roam.getCurrentLocation(100) { location, error in
            if error == nil {
                self.updateMap(location!.coordinate)
            }else{
                Alert.alertController(title: "Location", message: error?.message, viewController: self)
            }
        }
    }
    
    static public func viewController() -> StopMapViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let logsDisplayVC = storyBoard.instantiateViewController(withIdentifier: "StopMapViewController") as! StopMapViewController
        return logsDisplayVC
    }
    
    
    func updateMap(_ locValue:CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        self.mapView.setRegion(region, animated: true)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(mapView.centerCoordinate)
    }
    
    @IBAction func clearAnnotations(_ sender: UIButton) {
        self.mapView.removeAnnotations(mapView.annotations)
    }
    
    func addAnnotation(coordinate:CLLocationCoordinate2D){
        self.addStop(coordinate)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    func addStop(_ coor:CLLocationCoordinate2D){
        ReverseGeocoding.geocode(latitude: coor.latitude, longitude: coor.longitude) { _ , completeAddress, error in
            let stop = RoamTripStop()
            stop.stopName = "Stop \(Int.random(in: 0..<6))"
            stop.geometryCoordinates = [coor.longitude,coor.latitude]
            stop.geometryRadius = 100
            if completeAddress?.isEmpty == false{
                stop.address = completeAddress
            }
            self.tripStops.append(stop)
        }
    }
    
    @IBAction func updateTrip(_ sender: Any) {
        let trip = RoamTrip()
        
        trip.isLocal = isLocalTrip
        trip.stops = []
//        if !tripStops.isEmpty{
//            trip.stops = tripStops
//        }
        
        if isCreateTrip{
            trip.metadata = ["PaymentMode":"Value"]
            trip.tripDescription = "Create trip Delivery Description"
            trip.tripName = "Create trip Delivery"
        }else{
            trip.metadata = ["Address":"Value"]
            
            trip.tripDescription = "Update trip Delivery Description"
            trip.tripName = "Update trip Delivery"
        }
        
        self.showHud()
        if isCreateTrip{
            Roam.createTrip(trip) { trip, error in
                self.dismissHud()
                if trip == nil {
                    self.updateLabelError(error!, "Create Trip")
                }else{
                    self.updateLabel(trip!, "Create Trip")
                }
            }
        }else{
            trip.tripId = tripId
            Roam.updateTrip(trip) { trip, error in
                self.dismissHud()
                if trip == nil {
                    self.updateLabelError(error!, "Update Trip")
                }else{
                    self.updateLabel(trip!, "Update Trip")
                }
            }
        }
        
    }

    func updateLabel(_ respons:RoamTripResponse, _ str:String){
        let response = AppUtility.createTripParamter(respons)
        DispatchQueue.main.async {
            print("\(str) \(response.userJson!)")
            Alert.alertController(title: str, message: response.userJson!, viewController: self)
            UIPasteboard.general.string = response.userJson!
        }
    }
    
    func updateLabelError(_ respons:RoamTripError, _ str:String){
        var response:String = respons.errorDescription! + "        "  + respons.message! + "\n "
        respons.errors.forEach { erro in
            response += "\(erro.field) \("       ") \(erro.message)" + "\n "
        }
        DispatchQueue.main.async {
            Alert.alertController(title: str, message: response, viewController: self)
            UIPasteboard.general.string = response
        }
    }

    
}
extension StopMapViewController : UIGestureRecognizerDelegate
{
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended{
            let locationInView = sender.location(in: mapView)
            let tappedCoordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addAnnotation(coordinate: tappedCoordinate)
        }
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }
    
}


class ReverseGeocoding {
    
    static func geocode(latitude: Double, longitude: Double, completion: @escaping (CLPlacemark?, _ completeAddress: String?, Error?) -> ())  {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                completion(nil, nil, error)
                return
            }
            
            let completeAddress = getCompleteAddress(placemarks)
            
            completion(placemark, completeAddress, nil)
        }
    }
    
    static private func getCompleteAddress(_ placemarks: [CLPlacemark]?) -> String {
        guard let placemarks = placemarks else {
            return ""
        }
        
        let place = placemarks as [CLPlacemark]
        if place.count > 0 {
            let place = placemarks[0]
            var addressString : String = ""
            if place.thoroughfare != nil {
                addressString = addressString + place.thoroughfare! + ", "
            }
            if place.subThoroughfare != nil {
                addressString = addressString + place.subThoroughfare! + ", "
            }
            if place.locality != nil {
                addressString = addressString + place.locality! + ", "
            }
            if place.postalCode != nil {
                addressString = addressString + place.postalCode! + ", "
            }
            if place.subAdministrativeArea != nil {
                addressString = addressString + place.subAdministrativeArea! + ", "
            }
            if place.country != nil {
                addressString = addressString + place.country!
            }
            
            return addressString
        }
        return ""
    }
}

extension Dictionary {
    var userJson: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
            return nil
        }
        return String(data: theJSONData, encoding: .utf8)
    }
}
