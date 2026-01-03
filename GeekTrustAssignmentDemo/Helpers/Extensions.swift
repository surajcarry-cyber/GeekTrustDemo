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
        placeholder: UIImage? = UIImage(named: "logo")
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
