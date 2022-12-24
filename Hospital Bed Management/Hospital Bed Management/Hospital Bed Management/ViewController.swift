//
//  ViewController.swift
//  Hospital Bed Management
//
//  Created by Ahsan Habib on 11/12/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
 
    @IBOutlet weak var table: UITableView!
    
   
    
    struct Hospital{
        let name: String
        let icuBed: String
        let generalBed: String

    }
    
    var data = [Hospital]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        self.table.allowsSelection = true
        getData()
    }
    	
    func getData()
    {
        let db  = Database.database().reference().child("provider")
       
        db.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.data.removeAll()
                
                for d in snapshot.children.allObjects as![DataSnapshot]{
                    let dataObject = d.value as? [String: AnyObject]
                    
                    let name = dataObject?["name"]
                    let icuBed = dataObject?["icuBed"]
                    let bookedIcuBed = dataObject?["bookedIcuBed"]
                    let generalBed = dataObject?["generalBed"]
                    let bookedGeneralBed = dataObject?["bookedGeneralBed"]
                    
                    let x1 = Int(icuBed as! String)
                    let x2 = Int(bookedIcuBed as! String)
                    let y1 = x1! - x2!
                    let x3 = Int(generalBed as! String)
                    let x4 = Int(bookedGeneralBed as! String)
                    let y2 = x3! - x4!
                    
                    let hospital = Hospital(name: name as! String, icuBed: "ICU Bed: \(y1)", generalBed: "General Bed: \(y2)")
                    self.data.append(hospital)
                    
                }
                self.table.reloadData()
                
            }
        })
        
            
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let hospital = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "finderCell", for: indexPath) as! FinderHomeTableViewCell
        cell.hospitalName.text = hospital.name
        cell.icuBedNo.text = hospital.icuBed
        cell.generalBedNo.text = hospital.generalBed
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "finderView") as? FinderViewController{
            let hospital = data[indexPath.row]
            vc.Hospital_name.text = hospital.name
            vc.ICU.text = hospital.icuBed
            vc.ICU.text = hospital.generalBed
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBAction func signOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        
        do {
            let storyboard = UIStoryboard(name:"Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "login")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
            
            print("Sign OUt")
            
          try firebaseAuth.signOut()
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
      
    }
    
}

