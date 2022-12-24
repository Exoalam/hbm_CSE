//
//  CustomTableViewCell.swift
//  Hospital Bed Management
//
//  Created by Demon on 12/23/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var loc: UILabel!
    @IBOutlet weak var hospital_name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
