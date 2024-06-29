//
//  NaverSearchBookListView.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/27/24.
//

import UIKit

class NaverSearchBookListView: UIView {
    
    // MARK: - UI Components
    
    let tableView = UITableView()
    let searchBar = UISearchBar()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayout() {
        searchBar.topAnchor.constraint(
            equalTo: safeAreaLayoutGuide.topAnchor)
        .isActive = true
        searchBar.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 20)
        .isActive = true
        searchBar.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -20)
        .isActive = true
        
        tableView.topAnchor.constraint(
            equalTo: searchBar.bottomAnchor)
        .isActive = true
        tableView.bottomAnchor.constraint(
            equalTo: safeAreaLayoutGuide.bottomAnchor)
        .isActive = true
        tableView.leadingAnchor.constraint(
            equalTo: leadingAnchor)
        .isActive = true
        tableView.trailingAnchor.constraint(
            equalTo: trailingAnchor)
        .isActive = true
    }
    
    func setupConfig(searchBarText: String) {
        searchBar.text = searchBarText
    }
}

#Preview {
    NaverSearchBookListView()
}
