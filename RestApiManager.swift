//
//  RestApiManager.swift
//  Pods
//
//  Created by Andrew Loutfi on 5/3/16.
//
//

import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    
    static let sharedInstance = RestApiManager()
    
    static var airline: String = ""
    static var flightNo: String = ""
    static var date: String = ""
    
    
    
    func getFlight(airline: String, flightNo: String, date: String, onCompletion: (JSON) -> Void) {
        let route = "https://api.flightstats.com/flex/flightstatus/rest/v2/json/flight/status/" + airline + "/" + flightNo + "/dep/" + date + "?appId=12a137b7&appKey=f651fc28378af83467e543f6cec51f95&utc=false"

        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    private func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let jsonData = data {
                let json:JSON = JSON(data: jsonData)
                onCompletion(json, error)
            } else {
                onCompletion(nil, error)
            }
        })
        task.resume()
    }
    
}