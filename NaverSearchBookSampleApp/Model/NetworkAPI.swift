//
//  NetworkAPI.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/18/24.
//

import Foundation
import UIKit

func naverSearchBookAPI(query: String, display: String, start: String)
async throws -> NaverSearchBookResult {
	
	let baseURL = "https://openapi.naver.com/v1/search/book.json"
	let clientID = "P30m8bv4KbaW9fC3jeCy"
	let clientSecret = "245CRfCnfa"
	
	let urlString = "\(baseURL)?query=\(query)&display=\(display)&start=\(start)"
	
	guard let url = URL(string: urlString) else {
		throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
	}
	
	var request = URLRequest(url: url)
	request.httpMethod = "GET"
	request.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
	request.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
	
	let (data, response) = try await URLSession.shared.data(for: request)
	
	guard let httpResponse = response as? HTTPURLResponse else {
		throw NSError(
			domain: "HTTP Error",
			code: (response as? HTTPURLResponse)?.statusCode ?? 0,
			userInfo: nil
		)
	}
	
	if (200...299).contains(httpResponse.statusCode) {
		let bookResponse = try JSONDecoder().decode(NaverSearchBookResult.self, from: data)
		return bookResponse
	} else {
		let errorResponse = try JSONDecoder().decode(NaverSearchError.self, from: data)
		throw errorResponse
	}
	
}
