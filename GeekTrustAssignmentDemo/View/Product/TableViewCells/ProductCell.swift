//
//  ProductCell.swift
//  GeekTrustAssignmentDemo
//
//  Created by Dheeraj Chauhan on 03/01/26.
//

import UIKit
import Foundation

class ProductCell: UITableViewCell {

    @IBOutlet weak var productCellView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productImage.layer.cornerRadius = 10
    }
 
    func cellSetup(product: Product) {
        self.titleLbl.text = product.title
        self.descriptionLbl.text = product.description
        self.categoryLbl.text = product.category
        self.priceLbl.text = "$\(product.price)"

        self.productCellView.applyStyle(cornerRadius: 12)
        
        self.productImage.setImage(
            from: product.image,
            placeholder: UIImage(named: "logo")
        )
    }

}
