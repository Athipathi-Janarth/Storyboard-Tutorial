//
//  CompanyViewCell.swift
//  Assignment-8
//
//  Created by AthiPathi on 3/31/23.
//

import UIKit

class CompanyViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var companyID: UILabel!
    @IBOutlet weak var CompanyName: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
