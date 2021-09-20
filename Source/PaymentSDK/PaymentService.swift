//
//  PaymentService.swift
//  PaymentSDK
//
//  Created by Aliev Yuriy on 20.09.2021.
//

import UIKit
import SafariServices

public enum PaymentServiceError: LocalizedError {
    case invalidateURL
    case invalidateUserInfo
    
    public var errorDescription: String? {
        switch self {
        case .invalidateURL:
            return "Некорректный URL"
            
        case .invalidateUserInfo:
            return "Некорректные данные"
        }
    }
}

public class PaymentService: NSObject {
    public static let shared: PaymentService = .init()
    
    public var defaultBrowser: Bool = false
    
    public func openPayment(with url: URL) throws {
        try validateURL(url)
        
        if defaultBrowser {
            openSafariBrowser(with: url)
        } else {
            openCustomBrowser(with: url)
        }
    }
    
    public func openPayment(with userInfo: [String : Any]) throws {
        let url = try urlFromUserInfo(userInfo)
        try openPayment(with: url)
    }
    
    private func openCustomBrowser(with url: URL) {
        let (presentable, input) = makePaymentModule()
        input?.configurateModule(with: url)
        UIViewController.topViewController?.present(presentable, animated: true)
    }
    
    private func openSafariBrowser(with url: URL) {
        let presentable = SFSafariViewController(url: url)
        UIViewController.topViewController?.present(presentable, animated: true)
    }
}

private
extension PaymentService {
    func makePaymentModule() -> (UIViewController, PaymentFormModuleInput?) {
        let viewController = PaymentFormViewController()
        let navigation = PaymentNavigationController(rootViewController: viewController)
        navigation.modalPresentationStyle = .fullScreen
        return (navigation, viewController)
    }
    
    func validateURL(_ url: URL) throws {
        if url.host != .hostURL {
            throw PaymentServiceError.invalidateURL
        }
    }
    
    func urlFromUserInfo(_ userInfo: [String: Any]) throws -> URL {
        guard let stringURL = userInfo[.urlKey] as? String,
              let url = URL(string: stringURL) else {
            throw PaymentServiceError.invalidateUserInfo
        }
        
        return url
    }
}

extension String {
    static var sourceKey = "source"
    static var urlKey = "webSBPayLink"
    static var hostURL = "web.sbpay.ru"
}
