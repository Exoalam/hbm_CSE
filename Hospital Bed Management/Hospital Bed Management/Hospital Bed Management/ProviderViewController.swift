//
//  ProviderViewController.swift
//  Hospital Bed Management
//
//  Created by Ahsan Habib on 11/13/22.
//

import UIKit
import FirebaseAuth

class ProviderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        
        do {
          try firebaseAuth.signOut()
            
            let storyboard = UIStoryboard(name:"Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "login")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    

}
