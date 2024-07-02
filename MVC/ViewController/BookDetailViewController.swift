//
//  NaverSearchBookDetailViewController.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/19/24.
//

import UIKit

// MARK: - Declaration
class BookDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    let detailModel: BookDetailModel
    let detailView = BookDetailView()
    var nextViewController: BookWebViewController?
    
    // MARK: - Init
    
    init(_ detailModel: BookDetailModel) {
        self.detailModel = detailModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit - NaverSearchBookDetailViewController")
    }
}

// MARK: - Setting
extension BookDetailViewController {
    
    // MARK: - LifeCycle
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.title = "Book Detail"
        view.backgroundColor = .systemBackground
        modifyLeftBarButtonItem()
        
        detailView.setupConfig(book: detailModel.book)
        detailViewSetupAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        loadNextPageWebView()
    }
    
    //MARK: - setup
    
    private func detailViewSetupAction() {
        detailView.linkButton.addTarget(
            self, action: #selector(pushWebViewController),
            for: .touchUpInside)
    }
    
    private func loadNextPageWebView() {
        nextViewController = BookWebViewController()
        let link = detailModel.book?.link ?? "example.com"
        nextViewController?.loadURL(link: link)
    }
    
    // MARK: - objc func
    
    @objc func pushWebViewController() {
        let vc = nextViewController!
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

#Preview {
    let detailModel = BookDetailModel()
    detailModel.book = BookListModel.sampleBookList()[0]
    return UINavigationController(rootViewController: BookDetailViewController(detailModel))
}

