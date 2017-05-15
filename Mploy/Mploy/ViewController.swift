//
//  ViewController.swift
//  Mploy
//
//  Created by Sanjay Tamizharasu on 4/14/17.
//  Copyright © 2017 SanjayTamizharasu. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextFieldDelegate {
    
    var ref: FIRDatabaseReference!
    
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var bioField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    
    var firstNameString: String!
    
    
    @IBOutlet weak var saveAndPushButton: UIButton!
    
    @IBAction func saveAndPush(_ sender: Any) {
        let firstNameString = self.firstNameField.text
        let lastNameString = self.lastNameField.text
        let cityString = self.cityField.text
        let emailString = self.emailField.text
        let bioString = self.bioField.text
        
        let jsonObject: [String: String] = [
            "FirstName": firstNameString!,
            "LastName": lastNameString!,
            "City": cityString!,
            "Email": emailString!,
            "Bio": bioString!
        ]
        
        self.ref.child("Users").childByAutoId().setValue(jsonObject)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTextFields()
        ref = FIRDatabase.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func initializeTextFields() {
        firstNameField.delegate = self
        lastNameField.delegate = self
        cityField.delegate = self
        bioField.delegate = self
        emailField.delegate = self
    }

}

