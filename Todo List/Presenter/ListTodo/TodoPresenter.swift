//
//  TodoPresenter.swift
//  Todo List
//
//  Created by Dat Nguyen on 9/5/18.
//  Copyright © 2018 Dat Nguyen. All rights reserved.
//

import UIKit

protocol TodoView: BaseView {
    func didLoadListTodoSuccess(listItem: Array<ItemTodo>)
    func didLoadListTodoFailure(errorCode: Int, errorMessage: String)
    func didCreateTodoSuccess(data: ItemTodo)
    func didCreateTodoFailure(errorCode: Int, errorMessage: String)
}

class TodoPresenter: BasePresenter {

    private var view : TodoView!
    
    init(view : TodoView) {
        super.init(baseView: view)
        self.view = view
    }
    
    func loadListTodo() {
        let task = GetListTodoTask()
        task.requestAPI(blockSuccess: { [unowned self] (data) in
            self.view.didLoadListTodoSuccess(listItem: data!)
        }) { [unowned self] (errorCode, errorMessage) in
            self.view.didLoadListTodoFailure(errorCode: errorCode!, errorMessage: errorMessage!)
        }
    }
    
    func createTodo(data: ItemTodo) {
        let task = CreateTodoTask(data: data)
        task.requestAPI(blockSuccess: { [unowned self] (data) in
            self.view.didCreateTodoSuccess(data: data!)
        }) { [unowned self] (errorCode, errorMessage) in
            self.view.didCreateTodoFailure(errorCode: errorCode!, errorMessage: errorMessage!)
        }
    }
    
}
