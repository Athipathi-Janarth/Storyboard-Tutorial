//
//  PostViewCell.swift
//  Assignment-8
//
//  Created by AthiPathi on 4/1/23.
//

import UIKit

class PostViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var PostID: UILabel!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var ProductType: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
