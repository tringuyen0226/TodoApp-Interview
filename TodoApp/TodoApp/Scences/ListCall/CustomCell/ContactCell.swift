//
//  ContactCell.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 17/05/2022.
//

import UIKit

class ContactCell: UITableViewCell {
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var lblNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(model: ContactModel) {
        lblName.text = model.name
        lblNumber.text = model.number
    }
}
