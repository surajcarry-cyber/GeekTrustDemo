//
//  Network.swift
//  GeekTrustAssignmentDemo
//
//  Created by Dheeraj Chauhan on 02/01/26.
//

import Foundation

protocol Services {
    func fetchProducts(
        page: Int,
        completion: @escaping (Result<ProductModel, Error>) -> Void
    )
}

final class NetworkService: Services {

    func fetchProducts(
        page: Int,
        completion: @escaping (Result<ProductModel, Error>) -> Void
    ) {

        let urlString =
        "https://fakeapi.net/products?page=\(page)&limit=10&category=electronics"

        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in

            // Handle network error
            if let error = error {
                completion(.failure(error))
                return
            }

            // Ensure data exists
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                let response = try JSONDecoder().decode(ProductModel.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }

        }.resume()
    }
}

