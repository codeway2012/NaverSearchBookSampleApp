//
//  NaverSearchBookListDelegate.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/20/24.
//

import UIKit

protocol BookListDelegate {
    @MainActor func reloadTable()
    @MainActor func reloadTableCell(index: Int)
}
