//
//  NaverSearchBookListDelegate.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/20/24.
//

import UIKit

protocol BookListDelegate {
    @MainActor func reloadTable()
    @MainActor func reloadTableRows(indexPaths: [IndexPath])
    @MainActor func insertTableRows(indexPaths: [IndexPath])
}
