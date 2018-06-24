//
//  SignInViewController.swift
//  FirebaseAuthentication
//
//  Created by Christopher Becom on 6/23/18.
//

import UIKit

class SignInViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: StandardButton!
    
    // MARK: Constants
    
    private let navTitle = "Sign In"
    private let homeSegueIdentifier = "homeSegue"
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = navTitle
    }
    
    // MARK: Action Event Handlers
    
    @IBAction func signInButtonActionEvent(_ sender: UIButton) {
        attemptSignIn()
    }
    
    // MARK: Update
    
    private func attemptSignIn() {
        performSegue(withIdentifier: homeSegueIdentifier, sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        title = nil
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
