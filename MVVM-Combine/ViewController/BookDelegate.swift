//
//  NaverSearchBookListDelegate.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/20/24.
//

import UIKit

protocol BookListDelegate: AnyObject {
    @MainActor func reloadTable()
    @MainActor func reloadTableRows(indexPaths: [IndexPath])
    @MainActor func insertTableRows(indexPaths: [IndexPath])
}

protocol BookDetailDelegate: AnyObject {
    func enabledRightBarButtonItem()
}

