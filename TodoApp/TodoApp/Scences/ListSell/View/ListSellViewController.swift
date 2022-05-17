//
//  ListSellViewController.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 17/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ListSellViewController: RxBaseViewController<ListSellViewModel> {
    
    @IBOutlet private weak var deviceTableView: UITableView!
    
    override var hiddenNavigationBar: Bool { false }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        bindingData()
    }
    
    override func setUpUI() {
        setTitle(title: "Sell List")
        deviceTableView.register(DeviceCell.reuseIdentifier, bundle: nil)
        deviceTableView.rowHeight = 150
    }
    
    private func bindingData() {
        let input = Input()
        let output = viewModel.transform(input: input)
        
        output.listDeviceOutput.drive(deviceTableView.rx.items(cellIdentifier: DeviceCell.reuseIdentifier,
                                                               cellType: DeviceCell.self))
        { _, model, cell in
            cell.bindData(model: model)
        }.disposed(by: disposeBag)
    }
}
