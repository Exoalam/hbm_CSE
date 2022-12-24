//
//  LoginViewController.swift
//  Hospital Bed Management
//
//  Created by Ahsan Habib on 11/12/22.
//:)

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        validateFields()
        
    }
    
    @IBAction func forgotBtn(_ sender: Any) {
    }
   func validateFields()
    {
        if email.text?.isEmpty == true{
            alert("No email text")
        }
        if password.text?.isEmpty == true{
            alert("No password text")
        }
        login()
    }
    func login()
    {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self]authResult, err in
            guard let strongSelf = self else {return}
            
            if let err = err {
                print(err.localizedDescription)
            }
            self!.checkUser()
            
        }
    }
    func alert(_ msg:String)
    {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default ))
        self.present(alert, animated: true)
        return
    }
    
    func checkUser()
    {
        if Auth.auth().currentUser?.uid != nil{

            let ref = db.collection("USER").document(Auth.auth().currentUser!.uid)
            
            ref.getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                
                guard let type = data["userType"] as? String else {
                    return
                }
                
                if(type == "finder")
                {
                    
                                let storyboard = UIStoryboard(name:"Main", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "finder")
                                vc.modalPresentationStyle = .overFullScreen
                                self.present(vc, animated: true)
                    
                }
                if(type == "provider")
                {
                    
                                let storyboard = UIStoryboard(name:"Main", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "provider")
                                vc.modalPresentationStyle = .overFullScreen
                                self.present(vc, animated: true)
                    
                }
                
            }
            
        }
    }

}
