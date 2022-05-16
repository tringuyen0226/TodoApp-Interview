//
//  ToasView.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import UIKit

typealias CallBackClosure = () -> Void

class Toast {
    enum ToastType {
        case success
        case failure
    }
    
    enum Alignment {
        case center, bottom
    }
    
    static func showCenter(message: String,
                           font: UIFont? = UIFont.systemFont(ofSize: 12, weight: .regular),
                           timeDuration: TimeInterval = 1.5,
                           topBottomInset: CGFloat = 8,
                           backgroundColor: UIColor = .lightGray,
                           completion: CallBackClosure? = nil) {
        guard let keyWindow = UIWindow.key else { return }
        
        let toastContainer = UIView(frame: CGRect())
        toastContainer.backgroundColor = backgroundColor
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 3
        toastContainer.clipsToBounds  =  true
        
        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = font
        toastLabel.text = message
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        toastContainer.addSubview(toastLabel)
        keyWindow.addSubview(toastContainer)
        
        toastLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(35)
            make.top.bottom.equalToSuperview().inset(topBottomInset)
        }
        
        toastContainer.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().inset(32)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, delay: timeDuration, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
                completion?()
            })
        })
    }
}
