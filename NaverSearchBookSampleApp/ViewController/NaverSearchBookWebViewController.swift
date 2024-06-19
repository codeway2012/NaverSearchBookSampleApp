//
//  NaverSearchBookWebViewController.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/20/24.
//

import UIKit
import WebKit

class NaverSearchBookWebViewController: UIViewController {

	// MARK: - UI Component
	
	var webView: WKWebView!
	
	// MARK: - Properties
	
	let model: NaverSearchBookModel

	// MARK: - Init
	
	init(model: NaverSearchBookModel) {
		self.model = model
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
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
	
	// MARK: - setupUI
	
	func setupUI() {
		// URL 로드
		if let urlString = model.book?.link,
		   let url = URL(string: urlString) {
			let request = URLRequest(url: url)
			webView.load(request)
		}
	}
	
}
