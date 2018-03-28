//
//  LocationUtil.swift
//  JZFramework
//
//  Created by Jeff Zhang on 20/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation
import MapKit
import Contacts

open class LocationUtil {
    
    public static func getMapOptionMenu(locationDetail: String) -> UIAlertController {
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: AlertUtil.getActionSheetAlertStyle())
        let appleMapsAction = UIAlertAction(title: "View in Apple Maps", style: .default) { (UIAlertAction) in
            self.openAppleMaps(locationDetail)
        }
        optionMenu.addAction(appleMapsAction)
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            
            let googleMapsAction = UIAlertAction(title: "View in Google Maps", style: .default) { (UIAlertAction) in
                
                let googleLocation = locationDetail.replacingOccurrences(of: " ", with: "+")
                
                UIApplication.shared.openURL(URL(string:
                    "comgooglemaps://?q=\(googleLocation)&views=traffic")!)
            }
            
            optionMenu.addAction(googleMapsAction)
        }
        
        optionMenu.addAction(AlertUtil.getCancelAction())
        return optionMenu
    }
    
    private static func openAppleMaps(_ location: String){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location, completionHandler: { (placemarksOptional, error) in
            if error == nil{
                if let clPlacemark = placemarksOptional?.first{
                    if let coordinate = clPlacemark.location?.coordinate {
                        let addressDict =
                            [CNPostalAddressStreetKey as String : clPlacemark.addressDictionary!["Street"]!,
                             CNPostalAddressCityKey as String : clPlacemark.addressDictionary!["City"]!,
                             CNPostalAddressStateKey as String : clPlacemark.addressDictionary!["State"]!,
                             CNPostalAddressPostalCodeKey as String : clPlacemark.addressDictionary!["ZIP"]!,
                             CNPostalAddressCountryKey as String : clPlacemark.addressDictionary!["Country"]!
                        ]
                        let regionDistance: CLLocationDistance = 500
                        let coordinates = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
                        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
                        let mkPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
                        let options = [
                            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
                        ]
                        
                        let mapItem = MKMapItem(placemark: mkPlacemark)
                        mapItem.openInMaps(launchOptions: options)
                        
                    }else{
                        AlertUtil.presentNoFunctionAlertController(message: "Cannot find location")
                    }
                }else{
                    AlertUtil.presentNoFunctionAlertController(message: "Cannot find any placemark")
                }
            }else{
                print(error!.localizedDescription)
                AlertUtil.presentNoFunctionAlertController(message: (error?.localizedDescription)!)
            }
        })
    }
    
    // user closed this app's location service access OR user closed this iPhone's location service access
    public static func getLocationAlertView(isAppAccess: Bool) -> UIAlertController {
        
        let alertController = UIAlertController(title: "", message: "We need you turn on GPS service to get current location.", preferredStyle: .alert)
        let url = isAppAccess ? URL(string:UIApplicationOpenSettingsURLString)! : URL(string: "App-Prefs:root=Privacy")!
        
        let OKAction = UIAlertAction(title: "Setting", style: .default) { _ in
            UIApplication.shared.openURL(url)
        }
        
        alertController.addActions([OKAction, AlertUtil.getCancelAction()])
        return alertController
    }
}
