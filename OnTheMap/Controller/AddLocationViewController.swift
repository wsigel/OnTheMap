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
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocationButtonTapped(_ sender: Any) {
        guard let locationText = self.locationTextField.text else {
            return
        }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationText) { (placemarks, error) in
            if let placemark = placemarks?.first {
                if let coordinates: CLLocationCoordinate2D = placemark.location?.coordinate {
                    print("Breite \(coordinates.longitude) / Länge \(coordinates.latitude)")
                }
            }
        }
    }
}
