//
//  FlightViewController.swift
//  Tempus Fugit
//
//  Created by Andrew Loutfi on 5/6/16.
//  Copyright © 2016 Andrew Loutfi. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON


class FlightViewController: UIViewController{
       
    @IBOutlet weak var airline: UILabel!
    
    @IBOutlet weak var origin: UILabel!
    
    @IBOutlet weak var destination: UILabel!
    
    @IBOutlet weak var arrival: UILabel!
   
    @IBOutlet weak var departure: UILabel!
    
    @IBOutlet weak var airplane: UILabel!
    
    var recievedAirline = ""
    
    var recievedFlightNumber = ""
    
    var recievedDate = ""
    
    
    
        func updateUI(){
        RestApiManager.sharedInstance.getFlight(recievedAirline, flightNo: recievedFlightNumber, date: recievedDate) { (json:JSON) in

            if json["error"]["errorMessage"].string != nil || self.recievedAirline == "" || self.recievedFlightNumber == "" || self.recievedDate == "" {
                let alert = UIAlertController(title: "Error", message: json["error"]["errorMessage"].stringValue, preferredStyle: UIAlertControllerStyle.Alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                // show the alert
                self.presentViewController(alert, animated: true, completion: nil)
            }else{

            
           
                dispatch_async(dispatch_get_main_queue(),{
                    for (key,subJson):(String, JSON) in json["appendix"]["airlines"] {
                        print(subJson["fs"].stringValue)
                        if subJson["fs"].stringValue == self.recievedAirline {
                            self.airline.text = subJson["name"].stringValue + ", flight: " + self.recievedFlightNumber
                            print(key, self.airline.text)
                    
                        }
                    }
                
                    let departureAirport = json["flightStatuses"][0]["departureAirportFsCode"].stringValue
                    print(departureAirport)
                    let arrivalAirport = json["flightStatuses"][0]["arrivalAirportFsCode"].stringValue
                    print(arrivalAirport)

                    
                    for (key, subJson) : (String, JSON) in json["appendix"]["airports"] {
                        if subJson["fs"].stringValue == departureAirport{
                            
                            self.origin.text = subJson["city"].stringValue + " " + subJson["stateCode"].stringValue + ", " + subJson["countryName"].stringValue
                            
                            //print(key, self.origin.text)
                        }
                        
                        if subJson["fs"].stringValue == arrivalAirport{
                            self.destination.text = subJson["city"].stringValue + ", " + subJson["stateCode"].stringValue + ", " + subJson["countryName"].stringValue
                        }
                    }
                    
                    let scheduledDeparture = json["flightStatuses"][0]["departureDate"]["dateUtc"].stringValue
                    let scheduledArrival = json["flightStatuses"][0]["arrivalDate"]["dateUtc"].stringValue

                    let estimatedDeparture = json["flightStatuses"][0]["operationalTimes"]["estimatedGateDeparture"]["dateUtc"].stringValue
                    let estimatedDepartureTime = estimatedDeparture.componentsSeparatedByString("T")[1]
                    
                    let estimatedArrival = json["flightStatuses"][0]["operationalTimes"]["estimatedGateArrival"]["dateUtc"].stringValue
                    let estimatedArrivalTime = estimatedArrival.componentsSeparatedByString("T")[1]

                    
                    if scheduledDeparture != estimatedDeparture{
                        self.departure.textColor = UIColor.redColor()
                        self.departure.text = (estimatedDepartureTime as NSString).substringToIndex(5)

                    }else{
                        self.departure.text = (estimatedDepartureTime as NSString).substringToIndex(5)
                    }
                    
                    if scheduledArrival != estimatedArrival{
                        self.arrival.textColor = UIColor.redColor()
                        self.arrival.text = (estimatedArrivalTime as NSString).substringToIndex(5)
                    }else{
                        self.arrival.text = (estimatedArrivalTime as NSString).substringToIndex(5)
                    }
                    
                    
                    self.airplane.text = json["appendix"]["equipments"][0]["name"].stringValue

                })
                }
                
            }
            
        }
        

        
        override func viewDidLoad(){
            updateUI()
            super.viewDidLoad()
            
            
        }
            
            
    }