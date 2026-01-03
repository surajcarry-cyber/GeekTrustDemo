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
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var stockLbl: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        titleLbl.text = product?.title ?? ""
        priceLbl.text = " $ \(product?.price ?? 0.0) "
        descriptionLbl.text = "Desc :- \(product?.description ?? "")"
        brandLbl.text = "Brand :- \(product?.brand ?? "")"
        stockLbl.text = String("Stocks :- \(product?.stock ?? 0)")
        productImage.setImage(
            from: product?.image ?? "",
            placeholder: UIImage(named: "placeholder")
        )
        productImage.applyStyle(cornerRadius: 32.0,corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner])
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
