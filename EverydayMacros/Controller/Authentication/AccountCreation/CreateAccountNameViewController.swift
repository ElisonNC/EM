//
//  NameViewController.swift
//  EverydayMacros
//
//  Created by Elison N Coelho on 11/12/2017.
//  Copyright © 2017 Elison Coelho. All rights reserved.
//

import UIKit

class CreateAccountNameViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBAction func goBack(_ sender: UIButton) {
        
      performSegue(withIdentifier: "unwindToCreateAccountHome", sender: self)
    }
    @IBOutlet weak var nextButtonView: UIView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.alpha = 0.5
        nameTextField.delegate = self
        // Do any additional setup after loading the view.
        nameTextField.becomeFirstResponder()
        addKeyboardNotifications()
        bottomConstraint = NSLayoutConstraint(item: nextButtonView, attribute: .bottom, relatedBy: .equal, toItem: view,attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraint(bottomConstraint!)
        
    }
    
    @objc func handleKeyboardNotifications(notification: NSNotification) {
        
        
        if let userInfo = notification.userInfo {
            
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                
            })
        }
    }
    
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotifications), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotifications), name: .UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func unwindToCreateAccountName(segue:UIStoryboardSegue) { }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        if nameTextField.text != "" {
            nextButton.isEnabled = true
            nextButton.alpha = 1.0
        }else {
            nextButton.isEnabled = false
            nextButton.alpha = 0.5
        }
    }
    
    
    
 
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toSignUp" {
                self.view.endEditing(true)
                if let vc = segue.destination as? CreateAccountViewController {
                    vc.fullName = nameTextField.text!
            }
        }
}
}
