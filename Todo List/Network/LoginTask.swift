//
//  LoginTask.swift
//  Todo List
//
//  Created by Dat Nguyen on 9/5/18.
//  Copyright © 2018 Dat Nguyen. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class LoginTask: BaseTask<Bool> {
    
    private var email: String!
    private var password: String!
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    override func onResponse(response: JSON) -> Bool {
        let accessToken = response["id"].stringValue
        let userId = response["userId"].intValue
        self.saveTokenAndUserId(token: accessToken, userId: userId)
        return true
    }
    
    override func method() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func api() -> String {
        return NetworkConfig.Api.login
    }
    
    override func parameters() -> Parameters? {
        return ["email": email,
                "password" : password]
    }

}
