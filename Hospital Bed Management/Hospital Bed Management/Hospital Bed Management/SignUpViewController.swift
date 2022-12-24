//
//  SignUpViewController.swift
//  Hospital Bed Management
//
//  Created by Ahsan Habib on 11/12/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    
    @IBOutlet weak var generalBed: UITextField!
    @IBOutlet weak var icuBed: UITextField!
    let database = Firestore.firestore()
    var userType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)        // Do any additional setup after loading the view.
    }
    @IBAction func type(_ sender: UISegmentedControl) {
        
        if(sender.selectedSegmentIndex == 1)
        {
            userType = ""
            generalBed.isHidden = true
            icuBed.isHidden = true
            userType += "finder"
        }
        if(sender.selectedSegmentIndex == 2)
        {
            userType = ""
            generalBed.isHidden = false
            icuBed.isHidden = false
            userType += "provider"
            
        }
        
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        if name.text?.isEmpty == true
        {
            alert("No text in name field")
            
        }
        if email.text?.isEmpty == true
        {
            alert("No text in email field")
            
        }
        if mobile.text?.isEmpty == true
        {
            alert("No text in mobile field")
            
        }
        if password.text?.isEmpty == true
        {
            alert("No text in password field")
        }
        if confirmPass.text?.isEmpty == true
        {
            alert("No text in confirm pass field")
        }
        if(password.text != confirmPass.text)
        {
            alert("Password not matched")
        }
        if(icuBed.text?.isEmpty == true && userType == "provider")
        {
            alert("ICU bed is empty")
        }
        if(generalBed.text?.isEmpty == true && userType == "provider")
        {
            alert("General bed is empty")
        }
        if(userType.isEmpty == true)
        {
            alert("Select user type")
//            let alert = UIAlertController(title: "Error", message: "Select user type", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default ))
//            self.present(alert, animated: true)
//            return
        }
        signUp()
    }
    
    func signUp()
    {
        print("hello")
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                print("Error\(error?.localizedDescription)")
                return
            }
            self.saveData()
            
            if(self.userType == "finder")
            {
                let storyboard = UIStoryboard(name:"Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "finder")
                print("FinderView")
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
            if(self.userType == "provider")
            {
                let storyboard = UIStoryboard(name:"Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "provider")
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
            
           
            
        }
    }
    func alert(_ msg:String)
    {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default ))
        self.present(alert, animated: true)
        return
    }
    
    func saveData()
    {
        let ref = database.collection("USER").document(Auth.auth().currentUser!.uid)
        
        var ref2: DatabaseReference!

        ref2 = Database.database().reference()
        
        if(userType == "provider")
        {
            ref.setData([
                "name":name.text!,
                "email":email.text!,
                "mobile":mobile.text!,
                "userType":userType,
                "icuBed":icuBed.text!,
                "generalBed":generalBed.text!
            ], merge: true)
            
            ref2.child(userType).child(Auth.auth().currentUser!.uid).setValue([
                "name":name.text!,
                "email":email.text!,
                "mobile":mobile.text!,
                "userType":userType,
                "bookedIcuBed": "0",
                "icuBed":icuBed.text!,
                "bookedGeneralBed": "0",
                "generalBed":generalBed.text!
            ])
        }
        if userType == "finder"
        {
            ref.setData([
                "name":name.text!,
                "email":email.text!,
                "mobile":mobile.text!,
                "userType":userType
            ], merge: true)
            
            ref2.child(userType).child(Auth.auth().currentUser!.uid).setValue([
                "name":name.text!,
                "email":email.text!,
                "mobile":mobile.text!,
                "userType":userType
            ])
        }
       
       
      

    }
    

}
