//
//  OrderViewCell.swift
//  Assignment-8
//
//  Created by AthiPathi on 4/1/23.
//

import UIKit

class OrderViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var OrderID: UILabel!
    
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var ProductName: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
