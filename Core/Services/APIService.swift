//
//  APIService.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


protocol APIServiceProtocol {
    
}
class APIService: APIServiceProtocol {
    
    public init() {
        
    }
    
    
    //MARK: Private methods
    private func logMessage(msg: String, type: LogType = .verbose ) {
        LogService.shared.log(message: msg, type: type)
    }
    
    private func showProgress() {
        print("Showing progress ..")
        ProgressService.shared.show()
    }
    
    private func hideProgress() {
        print("Hiding progress ..")
        ProgressService.shared.hide()
    }
    
    //MARK: Public methods
    
    func postData(endpoint: APIUri, parameters: [String: String] = [String:String](),  callback: @escaping ( ApiResponse ) -> Void) {
        
        
        
        
        guard let url = endpoint.uri else {
            LogService.shared.error(message: "Cannot find uri for endpoint: \(endpoint)", type: .criticalError)
            callback(ApiResponse(data: nil, error: "Cannot find uri for endpoint: \(endpoint)", message: "A logical error occured, please contact admin. (EAPS52)"))
            return
        }
        
        logMessage(msg: "~~ APIServiceCalled to post data for:\(url)")
        
        if !Utils.isInternetConnected() {
            logMessage(msg: "No internet connection")
            //If we are offline, and we have a version of this called found in cache, return this version
            
            logMessage(msg: "No data found, displaying alert to user ..")
            //else check internet connection
            let _title = "Attention"
            let _titleDismiss = "Cancel"
            let _titleConf = "Retry"
            let _message = "Please check you internet connectivity"
            
            AlertService.shared.displayConfirmAlert(title: _title, titleDismiss: _titleDismiss, titleConfirm: _titleConf, message: _message) {
                isRetry in
                if isRetry {
                    self.postData(endpoint: endpoint, parameters: parameters, callback: callback)
                }
            }
            return
        }
        
        
        //MARK: Strating API Call
        var headers: HTTPHeaders
        
        headers = [
            "Accept": "application/json"
        ]
        
        logMessage(msg: "Headers: \(String(describing: headers))")
        
        showProgress()
        
        
        //Processing parameters before sending
        //        debugPrint("Params being sent", parameters)
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON
            {
                response in
                
                var errorFound = true
                var errorUser = "Uncaught error [164]"
                
                
                self.logMessage(msg: "Request: \(String(describing: response.request))")
                self.logMessage(msg: "Parameters: \(parameters)")
                self.logMessage(msg: "Response: \(String(describing: response.response))")
                self.logMessage(msg: "Result: \(response.result)")
                
                if let data1 = response.data {
                    
                    do
                    {
                        
                        let json = try JSON(data: data1)
//                        self.logMessage(msg: "Result JSON: \(json)", type: .apiResponse)
                        
                        //First check status of call
                        callback(ApiResponse(data: json, error: nil, message: nil))
                    }
                    catch {
                        LogService.shared.error(message: "couldn't read data -> \(error.localizedDescription)", type: .apiError)
                        errorUser = "Service is not responding, please retry later or contact support [198]"
                    }
                }
                else {
                    LogService.shared.error(message: "ApiService responded with nill data", type: .apiError)
                    errorUser = "Service is down, please retry later or contact support"
                    errorFound = true
                }
                
                if errorFound {
                    callback(ApiResponse(data: nil, message: errorUser, popUpHandled: false))
                }
                self.hideProgress()
        }
    }
}
