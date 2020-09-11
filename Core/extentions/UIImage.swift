//
//  UIImage.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/10/20.
//  Copyright © 2020 Phzio. All rights reserved.
//
import UIKit

extension UIImage {
    static func localImage(_ name: String, template: Bool = false) -> UIImage {
        
        guard let _image = UIImage(named: name)  else {
            print("Error, cannot find image named:\(name)")
            return UIImage()
        }
        
        var image = _image
        
        if template {
            image = image.withRenderingMode(.alwaysTemplate)
        }
        return image
    }
}
