//
//  ProductCellViewCell.swift
//  Assignment-8
//
//  Created by AthiPathi on 3/31/23.
//

import UIKit

class ProductViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var ID: UILabel!
    @IBOutlet weak var Rating: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
