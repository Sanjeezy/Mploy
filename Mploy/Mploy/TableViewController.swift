//
//  TableViewController.swift
//  Mploy
//
//  Created by Sanjay Tamizharasu on 4/14/17.
//  Copyright © 2017 SanjayTamizharasu. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import CoreLocation

class TableViewController: UITableViewController, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    var jobPostings: [JobPosting] = []
    var ref: FIRDatabaseReference!
    var titleToPass: String!
    var compensationToPass: String!
    var emailToPass: String!
    var organizationToPass: String!
    var locationToPass: String!
    var durationToPass: String!
    var DescriptionToPass: String!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //location methods
        manager.delegate = self;
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        ref = FIRDatabase.database().reference().child("Jobs")
        ref.observe(.value, with: { snapshot in
            var newJobs: [JobPosting] = []
            
            for item in snapshot.children {
                let job = JobPosting(snapshot: (item as? FIRDataSnapshot)!)
                newJobs.append(job)
            }
            self.jobPostings = newJobs
            self.tableView.reloadData()
        })
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Mploy"
    }
    

        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jobPostings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let post = jobPostings[indexPath.row]
        cell.textLabel?.text = post.title
        
        let userLatitude = manager.location?.coordinate.latitude
        let userLongitude = manager.location?.coordinate.longitude
        
        if((self.manager.location) != nil) {
        let userLocation: CLLocation = CLLocation(latitude: userLatitude!, longitude: userLongitude!)
        
        let jobLatitude: CLLocationDegrees = Double(post.latitude)! as CLLocationDegrees
        let jobLongitude: CLLocationDegrees = Double(post.longitude)! as CLLocationDegrees
        let jobLocation: CLLocation = CLLocation(latitude: jobLatitude, longitude: jobLongitude)
        
        let distanceInMeters = userLocation.distance(from: jobLocation)
        let distanceInMiles = (distanceInMeters*0.000621371)
        
        if(distanceInMiles < 1){
            let distanceInFeet = String(format:"%.0f feet", distanceInMeters*3.28084)
            cell.detailTextLabel?.text = distanceInFeet
        }
        else{
            let b = String(format:"%.0f miles", distanceInMiles)
            cell.detailTextLabel?.text = b
        }
        }
        else{
        cell.detailTextLabel?.text = post.location
        }
    
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        let job: JobPosting = jobPostings[indexPath.row]
        
        self.titleToPass = currentCell.textLabel?.text
        self.compensationToPass = job.compensation
        self.emailToPass = job.email
        self.organizationToPass = job.organization
        self.locationToPass = job.location
        self.emailToPass = job.email
        self.durationToPass = job.duration
        self.DescriptionToPass = job.jobDescription
        
        performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            // initialize new view controller and cast it as your view controller
            var viewController = segue.destination as! DetailViewController
            // your new view controller should have property that will store passed value
            viewController.titleToPass = self.titleToPass
            viewController.compensationToPass = self.compensationToPass
            viewController.emailToPass = self.emailToPass
            viewController.organizationToPass = self.organizationToPass
            viewController.locationToPass = self.locationToPass
            viewController.durationToPass = self.durationToPass
            viewController.descriptionToPass = self.DescriptionToPass
          
        
        }
    }
    
    
    
    
    
    
    
    
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return jobPostings.count
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let post = jobPostings[indexPath.row]
//        cell.textLabel?.text = post.title
//        return cell
//    }
//
//    
//    func startObservingDatabase () {
//        databaseHandle = ref.child("Jobs").observe(.value, with: { (snapshot) in
//            var newJobs = [JobPosting]()
//            
//            for jobSnapShot in snapshot.children {
//                let job = JobPosting(snapshot: (jobSnapShot as? FIRDataSnapshot)!)
//                newJobs.append(job)
//            }
//            
//            self.jobPostings = newJobs
//            print("HELLO WORLD")
//            //print(self.jobPostings[0])
//            self.tableView.reloadData()
//            
//        })
//    }
//
//    deinit {
//        ref.child("Jobs").removeObserver(withHandle: databaseHandle)
//    }

    
     //Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        
//        return true
//    }
 

    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let job = items[indexPath.row]
//            item.ref?.removeValue()
//        }
//    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
