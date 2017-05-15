//
//  JobPosting.swift
//  Mploy
//
//  Created by Sanjay Tamizharasu on 4/14/17.
//  Copyright © 2017 SanjayTamizharasu. All rights reserved.
//

import Foundation
import Firebase


class JobPosting: NSObject{
    
    let title: String
    let compensation: String
    let duration: String
    let email: String
    let jobDescription: String
    let latitude: String
    let longitude: String
    let location: String
    let organization: String
    let phoneNo: String
    
//    init(organization: String, title: String, compensation: String, email: String, duration: String ) {
//        self.organization = organization
//        self.title = title
//    }
    
//    init(snapshot: FIRDataSnapshot) {
//        let dict = snapshot.value as! [String: String]
//        organization  = dict["organization"]! as String
//        title = dict["title"]! as String
//    }
    
//    let phoneNo: String
    
    init(title: String, compensation: String, duration: String, email: String, jobDescription: String, latitude: String,
         longitude: String, location: String, organization: String, phoneNo: String ) {
        //self.key = key
        self.title = title
        self.compensation = compensation
        self.duration = duration
        self.email = email
        self.jobDescription = jobDescription
        self.latitude = latitude
        self.longitude = longitude
        self.location = location
        self.organization = organization
        self.phoneNo = phoneNo
    }
    init(snapshot: FIRDataSnapshot) {
        let dict = snapshot.value as! [String: String]
        title  = dict["jobTitle"]! as String
        compensation  = dict["compensation"]! as String
        duration  = dict["duration"]! as String
        email  = dict["email"]! as String
        jobDescription  = dict["jobDescription"]! as String
        latitude  = dict["latitude"]! as String
        longitude  = dict["longitude"]! as String
        location  = dict["location"]! as String
        organization  = dict["organization"]! as String
        phoneNo  = dict["phoneNo"]! as String
    }
//
//    convenience override init() {
//        self.init(title: "", compensation: "", duration: "", email:  "", jobDescription: "", latitude: "", longitude: "", location: "", organization:"", phoneNo: "")
//    }

}
