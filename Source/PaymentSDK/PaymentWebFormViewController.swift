//
//  PaymentWebFormViewController.swift
//  PaymentSDK
//
//  Created by Aliev Yuriy on 20.09.2021.
//

import UIKit
import WebKit

protocol PaymentFormModuleInput {
    func configurateModule(with url: URL)
}

class PaymentNavigationController: UINavigationController { }

class PaymentFormViewController: UIViewController {

    // MARK: - Properties

    private lazy var webView = makeWebView()
    private lazy var progressView = makeProgressView()

    private var observer: NSObject?
    
    private var url: URL?

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        navigationItem.title = "Оплата"
        navigationItem.rightBarButtonItem = .init(
            title: "Закрыть",
            style: .done,
            target: self,
            action: #selector(closeModule)
        )
        
        if let url = url {
            webView.load(.init(url: url))
        }
    }
    
    @objc func closeModule() {
        observer = nil
        navigationController?.dismiss(animated: true)
    }
}

extension PaymentFormViewController: PaymentFormModuleInput {
    func configurateModule(with url: URL) {
        self.url = url
    }
}

// MARK: - Configuration
private extension PaymentFormViewController {
    func setupLayout() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.widthAnchor.constraint(equalTo: view.widthAnchor),
            webView.heightAnchor.constraint(equalTo: view.heightAnchor),
            webView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            webView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.topAnchor.constraint(equalTo: view.topAnchor),
            progressView.widthAnchor.constraint(equalTo: view.widthAnchor),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    func makeWebView() -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences = WKPreferences()
        webConfiguration.preferences.javaScriptEnabled = true
        webConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = true
        webConfiguration.processPool = WKProcessPool()

        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self

        observer = webView.observe(\.estimatedProgress,
                                   options: [.new],
                                   changeHandler: { [weak self] _, change in
                                    self?.progressView.progress = Float(change.newValue ?? 0)
                                   })

        return webView
    }

    func makeProgressView() -> UIProgressView {
        let progressView = UIProgressView()
        return progressView
    }
}

// MARK: - WKNavigationDelegate
extension PaymentFormViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
    }

    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
}

// MARK: - WKUIDelegate
extension PaymentFormViewController: WKUIDelegate { }
