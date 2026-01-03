//
//  ProductDetailViewController.swift
//  GeekTrustAssignmentDemo
//
//  Created by Dheeraj Chauhan on 02/01/26.
//
import UIKit

class ProductDetailViewController: UIViewController {
 
    //MARK: - Initializers
    var product: Product?
    
    //MARK: - Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        titleLbl.text = product?.title ?? ""
        priceLbl.text = " $ \(product?.price ?? 0.0) "
        descriptionLbl.text = product?.description ?? ""
        productImage.setImage(
            from: product?.image ?? "",
            placeholder: UIImage(named: "logo")
        )
    }
    
}
