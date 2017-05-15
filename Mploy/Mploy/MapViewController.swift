//
//  MapViewController.swift
//  Mploy
//
//  Created by Sanjay Tamizharasu on 4/15/17.
//  Copyright © 2017 SanjayTamizharasu. All rights reserved.
//

import UIKit
import Firebase
import MapKit


class MapViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    var locationManager: CLLocationManager = CLLocationManager()
    
    var jobPostings: [JobPosting] = []
    var ref: FIRDatabaseReference!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        
        ref = FIRDatabase.database().reference().child("Jobs")
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let initialLocation = CLLocation(latitude: 37.3351874, longitude: -121.88107150000002)
        centerMapOnLocation(location: initialLocation)
        
        loadData()
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 19.0, regionRadius * 19.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func loadData() {
        ref.observe(.value, with: { snapshot in
            var newJobs: [JobPosting] = []
            print(snapshot.childrenCount)
            print(snapshot.key)
            for item in snapshot.children {
                let jobPost = JobPosting(snapshot: (item as? FIRDataSnapshot)!)
                newJobs.append(jobPost)
                print(item)
            }
            
            self.jobPostings = newJobs
            //self.tableView.reloadData()
            print("NEW")
            print(self.jobPostings.count)
            
            
            for job in self.jobPostings{
                let latitude = Double(job.latitude)
                let longitude = Double(job.longitude)
                
                let lat: CLLocationDegrees = latitude!
                let long: CLLocationDegrees = longitude!
                
                let jobannotation = jobAnnotation(title: job.title,
                                                  location: job.location,
                                                  discipline: job.description,
                                                  coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long))
                
                self.mapView.addAnnotation(jobannotation)
            }

        })
        
    }
}
