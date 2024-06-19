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
	UIViewController, UITableViewDataSource, UITableViewDelegate, NaverSearchBookListDelegate {

	// MARK: - Properties
	
	let model = NaverSearchBookModel()
	var searchText = "프로그래밍"
	
	// MARK: - UIComponent
	
	let tableView = UITableView()
	let searchStackView = UIStackView()
	let searchTextField = UITextField()
	let searchButton = UIButton(type: .system)
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.dataSource = self
		tableView.delegate = self
		
		model.naverSearchBookListDelegate = self
		model.searchBookList(query: searchText)
		
		setupUI()
		setupLayout()
	}
	
	// MARK: - setupUI
	
	func setupUI() {
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(searchStackView)
		searchStackView.translatesAutoresizingMaskIntoConstraints = false
		searchStackView.axis = .horizontal
		searchStackView.spacing = 8
		searchStackView.alignment = .fill
		searchStackView.distribution = .fill
		
		searchStackView.addArrangedSubview(searchTextField)
		searchTextField.placeholder = "프로그래밍"
		searchTextField.borderStyle = .roundedRect
		searchTextField.addTarget(
			self, action: #selector(textFieldDidChange(_:)),
			for: .editingChanged)
		
		searchStackView.addArrangedSubview(searchButton)
		searchButton.addTarget(self, action: #selector(serach), for: .touchUpInside)
		searchButton.setTitle("search", for: .normal)
		
	}
	
	// MARK: - setupLayout
	
	func setupLayout() {
		searchStackView.topAnchor.constraint(
			equalTo: view.safeAreaLayoutGuide.topAnchor)
		.isActive = true
//		searchStack.heightAnchor.constraint(
//			equalToConstant: 100)
//		.isActive = true
		searchStackView.leadingAnchor.constraint(
			equalTo: view.leadingAnchor,
			constant: 20)
		.isActive = true
		searchStackView.trailingAnchor.constraint(
			equalTo: view.trailingAnchor,
			constant: -20)
		.isActive = true
		
		tableView.topAnchor.constraint(
			equalTo: searchStackView.bottomAnchor)
		.isActive = true
		tableView.bottomAnchor.constraint(
			equalTo: view.bottomAnchor)
		.isActive = true
		tableView.leadingAnchor.constraint(
			equalTo: view.leadingAnchor)
		.isActive = true
		tableView.trailingAnchor.constraint(
			equalTo: view.trailingAnchor)
		.isActive = true
	}
	
	// MARK: - NaverSearchBookListDelegate
	
	func tableReload() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
	
	// MARK: - UITableViewDataSource
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return model.naverSearchBookCount()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView
			.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		let book = model.bookList[indexPath.row]
		
		var config = cell.defaultContentConfiguration()
		config.text = book.title
		config.image = book.image
		config.imageProperties.maximumSize = CGSize(width: 60, height: 60)
		cell.contentConfiguration = config
		
		return cell
	}
	
	// MARK: - UITableViewDelegate
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Selected book: \(model.bookList[indexPath.row].title)")
	}
	
	// MARK: - objc method
	
	@objc func serach() {
		model.searchBookList(query: searchText)
	}
	
	@objc func textFieldDidChange(_ textField: UITextField) {
		self.searchText = textField.text ?? ""
		print("textFieldDidChange - \(self.searchText)")
	}

}


