//
//  ProfileCreatorViewController.swift
//  EverydayMacros
//
//  Created by Elison N Coelho on 03/12/2017.
//  Copyright © 2017 Elison Coelho. All rights reserved.
//

import UIKit
import Firebase

class SignUpDetailViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var creatingProfileStack: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var textFieldsStackView: UIStackView!
    
    @IBOutlet weak var createProfileButton: UIButton!
    
    @IBAction func ageTextFieldEditing(_ sender: UITextField) {
        
        let datePickerView: UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    var handle: AuthStateDidChangeListenerHandle?
    var user: User?
    var docRef: DocumentReference!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.user = user
                let uid = user!.uid
                self.docRef = Firestore.firestore().document("users/\(uid)")
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        creatingProfileStack.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createProfile(_ sender: UIButton) {
        disableLogInItens()
        
        guard let firstName = nameTextField.text, !firstName.isEmpty else { return }
        guard let lastName = lastNameTextField.text, !lastName.isEmpty else { return }
        guard let age = ageTextField.text, !age.isEmpty else { return }
        guard let height = heightTextField.text, !height.isEmpty else { return }
        
        let dataToSave: [String: Any] = ["firstName": firstName, "lastName": lastName, "age": age, "height": height]
        if docRef != nil {
            docRef.setData(dataToSave) { (error) in
                if let error = error {
                    print("error setting data: \(error.localizedDescription)")
                    self.enableLogInItens()
                }
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            }
        } else {
           print("error getting user reference")
        }
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        ageTextField.text = dateFormatter.string(from: sender.date)
        
    }
    
    func disableLogInItens () {
        textFieldsStackView.alpha = 0.2
        createProfileButton.alpha = 0.2
        textFieldsStackView.isUserInteractionEnabled = false
        createProfileButton.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }
    
    func enableLogInItens () {
        textFieldsStackView.alpha = 1
        createProfileButton.alpha = 1
        textFieldsStackView.isUserInteractionEnabled = true
        createProfileButton.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
    

}
