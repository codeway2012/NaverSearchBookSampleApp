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
	
	// 초기화 메서드
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	// 커스텀 초기화 메서드
	convenience init(title: String, content: String) {
		self.init(frame: .zero)
		setTitle(title)
		setContent(content)
	}
	
	// UIStackView 설정
	private func setupView() {
		axis = .vertical
		spacing = 5
		alignment = .leading
		distribution = .fill
		
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
	
	// 제목 설정
	func setTitle(_ title: String) {
		titleLabel.text = title
	}
	
	// 내용 설정
	func setContent(_ content: String) {
		contentTextView.text = content
	}
}
