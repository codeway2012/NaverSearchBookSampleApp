//
//  ViewController.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/18/24.
//

import UIKit

// MARK: - Declaration
class NaverSearchBookListViewController:
	UIViewController, UITableViewDataSource, UITableViewDelegate,
	UISearchBarDelegate, NaverSearchBookListDelegate {

	// MARK: - UI Component
	
	let tableView = UITableView()
	let searchBar = UISearchBar()
	let searchStackView = UIStackView()
	let searchTextField = UITextField()
	let searchButton = UIButton(type: .system)

	// MARK: - Properties
	
	let model = NaverSearchBookModel()
	var searchQuery = "프로그래밍"
}

// MARK: - UI Setting
extension NaverSearchBookListViewController {
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		self.title = "Book List"
		
		setupUI()
		setupLayout()
		
		searchBar.delegate = self
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		
		model.naverSearchBookListDelegate = self
		model.searchBookList(query: searchQuery)
	}
	
	// MARK: -
	func setupUI() {
		view.addSubview(searchBar)
		searchBar
			.translatesAutoresizingMaskIntoConstraints = false
		searchBar.text = searchQuery
		
		view.addSubview(tableView)
		tableView
			.translatesAutoresizingMaskIntoConstraints = false
	}
	
	// MARK: -
	func setupLayout() {
		searchBar.topAnchor.constraint(
			equalTo: view.safeAreaLayoutGuide.topAnchor)
		.isActive = true
		searchBar.leadingAnchor.constraint(
			equalTo: view.leadingAnchor,
			constant: 20)
		.isActive = true
		searchBar.trailingAnchor.constraint(
			equalTo: view.trailingAnchor,
			constant: -20)
		.isActive = true
		
		tableView.topAnchor.constraint(
			equalTo: searchBar.bottomAnchor)
		.isActive = true
		tableView.bottomAnchor.constraint(
			equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		.isActive = true
		tableView.leadingAnchor.constraint(
			equalTo: view.leadingAnchor)
		.isActive = true
		tableView.trailingAnchor.constraint(
			equalTo: view.trailingAnchor)
		.isActive = true
	}
	
	// MARK: - method
	
	func navigationPushDetailVC(index: Int) {
		model.book = model.bookList[index]
		guard let book = model.book else { return }
		print("Selected book title: \(book.mainTitle)")
		
		let vc = NaverSearchBookDetailViewController(model: model)
		navigationController?.pushViewController(
			vc, animated: false)
	}
	
	// MARK: - objc method
	
	@objc func serach() {
		model.searchBookList(query: searchQuery)
	}
}

// MARK: - Delegate
extension NaverSearchBookListViewController {
	
	// MARK: - UITableViewDataSource
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return model.naverSearchBookListCount()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(
			withIdentifier: "cell", for: indexPath)
		let book = model.bookList[indexPath.row]
		
		var config = cell.defaultContentConfiguration()
		config.image = book.image
		config.text = book.mainTitle
		config.secondaryText = book.subTitle
		config.imageProperties
			.reservedLayoutSize = CGSize(width: 50, height: 80)
		config.imageProperties
			.maximumSize = CGSize(width: 50, height: 80)
		
		cell.contentConfiguration = config
		cell.separatorInset = UIEdgeInsets(
			top: 0, left: 5, bottom: 0, right: 5)
		return cell
	}
	
	// MARK: - UITableViewDelegate
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		navigationPushDetailVC(index: indexPath.row)
	}
	
	// MARK: - UISearchBarDelegate
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		searchQuery = searchText
		print("textDidChange - \(self.searchQuery)")
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		model.searchBookList(query: searchQuery)
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchQuery = ""
		searchBar.text = searchQuery
		searchBar.resignFirstResponder()
	}
	
	// MARK: - NaverSearchBookListDelegate
	
	func reloadTable() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
			print("reloadTable")
		}
	}
	
	func reloadTableCell(index: Int) {
		DispatchQueue.main.async {
			self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
			print("reloadTableCell - \(index)")
		}
	}

}

#Preview {
	UIStoryboard(name: "Main", bundle: nil)
		.instantiateInitialViewController()!
}
