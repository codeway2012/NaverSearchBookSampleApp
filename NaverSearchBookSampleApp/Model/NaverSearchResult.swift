//
//  SearchResult.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/25/24.
//


// MARK: - Decodable

struct NaverSearchBookResult: Decodable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [Item]
    
    struct Item: Decodable {
        let title: String
        let link: String
        let image: String
        let author, discount, publisher, pubdate: String
        let isbn, description: String
    }
}

struct NaverSearchErrorResult: Decodable, Error  {
    let errorMessage: String
    let errorCode: String
}
