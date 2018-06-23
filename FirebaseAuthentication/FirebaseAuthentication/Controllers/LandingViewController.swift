//
//  LandingViewController.swift
//  FirebaseAuthentication
//
//  Created by Christopher Becom on 6/16/18.
//

import UIKit

class LandingViewController: UIViewController {
    
    // MARK: Constants
    private let createAccountSegueIdentifier = "createAccountSegue"
    private let signInSegueIdentifier = "signInSegue"
    
    // MARK: Properties
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: Action Event Handlers
    
    @IBAction func createAccountButtonActionEvent(_ sender: UIButton) {
        performSegue(withIdentifier: createAccountSegueIdentifier, sender: self)
    }
    
    
    @IBAction func signInButtonActionEvent(_ sender: UIButton) {
        performSegue(withIdentifier: signInSegueIdentifier, sender: self)
    }
    
    // MARK: Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
