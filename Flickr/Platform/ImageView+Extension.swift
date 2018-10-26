//
//  ImageView+Extension.swift
//  Flickr
//
//  Created by Nagarjuna on 26/10/2018.
//  Copyright © 2018 Universe. All rights reserved.
//

import Foundation
import UIKit

var imageCache = NSCache<NSString, AnyObject>()

public extension UIImageView {

    func setImageViewWithUrl(url: URL) {
        self.tag = url.hashValue
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        DispatchQueue.global().async {
            let imageURL = url
            let imageData = try? Data(contentsOf:url)
            let image = UIImage(data: imageData!)
            imageCache.setObject(image!, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                if self.tag == imageURL.hashValue {
                    self.image  = image
                }
            }
        }
    }
}
