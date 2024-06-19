//
//  ViewController.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/18/24.
//

import UIKit

protocol NaverSearchBookListDelegate {
	func tableReload()
}

class NaverSearchBookListViewController:
	UIViewController, UITableViewDataSource, UITableViewDelegate,
	UISearchBarDelegate, NaverSearchBookListDelegate {

	// MARK: - Properties
	
	let model = NaverSearchBookModel()
	var searchQuery = "프로그래밍"
	
	// MARK: - UIComponent
	
	let tableView = UITableView()
	let searchBar = UISearchBar()
	let searchStackView = UIStackView()
	let searchTextField = UITextField()
	let searchButton = UIButton(type: .system)

	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		self.title = "BookList"
		
		setupUI()
		setupLayout()
		
		searchBar.delegate = self
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.dataSource = self
		tableView.delegate = self

		model.naverSearchBookListDelegate = self
		model.searchBookList(query: searchQuery)
	}
	
	// MARK: - setupUI
	
	func setupUI() {
		view.addSubview(searchBar)
		searchBar.translatesAutoresizingMaskIntoConstraints = false
		searchBar.text = searchQuery
		
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
	}
	
	// MARK: - setupLayout
	
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
		model.book = model.bookList[indexPath.row]
		guard let book = model.book else { return }
		print("Selected book title: \(book.mainTitle)")
		
		let vc = NaverSearchBookDetailViewController(
			model: model)
		navigationController?.pushViewController(
			vc, animated: false)
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
	
	func tableReload() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
	
	// MARK: - objc method
	
	@objc func serach() {
		model.searchBookList(query: searchQuery)
	}
}


#Preview {
	UIStoryboard(name: "Main", bundle: nil)
		.instantiateInitialViewController()!
}
