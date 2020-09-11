//
//  UIConfiguration.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/10/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import Foundation

import UIKit


protocol UIConfigurationProtocol {
    var homeImage: UIImage {get}
}

class UIConfiguration: UIConfigurationProtocol {

    let homeImage = UIImage.localImage("home-icon", template: true)
 

    func configureUI() {
        
        //MARK: Configure basic UI here
    }
}
