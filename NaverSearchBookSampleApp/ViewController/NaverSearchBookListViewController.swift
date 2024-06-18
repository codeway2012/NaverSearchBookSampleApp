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
	NaverSearchBookListDelegate {

	// MARK: - Properties
	
	let model = NaverSearchBookModel()
	
	// MARK: - UIComponent
	
	let tableView = UITableView()
	let searchButton = UIButton(type: .system)
	let reloadButton = UIButton(type: .system)
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		
		setupUI()
		setupLayout()
	
		model.naverSearchBookListDelegate = self
	}
	
	// MARK: - setupUI
	
	func setupUI() {
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(searchButton)
		searchButton.translatesAutoresizingMaskIntoConstraints = false
		searchButton.addTarget(self, action: #selector(serach), for: .touchUpInside)
		searchButton.setTitle("search", for: .normal)
		
		view.addSubview(reloadButton)
		reloadButton.translatesAutoresizingMaskIntoConstraints = false
		reloadButton.addTarget(self, action: #selector(reload), for: .touchUpInside)
		reloadButton.setTitle("reloadButton", for: .normal)
	}
	
	// MARK: - setupLayout
	
	func setupLayout() {
		tableView.topAnchor.constraint(
			equalTo: view.topAnchor).isActive = true
		tableView.bottomAnchor.constraint(
			equalTo: view.bottomAnchor,
			constant: -200).isActive = true
		tableView.leadingAnchor.constraint(
			equalTo: view.leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(
			equalTo: view.trailingAnchor).isActive = true
		
		searchButton.bottomAnchor.constraint(
			equalTo: view.bottomAnchor, 
			constant: -100).isActive = true
		searchButton.centerXAnchor.constraint(
			equalTo: view.centerXAnchor,
			constant: -100).isActive = true
		
		reloadButton.bottomAnchor.constraint(
			equalTo: view.bottomAnchor,
			constant: -100).isActive = true
		reloadButton.centerXAnchor.constraint(
			equalTo: view.centerXAnchor,
			constant: 100).isActive = true
	}
	
	// MARK: - NaverSearchBookListDelegate
	
	func tableReload() {
		tableView.reloadData()
	}
	
	// MARK: - UITableViewDataSource
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return model.NaverSearchBookCount()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView
			.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		let book = model.bookList[indexPath.row]
		cell.textLabel?.text = book.title
		return cell
	}
	
	// MARK: - objc method
	
	@objc func serach() {
		model.searchBookList(query: "스위프트")
	}
	
	@objc func reload() {
		tableView.reloadData()
	}
	
}


