//
//  CreateAccountViewController.swift
//  FirebaseAuthentication
//
//  Created by Christopher Becom on 6/23/18.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {
    
    // MARK: Constants
    
    private let navTitle = "Create New Account"
    private let homeSegueIdentifier = "homeSegue"
    private enum textFieldTag: Int {
        case emailTextFieldTag = 10
        case passwordTextFieldTag = 20
    }

    // MARK: Outlets and Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createAccountButton: StandardButton!
    @IBOutlet weak var stackViewYCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupTextFields()
        setupKeyboardObservers()
        disableServiceActivities()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    // MARK: Setup
    
    private func setupView() {
        title = navTitle
    }
    
    private func setupTextFields() {
        
        emailTextField.tag = textFieldTag.emailTextFieldTag.rawValue
        emailTextField.delegate = self
        passwordTextField.tag = textFieldTag.passwordTextFieldTag.rawValue
        passwordTextField.delegate = self
        
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(CreateAccountViewController.keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CreateAccountViewController.keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: Update
    
    private func validateTextFields() -> Bool {
        
        guard let email = emailTextField.text else { return false }
        if !email.isValidEmail() {
            return false
        }
            
        guard let password = passwordTextField.text else { return false }
        if password.count > 0 {
            return true
        }
        return false
    }
    
    private func disableCreateAccountButton() {
        createAccountButton.alpha = 0.25
        createAccountButton.isUserInteractionEnabled = false
    }
    
    private func enableCreateAccountButton() {
        createAccountButton.alpha = 1.0
        createAccountButton.isUserInteractionEnabled = true
    }

    private func disableServiceActivities() {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
    private func enableServiceActivities() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    // MARK: Action Event Handlers and Observers
    
    @IBAction func createAccountButtonActionEvent(_ sender: UIButton) {

        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        enableServiceActivities()
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            self.disableServiceActivities()
            guard let email = authResult?.user.email, error == nil else {
                print("error: \(error!.localizedDescription)")
//                self.showMessagePrompt(error!.localizedDescription)
                return
            }
            print("email: \(email)")
            self.transitionToHomeViewController()
        }
        
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        view.layoutIfNeeded()
        self.stackViewYCenterConstraint.constant = -40
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [], animations: { [weak self] in
            self?.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        view.layoutIfNeeded()
        self.stackViewYCenterConstraint.constant = 0
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [], animations: { [weak self] in
            self?.view.layoutIfNeeded()
        })
    }
    
    // MARK: - Navigation

    private func transitionToHomeViewController() {
        performSegue(withIdentifier: homeSegueIdentifier, sender: self)
    }
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}

extension CreateAccountViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if validateTextFields() {
            enableCreateAccountButton()
        } else {
            disableCreateAccountButton()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == textFieldTag.emailTextFieldTag.rawValue {
            passwordTextField.becomeFirstResponder()
        } else {
            if validateTextFields() {
                enableCreateAccountButton()
            } else {
                disableCreateAccountButton()
            }
            view.endEditing(true)
        }
        return true
    }
    
}
