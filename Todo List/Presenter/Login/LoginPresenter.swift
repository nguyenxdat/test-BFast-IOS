//
//  LoginPresenter.swift
//  Todo List
//
//  Created by Dat Nguyen on 9/5/18.
//  Copyright © 2018 Dat Nguyen. All rights reserved.
//

import UIKit

protocol LoginView: BaseView {
    func didLoginSuccess()
    func didLoginFailure(errorCode: Int, errorMessage: String)
}

class LoginPresenter: BasePresenter {
    
    private var view : LoginView!
    
    init(view : LoginView) {
        super.init(baseView: view)
        self.view = view
    }
    
    func login(email: String, password: String) {
        let task = LoginTask(email: email, password: password)
        task.requestAPI(blockSuccess: { [unowned self] (sucesss) in
            self.view.didLoginSuccess()
        }) { [unowned self] (errorCode, errorMessage) in
            self.view.didLoginFailure(errorCode: errorCode!, errorMessage: errorMessage!)
        }
    }
    
}
