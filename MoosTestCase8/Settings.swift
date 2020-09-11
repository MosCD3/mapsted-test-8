//
//  Settings.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/10/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

public protocol SettingsProtocol {
    var isAdmin: Bool {get}
}

class Settings: SettingsProtocol {
    
    

    var isAdmin: Bool {
        get {
            return true
        }
    }
    
    public static let apiBase: String = "http://positioning-test.mapsted.com/api/Values"
    
    init() {
        
    }

}
