//
//  AlertHelper.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import UIKit

class AlertHelpers {
    static let shareIntanse = AlertHelpers()
    private init() {}
    
    func showAlert(alert: UIViewController, isForceShowing: Bool = true, animated: Bool = true) {
        if ScreenCoordinator.topViewController()?.presentedViewController != nil {
            if isForceShowing {
                ScreenCoordinator.topViewController()?.dismiss(animated: false, completion: {
                    ScreenCoordinator.topViewController()?.present(alert, animated: animated, completion: nil)
                })
            }
        } else {
            ScreenCoordinator.topViewController()?.present(alert, animated: animated, completion: nil)
        }
    }
    
    func showInformAlertWith(isForceShowing:Bool = true,
                             title: String? = nil,
                             msg: String,
                             confirmButtonTitle: String? = nil,
                             titleColor: UIColor = UIColor.black,
                             msgColor: UIColor = UIColor.black,
                             btnColor: UIColor = UIColor.black,
                             handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert )
        
        let attributeTitle = NSAttributedString(string: title.orEmpty,
                                                attributes: [NSAttributedString.Key.foregroundColor: titleColor,
                                                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        alert.setValue(attributeTitle, forKey: "attributedTitle")
        
        let attributeMsg = NSAttributedString(string: msg,
                                              attributes: [NSAttributedString.Key.foregroundColor: msgColor,
                                                           NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        alert.setValue(attributeMsg, forKey: "attributedMessage")
        
        let action = UIAlertAction(title: "OK", style: .default, handler: handler)
        action.setValue(btnColor, forKey: "titleTextColor")
        alert.addAction(action)
        showAlert(alert: alert)
    }
}
