//
//  SignInViewController.swift
//  FirebaseAuthentication
//
//  Created by Christopher Becom on 6/23/18.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    // MARK: Constants
    
    private let navTitle = "Sign In"
    private let homeSegueIdentifier = "homeSegue"
    private enum textFieldTag: Int {
        case emailTextFieldTag = 10
        case passwordTextFieldTag = 20
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: StandardButton!
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
    
    // MARK: Setup
    
    private func setupView() {
        
        title = navTitle
        guard let user = Auth.auth().currentUser, let email = user.email else { return }
        emailTextField.text = email
        do {
            let credentials = try KeychainService.fetchPasswordForAccount(account: email)
            passwordTextField.text = credentials.password
            enableSignInButton()
        } catch let error {
            presentAlert(withTitle: "Keychain Error", andMessage: error.localizedDescription)
        }
        
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
    
    private func validateEmail() -> Bool {
        guard let email = emailTextField.text else { return false }
        return email.isValidEmail()
    }
    
    private func validatePassword() -> Bool {
        guard let password = passwordTextField.text else { return false }
        return password.isValidPassword()
    }
    
    private func validateTextFields() -> Bool {
        return validateEmail() && validatePassword()
    }
    
    private func disableSignInButton() {
        signInButton.alpha = 0.25
        signInButton.isUserInteractionEnabled = false
    }
    
    private func enableSignInButton() {
        signInButton.alpha = 1.0
        signInButton.isUserInteractionEnabled = true
    }
    
    private func disableServiceActivities() {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
    private func enableServiceActivities() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    private func attemptSignIn() {
        
         guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
         enableServiceActivities()
         Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in

            self?.disableServiceActivities()
            if let error = error {
                self?.presentAlert(withTitle: "Firebase Error", andMessage: error.localizedDescription)
                return
            }
            self?.transitionToHomeViewController()
            
         }
    }
    
    private func presentAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Action Event Handlers and Observers
    
    @IBAction func signInButtonActionEvent(_ sender: UIButton) {
        attemptSignIn()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        title = nil
    }

}

extension SignInViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if validateTextFields() {
            enableSignInButton()
        } else {
            disableSignInButton()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == textFieldTag.emailTextFieldTag.rawValue {
            passwordTextField.becomeFirstResponder()
        } else {
            if validateTextFields() {
                enableSignInButton()
            } else {
                disableSignInButton()
            }
            view.endEditing(true)
        }
        return true
    }
    
}
