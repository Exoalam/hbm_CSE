//
//  SplashScreenController.swift
//  Hospital Bed Management
//
//  Created by Ahsan Habib on 11/12/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SplashScreenController: UIViewController {

    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        checkUser()
       
    }
    
 func checkUser()
    {
        if Auth.auth().currentUser != nil{
            
            if Auth.auth().currentUser?.uid.isEmpty == true
            {
                //print("hello")
            }
            else
            {
                print(Auth.auth().currentUser!.uid)
            }
            let ref = db.collection("USER").document(Auth.auth().currentUser!.uid)
            
            ref.getDocument { snapshot, error in
                
                guard let data = snapshot?.data(), error == nil else {
                    
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
                    
                    return
                }
                
                guard let type = data["userType"] as? String else {
                    return
                }
                
                if(type == "finder")
                {
                   
                    //                                let storyboard = UIStoryboard(name:"Main", bundle: nil)
                    //                                let vc = storyboard.instantiateViewController(withIdentifier: "finder")
                    //                                vc.modalPresentationStyle = .overFullScreen
                    //                                self.present(vc, animated: true)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3){
                        self.performSegue(withIdentifier: "splash_to_finder", sender: nil)
                        
                    }
                    
                }
                else if(type == "provider")
                {
              
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3){
                        self.performSegue(withIdentifier: "splash_to_provider", sender: nil)
                        
                    }
                }
            

                
            }
            
            
        }
        if Auth.auth().currentUser == nil
         {
         
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3){
                self.performSegue(withIdentifier: "Splash_to_Login", sender: nil)
            }
        }
        
    }
 

}
