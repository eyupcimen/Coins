//
//  ImageStore.swift
//  Coins
//
//  Created by eyup cimen on 26.02.2022.
//

import Foundation
import UIKit

class ImageStore {
    
    let cache = NSCache<NSString, UIImage>()
    
    func setImage(image: UIImage, forKey: String) {
        cache.setObject(image, forKey: forKey as NSString)
    }
    
    func getImage(forKey: String) -> UIImage? {
        return cache.object(forKey: forKey as NSString)
    }
    
    func delete(forKey: String) {
        // Maybe it can be use
        return cache.removeObject(forKey: forKey as NSString)
    }
}
