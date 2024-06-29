//
//  TextStackView.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/20/24.
//

import UIKit

class TextStackView: UIStackView {
	private let titleLabel = UILabel()
	private let contentTextView = UITextView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	convenience init(title: String, content: String) {
		self.init(frame: .zero)
		setTitle(title)
		setContent(content)
	}
	
	private func setupView() {
		axis = .vertical
		spacing = 5
		alignment = .leading
		distribution = .fill
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
		
		addArrangedSubview(titleLabel)
		titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
		
		addArrangedSubview(contentTextView)
		contentTextView.font = UIFont.systemFont(ofSize: 16)
		contentTextView.textContainerInset = .zero
		contentTextView.textContainer.lineFragmentPadding = 0
		contentTextView.textContainer.lineBreakMode = .byCharWrapping
		contentTextView.isScrollEnabled = false
		contentTextView.isEditable = false
		contentTextView.isSelectable = true
	}

	func setTitle(_ title: String) {
		titleLabel.text = title
	}
	
	func setContent(_ content: String) {
		contentTextView.text = content
	}
}
