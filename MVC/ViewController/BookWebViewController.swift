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
    
    deinit {
        print("deinit - NaverSearchBookWebViewController")
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
        modifyLeftBarButtonItem()
        
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
        let js = """
        var element = document.getElementById('gnb-gnb');
        if (element && element.parentNode) {
            element.parentNode.remove();
        }
        """
        webView.evaluateJavaScript(js, completionHandler: nil)
    }
    
}

#Preview {
    let vc = BookWebViewController()
    let book = BookListModel.sampleBookList()[0]
    vc.loadURL(link: book.link)
    return UINavigationController(rootViewController: vc)
}
