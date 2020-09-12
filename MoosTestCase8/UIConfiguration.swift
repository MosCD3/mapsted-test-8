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
    var sectionHeaderBackground: UIColor {get}
    var cellBackground: UIColor {get}
    var dropdownCellBackground: UIColor {get}
    
}

class UIConfiguration: UIConfigurationProtocol {
    var sectionHeaderBackground: UIColor {
        return UIColor(hexString: "#A4EBF5")
    }
    
    var cellBackground: UIColor {
        return UIColor(hexString: "#F3F3F3")
    }
    
    var dropdownCellBackground: UIColor {
        return UIColor(hexString: "#CFD8DC")
    }
    
    
}
