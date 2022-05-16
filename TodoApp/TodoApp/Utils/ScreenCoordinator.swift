//
//  ScreenCoordinator.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

extension UINavigationController {
    func setSwipeToPop(enable: Bool) {
        interactivePopGestureRecognizer?.isEnabled = enable
    }
}

enum ScreenCoordinator {
    
    static func topViewController(_ viewController: UIViewController? = nil) -> UIViewController? {
        let keyWindow = UIWindow.key
        let vc = viewController ?? keyWindow?.rootViewController
        if let navigationController = vc as? UINavigationController {
            return topViewController(navigationController.topViewController)
        } else if let tabBarController = vc as? UITabBarController {
            return tabBarController.presentedViewController != nil ? topViewController(tabBarController.presentedViewController) : topViewController(tabBarController.selectedViewController)
            
        } else if let presentedViewController = vc?.presentedViewController {
            return topViewController(presentedViewController)
        }
        return vc
    }
    
    static var rootNavigation: UINavigationController {
        return UIWindow.key?.rootViewController as! UINavigationController
    }
    
    static func dissMissPresentedVC(isAnimated: Bool, completion: (() -> Void)? = nil) {
        rootNavigation.presentedViewController?.presentingViewController?.dismiss(animated: isAnimated, completion: completion)
    }
    
    static func goToListDevice(devices: [DeviceModel]) {
        let vc = ListDeviceViewController(viewModel: ListDeviceViewModel(devices: devices))
        rootNavigation.pushViewController(vc, animated: true)
    }
    
    static func goToListContact(contacts: [ContactModel]) {
        let vc = ListContactViewController(viewModel: ListContactViewModel(contacts: contacts))
        rootNavigation.pushViewController(vc, animated: true)
    }
    
}
