//
//  UIViewController.swift
//  PaymentSDK
//
//  Created by Aliev Yuriy on 20.09.2021.
//

import UIKit

extension UIViewController {
    static var topViewController: UIViewController? {
        return topViewController()
    }

    var topViewController: UIViewController? {
        return UIViewController.topViewController(from: self)
    }

    private static func topViewController(from controller: UIViewController? = nil) -> UIViewController? {
        let viewController = controller ?? UIApplication.shared.keyWindow?.rootViewController

        if let navigationController = viewController as? UINavigationController {
            return topViewController(from: navigationController.visibleViewController)
        } else if let tabBarController = viewController as? UITabBarController {
            return topViewController(from: tabBarController.selectedViewController)
        } else if let presentedController = viewController?.presentedViewController {
            return topViewController(from: presentedController)
        } else {
            return viewController
        }
    }
}
