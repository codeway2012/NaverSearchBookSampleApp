//
//  NaverSearchBookDetailView.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/27/24.
//

import UIKit

class BookDetailView: UIView {

    // MARK: - UIComponent
    
    let bookContentScrollView = UIScrollView()
    let bookContentStackView = UIStackView()
    let bookImageBackgroundStackView = UIStackView()
    let bookImageView = ShadowImageView()
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
    
    // MARK: - Init
    
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
        // MARK: bookContentScrollView
        addSubview(bookContentScrollView)
        bookContentScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: bookContentStackView
        bookContentScrollView.addSubview(bookContentStackView)
        bookContentStackView
            .translatesAutoresizingMaskIntoConstraints = false
        bookContentStackView.axis = .vertical
        bookContentStackView.spacing = 20
        
        // MARK: bookImageBackgroundView
        bookContentStackView.addArrangedSubview(bookImageBackgroundStackView)
        bookImageBackgroundStackView.translatesAutoresizingMaskIntoConstraints = false
        bookImageBackgroundStackView.backgroundColor = UIColor.systemGray6
        bookImageBackgroundStackView.distribution = .fillProportionally
        bookImageBackgroundStackView.isLayoutMarginsRelativeArrangement = true
        bookImageBackgroundStackView.layoutMargins = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        
        // MARK: bookImageView
        addSubview(bookImageView)
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.contentMode = .scaleAspectFit
        bookImageView.setupShadow(opacity: 0.5, offset: CGSize(width: 10, height: 10), radius: 10)
        
        bookContentStackView.addArrangedSubview(mainTitleView)
        mainTitleView.setTitle("제목")
        bookContentStackView.addArrangedSubview(subTitleView)
        subTitleView.setTitle("부제목")
        bookContentStackView.addArrangedSubview(authorView)
        authorView.setTitle("저자")
        bookContentStackView.addArrangedSubview(discountView)
        discountView.setTitle("최저가")
        bookContentStackView.addArrangedSubview(publisherView)
        publisherView.setTitle("출판사")
        bookContentStackView.addArrangedSubview(pubdateView)
        pubdateView.setTitle("출간일")
        bookContentStackView.addArrangedSubview(isbnView)
        isbnView.setTitle("ISBN")
        bookContentStackView.addArrangedSubview(descriptionView)
        descriptionView.setTitle("책 소개")
        bookContentStackView.addArrangedSubview(linkButton)
        linkButton.setTitle("네이버 도서에서 보기", for: .normal)
    }

    private func setupLayout() {
        // MARK: bookContentScrollView
        bookContentScrollView.topAnchor.constraint(
            equalTo: safeAreaLayoutGuide.topAnchor)
        .isActive = true
        bookContentScrollView.bottomAnchor.constraint(
            equalTo: safeAreaLayoutGuide.bottomAnchor)
        .isActive = true
        bookContentScrollView.leadingAnchor.constraint(
            equalTo: leadingAnchor)
        .isActive = true
        bookContentScrollView.trailingAnchor.constraint(
            equalTo: trailingAnchor)
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
        
        // MARK: bookImageBackgroundView
        bookImageBackgroundStackView.heightAnchor.constraint(
            equalToConstant: 260)
        .isActive = true
        
        bookImageView.centerXAnchor.constraint(
            equalTo: centerXAnchor)
        .isActive = true
        bookImageView.centerYAnchor.constraint(
            equalTo: bookImageBackgroundStackView.centerYAnchor)
        .isActive = true
        bookImageView.heightAnchor.constraint(
            equalToConstant: 200)
        .isActive = true
    }
    
    func setupConfig(book: Book?) {
        // MARK: bookImageView
        bookImageView.image = book?.image
        
        // MARK: bookContentStackView
        mainTitleView.setContent(book?.mainTitle ?? "")
        if (book?.subTitle ?? "" != "") {
            subTitleView.setContent(book?.subTitle ?? "")
        } else {
            bookContentStackView.removeArrangedSubview(subTitleView)
            subTitleView.removeFromSuperview()
        }
        authorView.setContent(book?.author ?? "")
        discountView.setContent(book?.discount ?? "")
        publisherView.setContent(book?.publisher ?? "")
        pubdateView.setContent(book?.pubdate ?? "")
        isbnView.setContent(book?.isbn ?? "")
        descriptionView.setContent(book?.description ?? "")
    }
}

