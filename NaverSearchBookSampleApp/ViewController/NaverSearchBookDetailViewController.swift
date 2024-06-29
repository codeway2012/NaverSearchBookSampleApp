//
//  NaverSearchBookDetailViewController.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/19/24.
//

import UIKit

// MARK: - Declaration
class NaverSearchBookDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    let detailModel: NaverSearchBookDetailModel
    let detailView = NaverSearchBookDetailView()
    var nextViewController: NaverSearchBookWebViewController?
    
    // MARK: - Init
    
    init(_ detailModel: NaverSearchBookDetailModel) {
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
extension NaverSearchBookDetailViewController {
    
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
        nextViewController = NaverSearchBookWebViewController()
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
    let detailModel = NaverSearchBookDetailModel()
    detailModel.book = NaverSearchBookListModel.sampleBookList()[0]
    return UINavigationController(rootViewController: NaverSearchBookDetailViewController(detailModel))
}

