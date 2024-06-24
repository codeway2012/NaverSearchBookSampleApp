//
//  Book.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/24/24.
//

import UIKit

struct Book {
    let title: String
    let link: String
    let imageLink: String
    let author: String
    let discount: String
    let publisher: String
    let pubdate: String
    let isbn: String
    let description: String
    var mainTitle: String
    var subTitle: String
    var image: UIImage
    
    init(_ item: NaverSearchBookResult.Item) {
        self.title = item.title
        self.link = item.link
        self.imageLink = item.image
        self.author = item.author
        self.discount = item.discount
        self.publisher = item.publisher
        self.pubdate = item.pubdate
        self.isbn = item.isbn
        self.description = item.description
        
        if let range = item.title.range(of: " (") {
            self.mainTitle = String(item.title[..<range.lowerBound])
            self.subTitle = String(item.title[range.lowerBound...])
            
            let text = self.subTitle
            let startIndex = text.index(text.startIndex, offsetBy: 2)
            let endIndex = text.index(text.endIndex, offsetBy: -1)
            self.subTitle = String(text[startIndex..<endIndex])
        } else {
            self.mainTitle = item.title
            self.subTitle = ""
        }
        
        self.image = UIImage(systemName: "photo") ?? UIImage()
    }
    
}
