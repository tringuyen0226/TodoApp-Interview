//
//  ViewModelTransformable.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import UIKit

public protocol ViewModelTransformable: AnyObject {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
