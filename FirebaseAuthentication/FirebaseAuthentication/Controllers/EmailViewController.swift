//
//  EmailViewController.swift
//  FirebaseAuthentication
//
//  Created by Christopher Becom on 6/20/18.
//

import UIKit
import Firebase

class EmailViewController: UIViewController {

    // MARK: Properties
    
    /** The handler for the auth state listener, to allow cancelling later. */
    var handle: AuthStateDidChangeListenerHandle?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
        
        //        Auth.auth().removeStateDidChangeListener(handle!)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Private
    

}
