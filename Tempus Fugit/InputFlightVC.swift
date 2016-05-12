//
//  InputFlightVC.swift
//  Tempus Fugit
//
//  Created by Andrew Loutfi on 5/3/16.
//  Copyright © 2016 Andrew Loutfi. All rights reserved.
//

import UIKit
import SwiftyJSON

class InputFlightVC: UIViewController, UITextFieldDelegate{
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        airline.delegate = self
        flightNumber.delegate = self
        date.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var airline: UITextField!

    @IBOutlet weak var flightNumber: UITextField!
    
    @IBOutlet weak var date: UITextField!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let DestinationViewController : FlightViewController = segue.destinationViewController as! FlightViewController
        
        DestinationViewController.recievedAirline = airline.text!
        DestinationViewController.recievedFlightNumber = flightNumber.text!
        DestinationViewController.recievedDate = date.text!

    }
}