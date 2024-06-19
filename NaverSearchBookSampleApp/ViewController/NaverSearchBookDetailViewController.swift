//
//  NaverSearchBookDetailViewController.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/19/24.
//

import UIKit

class NaverSearchBookDetailViewController: UIViewController {
	
	// MARK: - properties
	
	let model: NaverSearchBookModel
	
	// MARK: - UIComponent
	
	let bookImageBackgroundView = UIView()
	let bookImageView = UIImageView()
	let bookContentScrollView = UIScrollView()
	let bookContentStackView = UIStackView()
	let mainTitleView = TextStackView()
	let subTitleView = TextStackView()
	let authorView = TextStackView()
	let discountView = TextStackView()
	let publisherView = TextStackView()
	let pubdateView = TextStackView()
	let isbnView = TextStackView()
	let descriptionView = TextStackView()
	
	let tableView = UITableView()

	// MARK: - init
	
	init(model: NaverSearchBookModel) {
		self.model = model
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - LifeCycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "BookDetail"
		view.backgroundColor = .systemBackground
		
		setupUI()
		setupLayout()
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		model.book = nil
		print(model.book?.title ?? "book nil")
	}
	
	// MARK: - setupUI
	
	func setupUI() {
		// MARK: bookImageBackgroundView
		view.addSubview(bookImageBackgroundView)
		bookImageBackgroundView
			.translatesAutoresizingMaskIntoConstraints = false
		bookImageBackgroundView.backgroundColor = UIColor.systemGray6
		
		// MARK: bookImageView
		view.addSubview(bookImageView)
		bookImageView
			.translatesAutoresizingMaskIntoConstraints = false
		bookImageView.image = model.book?.image
		bookImageView.contentMode = .scaleAspectFit
		bookImageView.layer.shadowOpacity = 0.5
		bookImageView.layer.shadowOffset = CGSize(width: 4, height: 4)
		bookImageView.layer.shadowRadius = 10
		
		// MARK: bookContentScrollView
		view.addSubview(bookContentScrollView)
		bookContentScrollView.translatesAutoresizingMaskIntoConstraints = false
		bookContentScrollView.isScrollEnabled = true
		bookContentScrollView.showsVerticalScrollIndicator = true

		// MARK: bookContentStackView
		bookContentScrollView.addSubview(bookContentStackView)
		bookContentStackView
			.translatesAutoresizingMaskIntoConstraints = false
		bookContentStackView.axis = .vertical
		bookContentStackView.spacing = 20
		bookContentStackView.isLayoutMarginsRelativeArrangement = true
		bookContentStackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
		
		bookContentStackView.addArrangedSubview(mainTitleView)
		mainTitleView.setTitle("제목")
		mainTitleView.setContent(model.book?.mainTitle ?? "")
		
		if (model.book?.subTitle ?? "" != "") {
			bookContentStackView.addArrangedSubview(subTitleView)
			subTitleView.setTitle("소제목")
			subTitleView.setContent(model.book?.subTitle ?? "")
		}
		
		bookContentStackView.addArrangedSubview(authorView)
		authorView.setTitle("저자")
		authorView.setContent(model.book?.author ?? "")
		
		bookContentStackView.addArrangedSubview(discountView)
		discountView.setTitle("최저가")
		discountView.setContent(model.book?.discount ?? "")
		
		bookContentStackView.addArrangedSubview(publisherView)
		publisherView.setTitle("출판사")
		publisherView.setContent(model.book?.publisher ?? "")
		
		bookContentStackView.addArrangedSubview(pubdateView)
		pubdateView.setTitle("출간일")
		pubdateView.setContent(model.book?.pubdate ?? "")
		
		bookContentStackView.addArrangedSubview(isbnView)
		isbnView.setTitle("ISBN")
		isbnView.setContent(model.book?.isbn ?? "")
		
		bookContentStackView.addArrangedSubview(descriptionView)
		descriptionView.setTitle("책 소개")
		descriptionView.setContent(model.book?.description ?? "")

	}
	
	// MARK: - setupLayout
	
	func setupLayout() {
		// MARK: bookImageBackgroundView
		bookImageBackgroundView.topAnchor.constraint(
			equalTo: view.safeAreaLayoutGuide.topAnchor)
		.isActive = true
		bookImageBackgroundView.centerXAnchor.constraint(
			equalTo: view.centerXAnchor)
		.isActive = true
		bookImageBackgroundView.widthAnchor.constraint(
			equalTo: view.widthAnchor)
		.isActive = true
		bookImageBackgroundView.heightAnchor.constraint(
			equalToConstant: 300)
		.isActive = true
		
		// MARK: bookImageView
		bookImageView.heightAnchor.constraint(
			equalToConstant: 220)
		.isActive = true
		bookImageView.centerXAnchor.constraint(
			equalTo: bookImageBackgroundView.centerXAnchor)
		.isActive = true
		bookImageView.centerYAnchor.constraint(
			equalTo: bookImageBackgroundView.centerYAnchor)
		.isActive = true
		
		// MARK: bookContentScrollView
		bookContentScrollView.topAnchor.constraint(
			equalTo: bookImageBackgroundView.bottomAnchor)
		.isActive = true
		bookContentScrollView.bottomAnchor.constraint(
			equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		.isActive = true
		bookContentScrollView.centerXAnchor.constraint(
			equalTo: view.centerXAnchor)
		.isActive = true
		bookContentScrollView.widthAnchor.constraint(
			equalTo: view.widthAnchor)
		.isActive = true
		
		// MARK: bookContentStackView
		bookContentStackView.topAnchor.constraint(
			equalTo: bookContentScrollView.topAnchor)
		.isActive = true
		bookContentStackView.bottomAnchor.constraint(
			equalTo: bookContentScrollView.bottomAnchor)
		.isActive = true
		bookContentStackView.centerXAnchor.constraint(
			equalTo: bookContentScrollView.centerXAnchor)
		.isActive = true
		bookContentStackView.widthAnchor.constraint(
			equalTo: bookContentScrollView.widthAnchor)
		.isActive = true
	}
}

class TextStackView: UIStackView {
	private let titleLabel = UILabel()
	private let contentLabel = UILabel()
	
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
		spacing = 6
		alignment = .leading
		distribution = .fill
		
		titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
		contentLabel.font = UIFont.systemFont(ofSize: 16)
		contentLabel.numberOfLines = 0
		contentLabel.lineBreakMode = .byClipping
		
		addArrangedSubview(titleLabel)
		addArrangedSubview(contentLabel)
	}
	
	// 제목 설정
	func setTitle(_ title: String) {
		titleLabel.text = title
	}
	
	// 내용 설정
	func setContent(_ content: String) {
		contentLabel.text = content
	}
}
