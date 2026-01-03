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
        productCellView.layer.cornerRadius = 10 
        
        
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
