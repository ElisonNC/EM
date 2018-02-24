//
//  LogInViewController.swift
//  EverydayMacros
//
//  Created by Elison N Coelho on 15/11/2017.
//  Copyright © 2017 Elison Coelho. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController, UITextFieldDelegate {

    var bottomConstraint: NSLayoutConstraint?
    
    @IBOutlet weak var nextButtonView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        logInButton.alpha = 0.5
        activityIndicator.hidesWhenStopped = true
        addKeyboardNotifications()
        bottomConstraint = NSLayoutConstraint(item: nextButtonView, attribute: .bottom, relatedBy: .equal, toItem: view,attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraint(bottomConstraint!)
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var textFieldsStackView: UIStackView!
    @IBOutlet weak var logInButton: UIButton!
    
    @IBAction func logIn(_ sender: UIButton) {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        disableLogInItens()
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
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
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: UIButton) {
                performSegue(withIdentifier: "unwindToAuthHome", sender: self)
    }
    
    func showEmptyFieldAlert(message: String) {
        let alertController = UIAlertController(title: "Alerta", message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func disableLogInItens () {
        textFieldsStackView.alpha = 0.2
        logInButton.alpha = 0.2
        textFieldsStackView.isUserInteractionEnabled = false
        logInButton.isEnabled = false
        activityIndicator.startAnimating()
    }
    
    func enableLogInItens () {
        textFieldsStackView.alpha = 1
        logInButton.alpha = 1
        textFieldsStackView.isUserInteractionEnabled = true
        logInButton.isEnabled = true
        activityIndicator.stopAnimating()
    }
    
    var passwordTextFieldHasText = false
    var emailTextFieldHasText = false
    
    
    @IBAction func emailTextFieldEditingChanged(_ sender: Any) {
    
    
        if emailTextField.text != "" {
            emailTextFieldHasText = true
        }else {
            emailTextFieldHasText = false
            logInButton.isEnabled = false
            logInButton.alpha = 0.5
        }
        if  passwordTextFieldHasText == true && emailTextFieldHasText == true {
            logInButton.isEnabled = true
            logInButton.alpha = 1.0
        }
    }


    @IBAction func passwordTextFieldEditingChanged(_ sender: Any) {
    
    if passwordTextField.text != "" {
            passwordTextFieldHasText = true
        }else {
            passwordTextFieldHasText = false
            logInButton.isEnabled = false
            logInButton.alpha = 0.5
        }
        if passwordTextFieldHasText == true && emailTextFieldHasText == true {
            logInButton.isEnabled = true
            logInButton.alpha = 1.0
        }
    }

}
