//
//  DetailViewController.swift
//  Mploy
//
//  Created by Sanjay Tamizharasu on 4/15/17.
//  Copyright © 2017 SanjayTamizharasu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var titleToPass: String!
    var compensationToPass: String!
    var emailToPass: String!
    var organizationToPass: String!
    var locationToPass: String!
    var durationToPass: String!
    var descriptionToPass: String!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var compensation: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UILabel!
    @IBOutlet weak var descriptionBox: UITextView!
   
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.titleLabel.text = self.titleToPass
        //self.compensation.text = self.compensationToPass
        self.locationLabel.text = self.locationToPass
        self.organizationLabel.text = self.organizationToPass
        self.phoneNoLabel.text = self.emailToPass
        self.descriptionLabel.text = self.compensationToPass
        self.descriptionBox.text = self.descriptionToPass
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
