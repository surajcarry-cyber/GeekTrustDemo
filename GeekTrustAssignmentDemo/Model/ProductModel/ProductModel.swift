//
//  ProductModel.swift
//  GeekTrustAssignmentDemo
//
//  Created by Dheeraj Chauhan on 02/01/26.
//

import Foundation

// MARK: - ProductModel
struct ProductModel: Codable {
    let data: [Product]
    let pagination: Pagination?
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description, category, brand: String
    let stock: Int?
    let image: String
    let specs: Specs?
    let rating: Rating?
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double?
    let count: Int?
}

// MARK: - Specs
struct Specs: Codable {
    let color, weight, storage, battery: String?
    let waterproof: Bool?
    let screen, ram, connection, capacity: String?
    let output: String?
}

// MARK: - Pagination
struct Pagination: Codable {
    let page, limit, total: Int?
}

