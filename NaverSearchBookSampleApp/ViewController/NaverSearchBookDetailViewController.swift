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
    
    let detailViewModel: NaverSearchBookDetailViewModel
    let detailView = NaverSearchBookDetailView()
    
    // MARK: - Init
    
    init(detailViewModel: NaverSearchBookDetailViewModel) {
        self.detailViewModel = detailViewModel
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
        
        detailView.setupUI(book: detailViewModel.book)
        detailViewSetupAction()
        detailView.setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //MARK: - setup
    
    private func detailViewSetupAction() {
        detailView.linkButton.addTarget(
            self, action: #selector(pushWebViewController),
            for: .touchUpInside)
    }
    
    // MARK: - objc func
    
    @objc func pushWebViewController() {
        let vc = NaverSearchBookWebViewController(detailViewModel: detailViewModel)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

#Preview {
    let detailViewModel = NaverSearchBookDetailViewModel()
    detailViewModel.book = NaverSearchBookListViewModel.sampleBookList()[0]
    return UINavigationController(rootViewController: NaverSearchBookDetailViewController(detailViewModel: detailViewModel))
}

