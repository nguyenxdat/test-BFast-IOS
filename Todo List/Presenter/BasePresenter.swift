//
//  BasePresenter.swift
//  Todo List
//
//  Created by Dat Nguyen on 9/5/18.
//  Copyright © 2018 Dat Nguyen. All rights reserved.
//

import UIKit

@objc protocol BaseView {
    
}

class BasePresenter: NSObject {
    
    private var blockFailure :((_ errorCode :Int?, _ errorMessage :String?) -> Void)?
    
    private var baseView : BaseView!
    
    init(baseView : BaseView) {
        self.baseView = baseView
    }
    
    func requestAPI<T : Any>(api : BaseTask <T> ,
                             blockSuccess :@escaping (_ result :T) -> Void,
                             blockFailure : @escaping (_ errorCode :Int?,_ errorMessage :String?) -> Void) {
        api.requestAPI(blockSuccess: { (data) in
            blockSuccess(data!)
        }) { (errorCode, errorMessage) in
            blockFailure(errorCode, errorMessage)
        }
    }
    
}
