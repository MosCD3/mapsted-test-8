//
//  LogService.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import UIKit


enum ErrorType {
    case criticalError
    case warningError
    case logicalError
    case unknownError
    case timoutError
    case apiError
    case apiStatusError
    case webViewError
    case parsingError
    case minor
}

enum LogType {
    case critical
    case minor
    case verbose
    case apiResponse
    case appFlow
}

class LogService {
    
    let e_suffix: String = "ERROR!:"
    let l_suffix: String = "Log!:"
    
    
    //TODO: prevent recruisive infinite looping if error captured inside error
    func error (message: String , type: ErrorType = .logicalError) {
        let message = "\(e_suffix)[\(type)] \(message)"
        print(message)
        
    }
    
    func log(message: String , type: LogType = .minor)  {
        let f_message = "\(l_suffix)[\(type)] \(message)"
        print(f_message)
    }
    
    
    init() {
        
    }

    //MARK: Singleton
    static let shared :LogService = LogService()
    
}
