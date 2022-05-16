//
//  UIImage+Extensions.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import UIKit

extension UIImage {
    func templateImage() -> UIImage {
        return self.withRenderingMode(.alwaysTemplate)
    }
}

