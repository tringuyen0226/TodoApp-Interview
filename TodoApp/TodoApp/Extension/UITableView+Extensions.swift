//
//  UITableView+Extensions.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 17/05/2022.
//

import UIKit

public protocol Reusable {}

public extension Reusable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: Reusable {}

public extension IndexPath {
    static var zero: IndexPath {
        return IndexPath(item: 0, section: 0)
    }
}

public extension UITableView {
    func register(_ nibName: String, reuseIdentifier: String = "", bundle: Bundle?) {
        var identifier = reuseIdentifier
        if identifier.isEmpty {
            identifier = nibName
        }
        let nib = UINib(nibName: nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    func registerHeaderFooterCell(reuseIdentifier: String, bundle: Bundle?) {
        self.register(UINib(nibName: reuseIdentifier, bundle: bundle), forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
}
