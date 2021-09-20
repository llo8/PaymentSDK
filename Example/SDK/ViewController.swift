//
//  ViewController.swift
//  SDK
//
//  Created by Aliev Yuriy on 20.09.2021.
//

import UIKit
import PaymentSDK

class ViewController: UIViewController {
    
    @IBOutlet var controls: [UIControl] = [] {
        didSet {
            controls.enumerated().forEach { (index, control) in
                control.tag = index
                
                control.addTarget(
                    self,
                    action: #selector(openPaymentModule(_:)),
                    for: .touchUpInside
                )
            }
        }
    }
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var actionButton: UIButton!
    
    private var service: PaymentService = .shared

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tryOpenURL() {
        guard let urlString = textField.text, let url = URL(string: urlString) else {
            openAlertViewController(with: "Невалидный URL")
            return
        }
        
        do {
            try service.openPayment(with: url)
        } catch {
            openAlertViewController(with: error.localizedDescription)
        }
    }
    
    @IBAction func openPaymentModule(_ sender: UIControl) {
        switch sender.tag {
        case 0:
            do {
                try service.openPayment(with: URL(string: "https://web.sbpay.ru?h=asHask")!)
            } catch {
                openAlertViewController(with: error.localizedDescription)
            }
        
        case 1:
            do {
                try service.openPayment(with: URL(string: "https://google.com")!)
            } catch {
                openAlertViewController(with: error.localizedDescription)
            }
            
        case 2:
            do {
                try service.openPayment(with: [
                    "source": "sbpay",
                    "webSBPayLink": "https://web.sbpay.ru?h=asHask"
                ])
            } catch {
                openAlertViewController(with: error.localizedDescription)
            }
        
        case 3:
            do {
                try service.openPayment(with: [
                    "any key": "any value"
                ])
            } catch {
                openAlertViewController(with: error.localizedDescription)
            }
            
        case 4:
            service.defaultBrowser.toggle()
        
        default:
            openAlertViewController(with: "Пример не реализован")
        }
    }
}

extension ViewController {
    func openAlertViewController(with message: String) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert
        )
        present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                alert.dismiss(animated: true)
            }
        }
    }
}
