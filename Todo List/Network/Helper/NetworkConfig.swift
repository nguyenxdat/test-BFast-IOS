//
//  NetworkConfig.swift
//  Todo List
//
//  Created by Dat Nguyen on 9/5/18.
//  Copyright © 2018 Dat Nguyen. All rights reserved.
//

import UIKit

class NetworkConfig {
    
    static var DOMAIN : String = "https://api.todo.ql6625.fr/api"
    
    class Api {
        static let login = "Accounts/login"
        static let list_todo = "Accounts/%d/todos"
        static let create_todo = "Accounts/%d/todos"
    }

    class Code {
        static let success :Int = 1
        static let timeout : Int = -1001
        static let noConnection : Int = -1009
        static let errorAuth : Int = 401
        static let inputDataNilOrZeroLength : Int = 8000
        static let serverError : Int = 2
    }
}
