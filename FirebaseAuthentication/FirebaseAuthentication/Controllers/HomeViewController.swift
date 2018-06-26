//
//  HomeViewController.swift
//  FirebaseAuthentication
//
//  Created by Christopher Becom on 6/24/18.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    // Outlets and Properties
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var isAnonymousLabel: UILabel!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOutEvent))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let user = Auth.auth().currentUser else { return }
        idLabel.text = user.email
        isAnonymousLabel.text = String(user.isAnonymous)
        
    }
    
    // MARK: Action Event Handlers and Selectors

    @objc func signOutEvent(sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
