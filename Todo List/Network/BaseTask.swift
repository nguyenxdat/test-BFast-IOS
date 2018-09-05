//
//  BaseTask.swift
//  Todo List
//
//  Created by Dat Nguyen on 9/5/18.
//  Copyright © 2018 Dat Nguyen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BaseTask<T> {
    
    var blockSuccess : ((_ result: T) -> Void)!
    var blockFailure : ((_ errorCode: Int?, _ errorMessage: String?) -> Void)?
    
    public func requestAPI(blockSuccess: @escaping (_ result: T?) -> Void ,
                           blockFailure: @escaping (_ errorCode: Int?, _ errorMessage: String?) -> Void) {
        self.blockSuccess = blockSuccess
        self.blockFailure = blockFailure
        
        let headers: HTTPHeaders = self.getDefaultHeaders()
        let method: HTTPMethod = self.method()
        let url:URLConvertible = self.genURL()
        let params:Parameters? = self.parameters()
        let encoding: ParameterEncoding = method == HTTPMethod.get ? URLEncoding.default : JSONEncoding.default
        
        Alamofire.request(url,
                          method: method,
                          parameters: params,
                          encoding: encoding,
                          headers: headers).responseJSON { (response :DataResponse<Any>) in
                            self.handleResponse(response)
        }
    }

    private func handleResponse(_ response: DataResponse<Any>) {
        switch (response.result) {
        case .success:
            self.handleSuccess(response)
            break
        case .failure(let error):
            self.handleError(error: error)
            break
        }
    }
    
    private func handleError(error: Error) {
        if error._code == NSURLErrorTimedOut {
            self.blockFailure!(NetworkConfig.Code.timeout, "Timeout")
        } else if error._code == NSURLErrorNotConnectedToInternet {
            self.blockFailure!(NetworkConfig.Code.noConnection, "No connection")
        }else {
            self.blockFailure!(9999, error.localizedDescription)
            print("\n\nAuth request failed with error:\n \(error)")
        }
    }
    
    private func handleSuccess(_ response: DataResponse<Any>) {
        if(response.error == nil){
            guard let json = try? JSON(data: response.data!) else {
                self.blockFailure!(9999, "Parse Failed")
                return
            }
            print("Data rereived ", json)
            let error = json["error"]
            if error == JSON.null {
                let result = self.onResponse(response: json)
                print("Go to success block")
                self.blockSuccess!(result)
            } else {
                let statusCode = error["statusCode"].intValue
                let message = error["message"].stringValue
                print("Go to error block")
                self.blockFailure!(statusCode, message)
            }
        } else {
            self.blockFailure!(9999, "Request failure")
        }
    }
    
    func genURL() -> String {
        let api: String = self.api()
        let url: String = String.init(format: "%@/%@", NetworkConfig.DOMAIN, api)
        print("API requesting ", url)
        return url
    }
    
    func getDefaultHeaders() -> HTTPHeaders {
        return [
            "Content-type": "application/json",
            "Authorization" : self.getAccessToken() == nil ? "" : self.getAccessToken()!
        ]
    }
    
    func saveTokenAndUserId(token: String, userId: Int) {
        UserDefaults.standard.set(token, forKey: Constant.ACCESS_TOKEN)
        UserDefaults.standard.set(userId, forKey: Constant.USER_ID)
        UserDefaults.standard.set(true, forKey: Constant.LOGIN_SUCCESS)
        UserDefaults.standard.synchronize()
    }
    
    func getUserId() -> Int {
        return UserDefaults.standard.integer(forKey: Constant.USER_ID)
    }
    
    func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: Constant.ACCESS_TOKEN)
    }
    
    open func method() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    open func api() -> String {
        preconditionFailure("This method must be overridden")
    }
    
    open func parameters() -> Parameters? {
        preconditionFailure("This method must be overridden")
    }
    
    open func onResponse(response :JSON) -> T {
        preconditionFailure("This method must be overridden")
    }

}
