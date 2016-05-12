//
//  UserObject.swift
//  Tempus Fugit
//
//  Created by Andrew Loutfi on 5/9/16.
//  Copyright © 2016 Andrew Loutfi. All rights reserved.
//

import SwiftyJSON

class UserObject {
    var Airline: String!
    var Origin: String!
    var Destination: String!
    var ScheduledArrival: String!
    var ActualArrival: String!
    var ScheduledDeparture: String!
    var ActualDeparture: String!
    var Gate: String!
    
    required init(json: JSON){
        Airline = json["appendix"]["airlines"][0]["name"].stringValue
        Destination = json["appendix"]["airports"][1]["City"].stringValue
    }
    
}
