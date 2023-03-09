//
//  ApiCats.swift
//  TheCatApi
//
//  Created by Oscar David Myerston Vega on 8/03/23.
//

import Foundation

protocol Network {
    func fetchBreeds() async throws -> [Cat]
}

final class ApiCats: Network {

    func fetchBreeds() async throws -> [Cat] {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: Constants.URL.main+Constants.EndPoints.breeds)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(Constants.apiKey, forHTTPHeaderField: "API-KEY")
        let postString = ""
        request.httpBody = postString.data(using: .utf8)
        let (data, _) = try await session.data(for: request)
        return try JSONDecoder().decode([Cat].self, from: data)
    }

}
