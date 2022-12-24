//
//  FinderViewController.swift
//  Hospital Bed Management
//
//  Created by Ahsan Habib on 11/14/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class FinderViewController: UIViewController {

   
    @IBOutlet weak var Gbed: UILabel!
    @IBOutlet weak var ICU: UILabel!
    @IBOutlet weak var Hospital_name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // getData()
        // Do any additional setup after loading the view.
    }
  
    func getData() -> Void{
        
        let db  = Database.database().reference().child("provider")
    
        db.observeSingleEvent(of: .value) { snapshot in
            for case let child as DataSnapshot in snapshot.children {
                guard let dict = child.value as? [String:Any] else {
                    print("Error")
                    return
                }
                let name = dict["name"] as Any
                let icuBed = dict["icuBed"] as Any
                
            
            
        
                
                print(name)
                print(icuBed)
            }
        }
        
    }

 

}
