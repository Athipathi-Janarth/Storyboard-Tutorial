//
//  TypeViewCell.swift
//  Assignment-8
//
//  Created by AthiPathi on 3/30/23.
//

import UIKit

class TypeViewCell: UITableViewCell {
    
    @IBOutlet weak var typeName: UILabel!
    
    @IBOutlet weak var typeID: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
