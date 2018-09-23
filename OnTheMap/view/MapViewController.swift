//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 03/09/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController, MKMapViewDelegate,DataCompletionListener{
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        setDataCompletionListener(dataCompletionListener: self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        setDataCompletionListener(dataCompletionListener: nil)
    }
    
    // MARK: - MKMapViewDelegate
    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
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
    
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(URL(string: toOpen)!)
            }
        }
    }
    func onDataLoadSuccess(studentList: [StudentTags]?) {
        var annotations = [MKPointAnnotation]()
        if let studentTags = studentList{
            for tag in studentTags {
                // Here we create the annotation and set its coordiate, title, and subtitle properties
                let annotation = MKPointAnnotation()
                annotation.coordinate = tag.coordinate
                annotation.title = "\(tag.firstName) \(tag.lastName)"
                annotation.subtitle = tag.mediaUrl
                
                // Finally we place the annotation in an array of annotations.
                annotations.append(annotation)
            }
            performUIUpdatesOnMain {
                self.mapView.addAnnotations(annotations)
            }
        }
    }
    
    func onDataLoadFailure(errorString: String?) {
        //Display error message
        performUIUpdatesOnMain {
            self.displayErrorMessage(errorString)
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
