//
//  StudentLocationMapViewDelegate.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 18.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation
import MapKit

// MARK: used by MapViewController + AddLocationViewController

class StudentInformationMapViewDelegate: NSObject, MKMapViewDelegate {
    
    var parent: UIViewController
    
    init(viewcontroller: UIViewController){
        parent = viewcontroller
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if !AppDelegate.isNetworkAvailable() {
            ErrorAlertController.showAlertController(parent: parent, title: "Network Connectivity", message: "Unable to open URL: no network available")
            return
        }
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                if toOpen != "" {
                    app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
                }
            }
        }
    }
}

