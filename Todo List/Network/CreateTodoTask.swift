//
//  CreateTodoTask.swift
//  Todo List
//
//  Created by Dat Nguyen on 9/5/18.
//  Copyright © 2018 Dat Nguyen. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class CreateTodoTask: BaseTask<ItemTodo> {
    
    private var itemTodo: ItemTodo!
    private var userId: Int!
    
    init(data: ItemTodo) {
        super.init()
        self.itemTodo = data
        self.userId = self.getUserId()
    }
    
    override func onResponse(response: JSON) -> ItemTodo {
        let itemTodo = ItemTodo()
        itemTodo.title = response["title"].stringValue
        itemTodo.isComplete = response["complete"].boolValue
        return itemTodo
    }
    
    override func method() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func api() -> String {
        return String(format: NetworkConfig.Api.create_todo, userId)
    }
    
    override func parameters() -> Parameters? {
        return ["title": itemTodo.title,
                "complete": itemTodo.isComplete,
                "accountId": userId]
    }
    
}
