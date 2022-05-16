//
//  ListDeviceViewController.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 17/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class ListDeviceViewController: RxBaseViewController<ListDeviceViewModel> {
    
    @IBOutlet private weak var deviceTableView: UITableView!
    
    override var hiddenNavigationBar: Bool { false }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindingData()
    }
    
    override func setUpUI() {
        setTitle(title: "Buy List")
        deviceTableView.register(DeviceCell.reuseIdentifier, bundle: nil)
        deviceTableView.rowHeight = 100
        deviceTableView.tableFooterView = UIView()
    }
    
    private func bindingData() {
        let input = Input()
        let output = viewModel.transform(input: input)
        
        output.listDeviceOutput
            .drive(deviceTableView.rx.items(cellIdentifier: DeviceCell.reuseIdentifier,
                                            cellType: DeviceCell.self))
        { _, device, cell in
            cell.bindData(model: device)
        }.disposed(by: disposeBag)
    }
}
