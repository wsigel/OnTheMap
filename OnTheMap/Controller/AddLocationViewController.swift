//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 15.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var addLocationActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var addLocationMapView: MKMapView!
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishButtonTapped(_ sender: Any) {
    }
    @IBAction func findLocationButtonTapped(_ sender: Any) {
        showActivityIndicator(show: true)
        guard let locationText = self.locationTextField.text else {
            return
        }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationText) { (placemarks, error) in
            if let placemark = placemarks?.first {
                if let coordinates: CLLocationCoordinate2D = placemark.location?.coordinate {
                    print("Breite \(coordinates.longitude) / Länge \(coordinates.latitude)")
                    
                    //let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
                    //let coordinateRegion = MKCoordinateRegion(center: coordinates, latitudinalMeters: 5000, longitudinalMeters: 5000)
                    let coordinateRegion = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 15.0, longitudeDelta: 15.0))
                    self.addLocationMapView.setRegion(coordinateRegion, animated: true)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinates
                    annotation.title = "Demo name"
                    annotation.subtitle = "www.google.com"
                    
                    self.addLocationMapView.addAnnotation(annotation)
                }
            }
        }
        showActivityIndicator(show: false)
    }
    
    func showActivityIndicator(show: Bool) -> Void {
        if show {
            addLocationActivityIndicator.startAnimating()
        } else {
            addLocationActivityIndicator.stopAnimating()
        }
    }
}
