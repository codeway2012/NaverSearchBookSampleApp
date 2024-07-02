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
    var image: UIImage = UIImage(systemName: "photo.fill")!
    
    init(_ item: NaverSearchBookResult.Item) {
        let titles = Book.splitTitle(title: item.title)
        
        self.title = item.title
        self.link = item.link
        self.imageLink = item.image
        self.author = item.author
        self.discount = item.discount
        self.publisher = item.publisher
        self.pubdate = item.pubdate
        self.isbn = item.isbn
        self.description = item.description
        self.mainTitle = titles.0
        self.subTitle = titles.1
    }
    
    private static func splitTitle(title: String) -> (String, String) {
        if let range = title.range(of: " (") {
            let mainTitle = String(title[..<range.lowerBound])
            var subTitle = String(title[range.lowerBound...])
            
            let startIndex = subTitle.index(subTitle.startIndex, offsetBy: 2)
            let endIndex = subTitle.index(subTitle.endIndex, offsetBy: -1)
            subTitle = String(subTitle[startIndex..<endIndex])
            return (mainTitle, subTitle)
        } else {
            return (title, "")
        }
    }
}
