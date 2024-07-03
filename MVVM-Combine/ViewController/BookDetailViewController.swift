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
    
    let detailViewModel: BookDetailViewModel
    let detailView = BookDetailView()
    var nextViewController: BookWebViewController?
    
    // MARK: - Init
    
    init(_ detailViewModel: BookDetailViewModel) {
        self.detailViewModel = detailViewModel
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
        
        detailView.setupConfig(book: detailViewModel.book)
    }
    
    //MARK: - Setup
    
    private func loadNextPageWebView() {
        nextViewController = BookWebViewController()
        nextViewController?.detailDelegate = self
        let link = detailViewModel.book?.link ?? "example.com"
        nextViewController?.loadURL(link: link)
    }
    
    func setupRightBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(
            title: "Web", style: .plain, target: self,
            action: #selector(rightBarButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    // MARK: - Action
    
    @objc func rightBarButtonTapped() {
        let vc = nextViewController!
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Delegate
extension BookDetailViewController {
    
    // MARK: - BookDetailDelegate
    func enabledRightBarButtonItem() {
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}

#Preview {
    let detailViewModel = BookDetailViewModel()
    detailViewModel.book = BookListViewModel.sampleBookList()[0]
    return UINavigationController(rootViewController: BookDetailViewController(detailViewModel))
}

