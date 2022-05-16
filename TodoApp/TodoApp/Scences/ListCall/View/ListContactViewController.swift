//
//  ListContactViewController.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 17/05/2022.
//

import UIKit
import RxCocoa
import RxSwift

class ListContactViewController: RxBaseViewController<ListContactViewModel> {
    
    @IBOutlet private weak var contactTableView: UITableView!
    
    override var hiddenNavigationBar: Bool { false }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        bindingData()
    }
    
    override func setUpUI() {
        setTitle(title: "Call List")
        contactTableView.register(ContactCell.reuseIdentifier, bundle: nil)
        contactTableView.rowHeight = 150
    }
    
    private func bindingData() {
        let input = Input()
        let output = viewModel.transform(input: input)
        
        output.loadingIndicator.drive(rx.isLoading).disposed(by: disposeBag)
        output.listContactOutput
            .drive(contactTableView.rx.items(cellIdentifier: ContactCell.reuseIdentifier,
                                             cellType: ContactCell.self))
        { _, contact, cell in
            cell.bindData(model: contact)
        }.disposed(by: disposeBag)
    }
}
