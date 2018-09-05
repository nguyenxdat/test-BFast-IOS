//
//  GetListTodoTask.swift
//  Todo List
//
//  Created by Dat Nguyen on 9/5/18.
//  Copyright © 2018 Dat Nguyen. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class GetListTodoTask: BaseTask<Array<ItemTodo>> {
    
    override func onResponse(response: JSON) -> Array<ItemTodo> {
        var listTodo = Array<ItemTodo>()
        let arrTodo = response.arrayValue
        for objTodo in arrTodo {
            let itemTodo = ItemTodo()
            itemTodo.title = objTodo["title"].stringValue
            itemTodo.isComplete = objTodo["complete"].boolValue
            listTodo.append(itemTodo)
        }
        return listTodo
    }
    
    override func method() -> HTTPMethod {
        return HTTPMethod.get
    }
    
    override func api() -> String {
        return String(format: NetworkConfig.Api.list_todo, self.getUserId())
    }
    
    override func parameters() -> Parameters? {
        return [:]
    }
    
}
