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
    var manager:CLLocationManager!

    @IBOutlet var latitudLabel: UILabel!
    @IBOutlet var longitudLabel: UILabel!
    @IBOutlet var cursoLabel: UILabel!
    @IBOutlet var velocidadLabel: UILabel!
    @IBOutlet var altitudLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    
    
    
    override func viewDidLoad()
    {
        //asignando valor a manager, el valor de el metodo CLLocation, dara la localizacion y mas datos
        manager = CLLocationManager()
        // manager controlara o delegara el uiviewcontroller
        manager.delegate = self
        //nos dara la localizacion gps mejor encontrada
        manager.desiredAccuracy - kCLLocationAccuracyBest
        //mostrar el mensaje que introdujimos en info.plist para el usuario, donde solicitamos
        manager.requestWhenInUseAuthorization()
        
        manager.startUpdatingLocation()
        
        super.viewDidLoad()
    }
    
    //metodo para localizar si se actualizco la localizacio
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations)
        
        //abrimos una variable con la localizacion, la cual ya tenemos de el metodo que se esta llamando
        var userLocation:CLLocation = locations[0]
        
        //asignamos en el texto de la etiqueta, las latitudes las cuales se convirtieron a String
        //self.latitudLabel.text = String(userLocation.coordinate.latitude)
        self.latitudLabel.text = "\(userLocation.coordinate.latitude)"

        //la misma asignacion pero diferente metodo para convertir, se abre una cadena y se concatena otro tipo de variable
        self.longitudLabel.text = "\(userLocation.coordinate.longitude)"
        
        self.cursoLabel.text = "\(userLocation.course)"
        
        self.velocidadLabel.text = "\(userLocation.speed)"
        
        self.altitudLabel.text = "\(userLocation.altitude)"
        
        
        
        //GEOCODER es tomar una direccion y convertirla en coordenadas
        //geocoderreverse es tomar coordenada para mostrar o hacer una direccion
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
          
            if (error != nil)
            {
                
                print(error)
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
                    //localty es ciudad
                    //subadministrativearea es  condado
                    //subLocality es el area o distrito
                    //administrativeArea estado
                    self.addressLabel.text = " \(numeroStreet) \(p.subLocality!) \n \(p.locality!) \(p.subAdministrativeArea!), \n \(p.administrativeArea!) \(p.country!) \n \(p.postalCode!), "

                }
            }
            
        })

  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

