//
//  HomeViewController.swift
//  EverydayMacros
//
//  Created by Elison N Coelho on 12/11/2017.
//  Copyright © 2017 Elison Coelho. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil{
                 self.performSegue(withIdentifier: "presentAuthentication", sender: self)
            }else{
                
            }
            
        }
    }
    
    
    var handle: AuthStateDidChangeListenerHandle?
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setTitleDisplay(_ user: User?) {
        if let name = user?.displayName {
            self.navigationItem.title = "Welcome \(name)"
        } else {
            self.navigationItem.title = "Authentication Example"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       // Auth.auth().removeStateDidChangeListener(handle!)
    }
}
