//
//  SignUpViewController.swift
//  EverydayMacros
//
//  Created by Elison N Coelho on 15/11/2017.
//  Copyright © 2017 Elison Coelho. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateAccountViewController: UIViewController, UITextFieldDelegate {


    
    @IBOutlet weak var textFieldsStackView: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var nextButtonView: UIView!
    
    @IBAction func goBack(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToCreateAccountName", sender: self)
    }
    
    var bottomConstraint: NSLayoutConstraint?
    var fullName = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.alpha = 0.5
        userTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
        userTextField.becomeFirstResponder()
        activityIndicator.hidesWhenStopped = true
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

    override func viewDidAppear(_ animated: Bool) {
        activityIndicator.isHidden = true
    }
    
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBAction func signUp(_ sender: UIButton) {
        
                let email = emailTextField.text!
                let password = passwordTextField.text!
        
                disableLogInItens()
        
                    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
        
                        self.activityIndicator.isHidden = false
                        self.enableLogInItens()
                        if let error = error {
                            
                            let errorCode = AuthErrorCode(rawValue: error._code)!
                            
                            switch errorCode {
                            case .invalidEmail:
                                self.showEmptyFieldAlert(message: "email inválido")
                            case .invalidCredential:
                                self.showEmptyFieldAlert(message: "crendencial inválida")
                            case .userNotFound:
                                self.showEmptyFieldAlert(message: "usuario não encontrado")
                            case .wrongPassword:
                                self.showEmptyFieldAlert(message: "senha incorreta")
                            default:
                                self.showEmptyFieldAlert(message: "Outro Erro: \(errorCode)")
                            }
                            
                            return
                        }
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
                    }
    }
    
    func disableLogInItens () {
        textFieldsStackView.alpha = 0.2
        signUpButton.alpha = 0.2
        textFieldsStackView.isUserInteractionEnabled = false
        signUpButton.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }
    
    func enableLogInItens () {
        textFieldsStackView.alpha = 1
        signUpButton.alpha = 1
        textFieldsStackView.isUserInteractionEnabled = true
        signUpButton.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
    
    func showEmptyFieldAlert(message: String) {
        let alertController = UIAlertController(title: "Alerta", message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    var userTextFieldHasText = false
    var passwordTextFieldHasText = false
    var emailTextFieldHasText = false
    
    @IBAction func userTextFieldEditingChanged(_ sender: Any) {
        if userTextField.text != "" {
            userTextFieldHasText = true
        }else {
            userTextFieldHasText = false
            signUpButton.isEnabled = false
            signUpButton.alpha = 0.5
        }
        if userTextFieldHasText == true && passwordTextFieldHasText == true && emailTextFieldHasText == true {
            signUpButton.isEnabled = true
            signUpButton.alpha = 1.0
        }
    }
    @IBAction func passwordTextFieldEditingChanged(_ sender: Any) {
        if passwordTextField.text != "" {
            passwordTextFieldHasText = true
        }else {
            passwordTextFieldHasText = false
            signUpButton.isEnabled = false
            signUpButton.alpha = 0.5
        }
        if userTextFieldHasText == true && passwordTextFieldHasText == true && emailTextFieldHasText == true {
            signUpButton.isEnabled = true
            signUpButton.alpha = 1.0
        }
    }
    @IBAction func emailTextFieldEditingChanged(_ sender: Any) {
        if emailTextField.text != "" {
            emailTextFieldHasText = true
        }else {
            emailTextFieldHasText = false
            signUpButton.isEnabled = false
            signUpButton.alpha = 0.5
        }
        if userTextFieldHasText == true && passwordTextFieldHasText == true && emailTextFieldHasText == true {
            signUpButton.isEnabled = true
            signUpButton.alpha = 1.0
        }
    }
    
}




