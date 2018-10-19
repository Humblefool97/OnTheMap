//
//  ConfirmLocationViewController.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 04/10/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class ConfirmLocationViewController: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var confirmButton: UIButton!
    var selectedLocation:String = ""
    var mediaUrl:String = ""
    @IBOutlet weak var mapView: MKMapView!
    var confirmLocationCoordinates:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initButton()
        loadLocation()
    }
    
    fileprivate func initButton(){
        confirmButton.layer.cornerRadius = 10
        confirmButton.clipsToBounds = true
    }
    
    
    fileprivate func loadLocation() {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(selectedLocation){(placemarks: [CLPlacemark]?, error: Error?) in
            if error != nil {
                self.displayErrorMessage("Error in finding location")
                return
            }
            if let placemarks = placemarks {
                if placemarks.count == 0 {
                    self.displayErrorMessage("Could not find location!")
                    return
                }
                let locationPlacemark = placemarks[0]
                let annotation = MKPointAnnotation()
                self.confirmLocationCoordinates = (locationPlacemark.location?.coordinate)!
                annotation.coordinate = self.confirmLocationCoordinates
                self.mapView.addAnnotation(annotation)
                let distance = CLLocationDistance(5000.0)
                let region = MKCoordinateRegionMakeWithDistance(self.confirmLocationCoordinates, distance, distance)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    @IBAction func onConfirmClicked(_ sender: UIButton) {
        let studentInfo = UserSession.instance.studentInfo
        studentInfo.mapString = selectedLocation
        studentInfo.mediaUrl = mediaUrl
        studentInfo.latitude = confirmLocationCoordinates.latitude
        studentInfo.longitude = confirmLocationCoordinates.longitude
        let loadingIndicator = UIViewController.displayLoadingIndicator(view: self.view)
        NetworkController.init().instance().postStudentLocation(studentInfo: studentInfo){
            isSuccess,errorString in
            if(!isSuccess){
                performUIUpdatesOnMain {
                    UIViewController.removeLoader(view:loadingIndicator)
                    self.displayErrorMessage("Something went wrong!!")
                }
            }else{
                performUIUpdatesOnMain {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
    func displayErrorMessage(_ errorMessage:String?) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
}
