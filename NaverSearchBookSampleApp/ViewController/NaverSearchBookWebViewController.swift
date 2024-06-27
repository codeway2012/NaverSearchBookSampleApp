//
//  NaverSearchBookWebViewController.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/20/24.
//

import UIKit
import WebKit

// MARK: - Declaration
class NaverSearchBookWebViewController: UIViewController {
    
    // MARK: - UI Component
    
    var webView: WKWebView!
    
    // MARK: - Properties
    
    let detailViewModel: NaverSearchBookDetailViewModel
    
    // MARK: - Init
    
    init(detailViewModel: NaverSearchBookDetailViewModel) {
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit - NaverSearchBookWebViewController")
    }
    
}

// MARK: - UI Setting
extension NaverSearchBookWebViewController {
    
    // MARK: - LifeCycle
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Book WebView"
        view.backgroundColor = .systemBackground
        modifyLeftBarButtonItem()
        
        setupUI()
    }
    
    // MARK: -
    func setupUI() {
        // URL 로드
        if let urlString = detailViewModel.book?.link,
           let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

#Preview {
    let detailViewModel = NaverSearchBookDetailViewModel()
    detailViewModel.book = NaverSearchBookListViewModel.sampleBookList()[0]
    return UINavigationController(rootViewController: NaverSearchBookWebViewController(detailViewModel: detailViewModel))
}
