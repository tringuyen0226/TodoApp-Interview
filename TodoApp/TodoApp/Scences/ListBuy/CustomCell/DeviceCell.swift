//
//  DeviceCell.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 17/05/2022.
//

import UIKit

class DeviceCell: UITableViewCell {

    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var lblPrice: UILabel!
    @IBOutlet private weak var lblQuantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(model: DeviceModel) {
        lblName.text = model.name
        lblPrice.text = "\(model.price ?? 0)"
        lblQuantity.text = "\(model.quantity ?? 0)"
    }
}
