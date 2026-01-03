//
//  Extensions.swift
//  GeekTrustAssignmentDemo
//
//  Created by Dheeraj Chauhan on 03/01/26.
//

import Foundation
import UIKit

private let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func setImage(
        from urlString: String?,
        placeholder: UIImage? = UIImage(named: "placeholder")
    ) {
        // Set placeholder immediately
        DispatchQueue.main.async {
            self.image = placeholder
        }

        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            return
        }

        // Return cached image if available
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }

        // Download image
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self,
                  let data,
                  error == nil,
                  let image = UIImage(data: data) else {
                return
            }

            // Cache image
            imageCache.setObject(image, forKey: urlString as NSString)

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}

extension UIView {

    /// Apply rounded corners (all or specific) with optional shadow
    func applyStyle(
        cornerRadius: CGFloat = 12,
        corners: CACornerMask = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ],
        shadowColor: UIColor = .gray,
        shadowOpacity: Float = 0.15,
        shadowOffset: CGSize = CGSize(width: 0, height: 4),
        shadowRadius: CGFloat = 2
    ) {

        // Corner radius
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = corners
        layer.masksToBounds = false

        // Shadow
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
    }

    /// Remove shadow (useful for reuse)
    func removeShadow() {
        layer.shadowOpacity = 0
    }
}
