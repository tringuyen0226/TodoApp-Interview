//
//  ViewModelTrackable.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import Foundation

public protocol ViewModelTrackable: AnyObject {
    var loadingIndicator: ActivityIndicator { get }
    var errorTracker: ErrorTracker { get }
}
