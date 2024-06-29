//
//  NaverSearchBookWebViewController.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/20/24.
//

import UIKit
import WebKit

// MARK: - Declaration
class NaverSearchBookWebViewController: UIViewController, WKUIDelegate {
    
    // MARK: - UI Component
    
    var webView: WKWebView!
    
    deinit {
        print("deinit - NaverSearchBookWebViewController")
    }
    
}

// MARK: - UI Setting
extension NaverSearchBookWebViewController {
    
    // MARK: - LifeCycle
    
    override func loadView() {
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        webView.uiDelegate = self
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Book WebView"
        view.backgroundColor = .systemBackground
        modifyLeftBarButtonItem()
    }
    
    // MARK: -
    
    func loadURL(link: String) {
        _ = view
        if let url = URL(string: link) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
}

#Preview {
    let vc = NaverSearchBookWebViewController()
    let book = NaverSearchBookListModel.sampleBookList()[0]
    vc.loadURL(link: book.link)
    return UINavigationController(rootViewController: vc)
}
