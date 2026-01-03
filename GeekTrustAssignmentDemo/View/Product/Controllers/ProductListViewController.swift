//
//  ViewController.swift
//  GeekTrustAssignmentDemo
//
//  Created by Dheeraj Chauhan on 02/01/26.
//

import UIKit
 

final class ProductListViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!

    private let viewModel = ProductListViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchProducts()
    }

    // MARK: - UI Setup
    private func setupUI() {
        title = "Products"

        productTableView.dataSource = self
        productTableView.delegate = self
        loader.hidesWhenStopped = true
    }

    // MARK: - Bind ViewModel
    private func bindViewModel() {

        viewModel.onDataUpdate = { [weak self] in
            self?.productTableView.reloadData()
        }

        viewModel.onLoadingStateChange = { [weak self] isLoading in
            isLoading ? self?.loader.startAnimating()
                      : self?.loader.stopAnimating()
        }

        viewModel.onError = { error in
            print("Error:", error)
        }
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate
extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ProductCell",
            for: indexPath
        ) as? ProductCell else {
            return UITableViewCell()
        }

        let product = viewModel.product(at: indexPath.row)

        cell.titleLbl.text = product.title
        cell.descriptionLbl.text = product.description
        cell.categoryLbl.text = product.category
        cell.priceLbl.text = "$\(product.price)"

        // Lazy image loading with placeholder
        cell.productImage.setImage(
            from: product.image,
            placeholder: UIImage(named: "logo")
        )

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let product = viewModel.product(at: indexPath.row)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "ProductDetailViewController"
        ) as! ProductDetailViewController

        vc.product = product
        navigationController?.pushViewController(vc, animated: true)
    }

    
    // MARK: - Pagination Trigger
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {

        if viewModel.shouldLoadMore(at: indexPath.row) {
            viewModel.fetchProducts()
        }
    }
}

