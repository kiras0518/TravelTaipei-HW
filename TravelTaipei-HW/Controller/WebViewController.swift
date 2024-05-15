//
//  WebViewController.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/15.
//

import Foundation
import WebKit
import SnapKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var urlString: String?
    
    private let activityIndicatorUtils = ActivityIndicatorUtils()
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()
    
    private func setupView() {
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        ActivityIndicatorUtils.addActivityIndicator(to: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        if let urlString = urlString, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        ActivityIndicatorUtils.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ActivityIndicatorUtils.stopAnimating()
    }
}
