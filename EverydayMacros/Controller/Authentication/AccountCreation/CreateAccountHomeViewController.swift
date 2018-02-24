//
//  AuthenticationHomeViewController.swift
//  EverydayMacros
//
//  Created by Elison N Coelho on 15/11/2017.
//  Copyright © 2017 Elison Coelho. All rights reserved.
//

import UIKit

class CreateAccountHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToCreateAccountHome(segue:UIStoryboardSegue) { }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.navigationController?.isNavigationBarHidden == false {
           self.navigationController?.isNavigationBarHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
