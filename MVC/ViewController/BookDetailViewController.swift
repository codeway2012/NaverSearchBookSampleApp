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
        print("deinit - BookDetailViewController")
    }
}

// MARK: - Setting
extension BookDetailViewController {
    
    // MARK: - LifeCycle
    
    override func loadView() {
        loadNextPageWebView()
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("BookDetail - viewDidLoad")
        self.title = "Book Detail"
        view.backgroundColor = .systemBackground
        setupLeftBarButtonItem()
        setupRightBarButtonItem()
        
        detailView.setupConfig(book: detailModel.book)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("BookDetail - viewDidAppear")
        
    }
    
    //MARK: - setup
    
    private func loadNextPageWebView() {
        nextViewController = BookWebViewController()
        let link = detailModel.book?.link ?? "example.com"
        nextViewController?.loadURL(link: link)
    }
    
    func setupRightBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(
            title: "Web", style: .plain, target: self,
            action: #selector(rightBarButtonTapped))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    // MARK: - objc func
    
    @objc func rightBarButtonTapped() {
        let vc = nextViewController!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

#Preview {
    let detailModel = BookDetailModel()
    detailModel.book = BookListModel.sampleBookList()[0]
    return UINavigationController(rootViewController: BookDetailViewController(detailModel))
}

