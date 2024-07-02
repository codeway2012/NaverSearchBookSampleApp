//
//  NavigationLeftBackButton.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/20/24.
//

import UIKit

extension UIViewController {
    func modifyLeftBarButtonItem() {
        let leftBarButtonItem = UIBarButtonItem(
            title: "Back", style: .plain, target: self,
            action: #selector(leftBarButtonTapped))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func leftBarButtonTapped() {
        self.navigationController?.popViewController(animated: false)
    }
}
