//
//  SearchResult.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/25/24.
//

import Foundation

// MARK: - Decodable

struct NaverSearchBookResult: Decodable {
    private let lastBuildDate: String
    private let total, start, display: Int
    let items: [Item]
    
    struct Item: Decodable {
        let title: String
        let link, image: String
        let author, discount: String
        let publisher, pubdate: String
        let isbn, description: String
    }
    
    init(data: Data) throws {
        self = try JSONDecoder().decode(NaverSearchBookResult.self, from: data)
    }
}

struct NaverSearchErrorResult: Decodable, Error  {
    let errorCode: String
    let errorMessage: String
    
    init(data: Data) throws {
        self = try JSONDecoder().decode(NaverSearchErrorResult.self, from: data)
    }
}

enum APIRequestError: LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case naverAPIError(statusCode: Int, result: NaverSearchErrorResult)
    case successDataDecodingFailed(Error)
    case errorDataDecodingFailed(Error)
    case dataDecodingFailed(Error)
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "유효하지 않은 URL입니다."
            case .requestFailed(let error):
                return "요청에 실패했습니다: \(error.localizedDescription)"
            case .invalidResponse:
                return "유효하지 않은 응답입니다."
            case .naverAPIError(let statusCode, let result):
                return "Naver API 에러: statusCode - \(statusCode), errorCode - \(result.errorCode), errorMessage - \(result.errorMessage)"
            case .successDataDecodingFailed(let error):
                return "정상 코드의 데이터 디코딩에 실패했습니다: \(error.localizedDescription)"
            case .errorDataDecodingFailed(let error):
                return "에러 코드의 데이터 디코딩에 실패했습니다: \(error.localizedDescription)"
            case .dataDecodingFailed(let error):
                return "데이터 디코딩에 실패했습니다: \(error.localizedDescription)"
        }
    }
}
