//
//  NaverSearchBookDetailViewController.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/19/24.
//

import UIKit

// MARK: - Declaration
class NaverSearchBookDetailViewController: UIViewController {

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
	let linkView = TextStackView()
	let linkButton = UIButton(type: .system)
	
	// MARK: - Properties
	
	var model: NaverSearchBookDetailModel
	
	// MARK: - Init
	
	init(model: NaverSearchBookDetailModel) {
		self.model = model

		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    deinit {
        print("deinit - NaverSearchBookDetailViewController")
    }
}

// MARK: - UI Setting
extension NaverSearchBookDetailViewController {
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("viewDidLoad")
		self.title = "Book Detail"
		view.backgroundColor = .systemBackground
		modifyLeftBarButtonItem()

		setupUI()
		setupLayout()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
	}
	
	// MARK: -
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
		bookImageView.layer.shadowPath = nil
		
		// MARK: bookContentScrollView
		view.addSubview(bookContentScrollView)
		bookContentScrollView.translatesAutoresizingMaskIntoConstraints = false
		
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
			subTitleView.setTitle("부제목")
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
		
		bookContentStackView.addArrangedSubview(linkButton)
		linkButton.setTitle("네이버 도서에서 보기", for: .normal)
		linkButton.addTarget(self, action: #selector(pushWebViewController),
							 for: .touchUpInside)
	}
	
	// MARK: -
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
		bookImageView.centerXAnchor.constraint(
			equalTo: bookImageBackgroundView.centerXAnchor)
		.isActive = true
		bookImageView.centerYAnchor.constraint(
			equalTo: bookImageBackgroundView.centerYAnchor)
		.isActive = true
		bookImageView.heightAnchor.constraint(
			equalToConstant: 220)
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
		bookContentStackView.leadingAnchor.constraint(
			equalTo: bookContentScrollView.leadingAnchor)
		.isActive = true
		bookContentStackView.trailingAnchor.constraint(
			equalTo: bookContentScrollView.trailingAnchor)
		.isActive = true
		bookContentStackView.widthAnchor.constraint(
			equalTo: bookContentScrollView.widthAnchor)
		.isActive = true
	}
	
	// MARK: - NaverSearchBookDetailDelegate
	
	func reloadImage(image: UIImage) {
		DispatchQueue.main.async {
			print("NaverSearchBookDetailDelegate - reloadImage")
			self.bookImageView.image = image
		}
	}
	
	// MARK: - objc func
	
	@objc func pushWebViewController() {
		let vc = NaverSearchBookWebViewController(model: model)
		self.navigationController?.pushViewController(vc, animated: false)
	}
}

#Preview {
    let model = NaverSearchBookDetailModel()
    model.book = NaverSearchBookListModel.sampleBookList()[0]
    return NaverSearchBookDetailViewController(model: model)
}

