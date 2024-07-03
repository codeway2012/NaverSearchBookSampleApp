//
//  NaverSearchBookDetailViewController.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/19/24.
//

import UIKit

// MARK: - Declaration
class BookDetailViewController: UIViewController, BookDetailDelegate {
    
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
        print("deinit - BookDetailViewController")
    }
}

// MARK: - Setting
extension BookDetailViewController {
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("BookDetail - viewDidLoad")
        self.title = "Book Detail"
        view.backgroundColor = .systemBackground
        loadNextPageWebView()
        setupLeftBarButtonItem()
        setupRightBarButtonItem()
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        detailView.setupConfig(book: detailModel.book)
    }
    
    //MARK: - setup
    
    private func loadNextPageWebView() {
        nextViewController = BookWebViewController()
        nextViewController?.detailDelegate = self
        let link = detailModel.book?.link ?? "example.com"
        nextViewController?.loadURL(link: link)
    }
    
    func setupRightBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(
            title: "Web", style: .plain, target: self,
            action: #selector(rightBarButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    // MARK: - objc func
    
    @objc func rightBarButtonTapped() {
        let vc = nextViewController!
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - delegate
extension BookDetailViewController {
    
    // MARK: - BookDetailDelegate
    func enabledRightBarButtonItem() {
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}

#Preview {
    let detailModel = BookDetailModel()
    detailModel.book = BookListModel.sampleBookList()[0]
    return UINavigationController(rootViewController: BookDetailViewController(detailModel))
}

