//
//  NaverSearchBookAPI.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/18/24.
//

import UIKit
import Combine
import Foundation

class NaverSearchBookAPI {
    let baseURL = "https://openapi.naver.com/v1/search/book.json"
    let clientId: String
    let clientSecret: String
    
    init() {
        let keyAES256 = KeyAES256()
        self.clientId = (try? keyAES256.decryptAES(
            targetBase64: keyAES256.idBase64AES,
            keyBase64: keyAES256.keyBase64AES)) ?? "N/A"
        self.clientSecret = (try? keyAES256.decryptAES(
            targetBase64: keyAES256.secretBase64AES,
            keyBase64: keyAES256.keyBase64AES)) ?? "N/A"
        
        if clientId == "" || clientSecret == "" {
            print("Failed to decrypt clientId or clientSecret")
        }
    }
    
    // async 방식
    func fetch(params: (query: String, nextStart: Int, display: Int))
    async -> Result<NaverSearchBookResult, APIRequestError> {
        guard var components = URLComponents(string: baseURL) else {
            return .failure(.invalidURL)
        }

        components.queryItems = {
            let query = params.query
            let start = String(params.nextStart)
            let display = String(params.display)
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "start", value: start),
                URLQueryItem(name: "display", value: display)
            ]
        }()
        
        guard let url = components.url else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(clientId, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let data: Data, response: URLResponse
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            return .failure(.requestFailed(error))
        }
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            return .failure(.invalidResponse)
        }
        
        if (200...299).contains(statusCode) {
            do {
                return .success(try NaverSearchBookResult(data: data))
            } catch {
                return .failure(.successDataDecodingFailed(error))
            }
        } else {
            do {
                return .failure(.naverAPIError(statusCode: statusCode, result: try NaverSearchErrorResult(data: data)))
            } catch {
                return .failure(.errorDataDecodingFailed(error))
            }
        }
    }
    
    func downloadImage(_ imageLink: String)
    async -> UIImage? {
        guard let url = URL(string: imageLink) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print(APIRequestError.dataDecodingFailed(error).localizedDescription)
            return nil
        }
    }

}
