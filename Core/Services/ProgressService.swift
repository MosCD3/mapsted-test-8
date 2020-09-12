//
//  ProgressService.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import Foundation
import SVProgressHUD


class ProgressService {
    
    private var isDisplayed: Bool = false
    
    func show(message: String? = nil) {
        
        if let status = message {
            SVProgressHUD.show(withStatus: status)
        } else {
            SVProgressHUD.show()
        }
    }
    
    func hide() {
        isDisplayed = false
        SVProgressHUD.dismiss()
    }
    //MARK: Singleton
    static let shared = ProgressService()
}
