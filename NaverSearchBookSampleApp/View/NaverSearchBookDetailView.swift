//
//  NaverSearchBookDetailView.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/27/24.
//

import UIKit

class NaverSearchBookDetailView: UIView {

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
        // MARK: bookImageBackgroundView
        addSubview(bookImageBackgroundView)
        bookImageBackgroundView
            .translatesAutoresizingMaskIntoConstraints = false
        bookImageBackgroundView.backgroundColor = UIColor.systemGray6
        
        // MARK: bookImageView
        addSubview(bookImageView)
        bookImageView
            .translatesAutoresizingMaskIntoConstraints = false
        bookImageView.contentMode = .scaleAspectFit
        bookImageView.layer.shadowOpacity = 0.5
        bookImageView.layer.shadowOffset = CGSize(width: 4, height: 4)
        bookImageView.layer.shadowRadius = 10
        bookImageView.layer.shadowPath = nil
        
        // MARK: bookContentScrollView
        addSubview(bookContentScrollView)
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
        // MARK: bookImageBackgroundView
        bookImageBackgroundView.topAnchor.constraint(
            equalTo: safeAreaLayoutGuide.topAnchor)
        .isActive = true
        bookImageBackgroundView.centerXAnchor.constraint(
            equalTo: centerXAnchor)
        .isActive = true
        bookImageBackgroundView.widthAnchor.constraint(
            equalTo: widthAnchor)
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
            equalTo: safeAreaLayoutGuide.bottomAnchor)
        .isActive = true
        bookContentScrollView.centerXAnchor.constraint(
            equalTo: centerXAnchor)
        .isActive = true
        bookContentScrollView.widthAnchor.constraint(
            equalTo: widthAnchor)
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
