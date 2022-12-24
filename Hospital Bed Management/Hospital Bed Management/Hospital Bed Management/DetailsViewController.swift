//
//  DetailsViewController.swift
//  Hospital Bed Management
//
//  Created by Demon on 12/23/22.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var mobile_number: UILabel!
    @IBOutlet weak var gbed_number: UILabel!
    @IBOutlet weak var icu_number: UILabel!
    @IBOutlet weak var hospital_name: UILabel!
    var hos_name = ""
    var icu = ""
    var gbed = ""
    var mobile = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        hospital_name.text = hos_name
        icu_number.text = icu
        gbed_number.text = gbed
        mobile_number.text = mobile
    }
    



}
