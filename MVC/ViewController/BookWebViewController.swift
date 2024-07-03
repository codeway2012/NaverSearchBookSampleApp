//
//  NaverSearchBookWebViewController.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/20/24.
//

import UIKit
import WebKit

// MARK: - Declaration
class BookWebViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - UI Component
    
    var webView: WKWebView!
    weak var detailDelegate: BookDetailDelegate?

    deinit {
        print("deinit - BookWebViewController")
    }
    
}

// MARK: - UI Setting
extension BookWebViewController {
    
    // MARK: - LifeCycle
    
    override func loadView() {
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        webView.navigationDelegate = self
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Book WebView"
        view.backgroundColor = .systemBackground
        setupLeftBarButtonItem()
    }
    
    // MARK: - load
    
    func loadURL(link: String) {
        _ = view
        if let url = URL(string: link) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

// MARK: - Delegate
extension BookWebViewController {

    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let js = "document.getElementById('gnb-gnb').remove()"
        webView.evaluateJavaScript(js) { _, error in
            guard error == nil else { return }
            self.detailDelegate?.enabledRightBarButtonItem()
        }
    }
}

#Preview {
    let vc = BookWebViewController()
    let book = BookListModel.sampleBookList()[0]
    vc.loadURL(link: book.link)
    return UINavigationController(rootViewController: vc)
}
