//
//  ViewController.swift
//  15WhereAmI
//
//  Created by Javier Gomez on 11/24/15.
//  Copyright © 2015 Javier Gomez. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate
{
    //Declare variable type CLLLocationManager
    var manager:CLLocationManager = CLLocationManager()

    @IBOutlet var latitudLabel: UILabel!
    @IBOutlet var longitudLabel: UILabel!
    @IBOutlet var cursoLabel: UILabel!
    @IBOutlet var velocidadLabel: UILabel!
    @IBOutlet var altitudLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    override func viewDidLoad()
    {
        manager.delegate = self
        //Gives the most aqurated localization
        manager.desiredAccuracy - kCLLocationAccuracyBest
        
        //Show message to user, why are we requesting localization
        manager.requestWhenInUseAuthorization()
        
        //Keep updating localization
        manager.startUpdatingLocation()
        super.viewDidLoad()
    }
    
    //If there's an update then trigger function
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        //New variable type CLLocation with locations in it
        let userLocation:CLLocation = locations[0]
        
        self.latitudLabel.text = "\(userLocation.coordinate.latitude)"
        self.longitudLabel.text = "\(userLocation.coordinate.longitude)"
        self.cursoLabel.text = "\(userLocation.course)"
        self.velocidadLabel.text = "\(userLocation.speed)"
        self.altitudLabel.text = "\(userLocation.altitude)"
        
        //GEOCODER tale an address and convert to coordenates
        //GEOCODEREVERSE opposite
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
          
            if (error != nil)
            {
                print(error!)
            }
            else
            {
                if let p = placemarks?.first
                {
                    var numeroStreet:String = "" //llamado subThoroughfare
                    
                    if p.subThoroughfare != nil
                    {
                        numeroStreet = (p.subThoroughfare)!
                    }
                    //localty city
                    //subadministrativearea county
                    //subLocality area/district
                    //administrativeArea state
                    self.addressLabel.text = " \(numeroStreet) \(p.subLocality!) \n \(p.locality!) \(p.subAdministrativeArea!), \n \(p.administrativeArea!) \(p.country!) \n \(p.postalCode!), "

                }
            }
        }) //End GEOCODER
    }
}

