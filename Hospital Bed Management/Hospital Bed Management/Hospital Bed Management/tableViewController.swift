//
//  tableViewController.swift
//  Hospital Bed Management
//
//  Created by Demon on 12/23/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class tableViewController: UIViewController {
    struct Hospital{
        let name: String
        let icuBed: String
        let generalBed: String
        let mobile_number: String
        let address: String
    }
    
    var data = [Hospital]()
    @IBOutlet weak var search_loc: UITextField!
    @IBOutlet weak var table_data: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
    }
    
    @IBAction func search(_ sender: Any) {
        data.removeAll()
        self.table_data.reloadData()
        searchData()
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
                    let mobile = dataObject?["mobile"]
                    let location = dataObject?["location"]
                    
                    let x1 = Int(icuBed as! String)
                    let x2 = Int(bookedIcuBed as! String)
                    let y1 = x1! - x2!
                    let x3 = Int(generalBed as! String)
                    let x4 = Int(bookedGeneralBed as! String)
                    let y2 = x3! - x4!
                    
                    let hospital = Hospital(name: name as! String, icuBed: "ICU Bed: \(y1)", generalBed: "General Bed: \(y2)", mobile_number: mobile as! String, address: location as! String)
                    self.data.append(hospital)
                    
                }
                self.table_data.reloadData()
                
            }
        })
        
    }
    func searchData()
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
                    let mobile = dataObject?["mobile"]
                    let location = dataObject?["location"]
                    
                    let x1 = Int(icuBed as! String)
                    let x2 = Int(bookedIcuBed as! String)
                    let y1 = x1! - x2!
                    let x3 = Int(generalBed as! String)
                    let x4 = Int(bookedGeneralBed as! String)
                    let y2 = x3! - x4!
                    if location as! String == self.search_loc.text! {
                        let hospital = Hospital(name: name as! String, icuBed: "ICU Bed: \(y1)", generalBed: "General Bed: \(y2)", mobile_number: mobile as! String, address: location as! String)
                        self.data.append(hospital)}
                    
                }
                self.table_data.reloadData()
                
            }
        })
        
    }
}

extension tableViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController{
            let hospital = data[indexPath.row]
            vc.hos_name = hospital.name
            vc.icu = hospital.icuBed
            vc.gbed = hospital.generalBed
            vc.mobile = hospital.mobile_number
            self.navigationController?.pushViewController(vc, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)        }
    }
    
}

extension tableViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customtableviewcell", for: indexPath) as! CustomTableViewCell
        cell.hospital_name.text = data[indexPath.row].name
        cell.loc.text = data[indexPath.row].address
        return cell
    }
    
}
