//
//  NaverSearchBookListDelegate.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/20/24.
//

import UIKit

protocol NaverSearchBookListDelegate {
	func reloadTable()
	func reloadTableCell(index: Int)
}

protocol NaverSearchBookDetailDelegate {
	func reloadImage(image: UIImage)
}
