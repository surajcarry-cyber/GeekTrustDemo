//
//  ProductListViewModel.swift
//  GeekTrustAssignmentDemo
//
//  Created by Dheeraj Chauhan on 02/01/26.
//

import Foundation
final class ProductListViewModel {
    
    // MARK: - Bindings (View → ViewModel)
    var onDataUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    var onLoadingStateChange: ((Bool) -> Void)?
    
    // MARK: - Properties
    private let service: Services
    private var products: [Product] = []
    
    private var currentPage = 0
    private var totalPages = Int.max
    private var isFetching = false
    private var hasMoreData = true
    
    // MARK: - Init
    init(service: Services = NetworkService()) {
        self.service = service
    }
    
    // MARK: - Fetch Products (Pagination)
    // MARK: - Fetch Products (Pagination using total pages)
    func fetchProducts() {
        
        // Prevent duplicate calls or extra API calls
        guard !isFetching, currentPage < totalPages else { return }
        
        isFetching = true
        onLoadingStateChange?(true)
        
        service.fetchProducts(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.isFetching = false
                self.onLoadingStateChange?(false)
                
                switch result {
                case .success(let response):
                    
                    // Append new products
                    self.products.append(contentsOf: response.data)
                    
                    // Update pagination values
                    self.totalPages = response.pagination?.page ?? 0
                    self.currentPage += 1
                    
                    self.onDataUpdate?()
                    
                case .failure(let error):
                    self.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - TableView Helpers
    func numberOfRows() -> Int {
        products.count
    }
    
    func product(at index: Int) -> Product {
        products[index]
    }
    
    // Trigger pagination when user reaches near bottom
    func shouldLoadMore(at index: Int) -> Bool {
        index >= products.count - 2
    }
}

