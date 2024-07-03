//
//  ViewController.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/18/24.
//

import UIKit

// MARK: - Declaration
class BookListViewController:
    UIViewController, UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching,
    UISearchBarDelegate, BookListDelegate {
    
    // MARK: - Properties
    
    let listView = BookListView()
    let listModel = BookListModel()
}

// MARK: - Setting
extension BookListViewController {
    
    // MARK: - LifeCycle
    
    override func loadView() {
        self.view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Book List"
        
        listView.setupConfig(searchBarText: listModel.params.query)
        
        listView.searchBar.delegate = self
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
        listView.tableView.prefetchDataSource = self
        listView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        listModel.naverSearchBookListDelegate = self
        listModel.searchBookList()
    }
    
    // MARK: - method
    
    private func cellConfig(cell: UITableViewCell, book: Book) -> UITableViewCell {
        var config = cell.defaultContentConfiguration()
        config.image = book.image
        config.text = book.mainTitle
        config.secondaryText = book.subTitle
        config.imageProperties.reservedLayoutSize = CGSize(width: 50, height: 80)
        config.imageProperties.maximumSize = CGSize(width: 50, height: 80)
        cell.contentConfiguration = config
        cell.separatorInset = UIEdgeInsets(
            top: 0, left: 5, bottom: 0, right: 5)
        return cell
    }
    
    private func navigationPushDetailVC(index: Int) {
        let detailModel = BookDetailModel()
        detailModel.book = listModel.bookList[index]
        guard let book = detailModel.book else { return }
        print("Selected book title: \(book.mainTitle)")
        
        let vc = BookDetailViewController(detailModel)
        navigationController?
            .pushViewController(vc, animated: false)
    }
}

// MARK: - Delegate
extension BookListViewController {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listModel.naverSearchBookListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell", for: indexPath)
        let book = listModel.bookList[indexPath.row]
        return cellConfig(cell: cell, book: book)
    }
    
    // MARK: - UITableViewDataSourcePrefetching
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard !listModel.isFetching,
              !listModel.isAllDataLoad else {
            print("prefetchRowsAt - guard")
            return
        }
        if indexPaths.contains(where: { $0.row >= listModel.triggerIndex }) {
            listModel.searchBookListPrefetching()
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationPushDetailVC(index: indexPath.row)
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listModel.params.query = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        listModel.searchBookList()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        listModel.params.query = ""
        searchBar.text = listModel.params.query
        searchBar.resignFirstResponder()
    }
    
    // MARK: - NaverSearchBookListDelegate
    
    func reloadTable() {
        listView.tableView.reloadData()
        print("reloadData")
    }

    func reloadTableRows(indexPaths: [IndexPath]) {
        listView.tableView.reloadRows(at: indexPaths, with: .none)
        print("reloadTableCell - \(indexPaths)")
    }
    
    func insertTableRows(indexPaths: [IndexPath]) {
        listView.tableView.insertRows(at: indexPaths, with: .none)
        print("tableInsertRows - \(indexPaths)")
    }
    
}

#Preview {
    return UINavigationController(rootViewController: BookListViewController())
}
