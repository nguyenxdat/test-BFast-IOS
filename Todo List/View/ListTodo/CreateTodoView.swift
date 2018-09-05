//
//  CreateTodoView.swift
//  Todo List
//
//  Created by Dat Nguyen on 9/5/18.
//  Copyright © 2018 Dat Nguyen. All rights reserved.
//

import UIKit
import SnapKit
import Toast_Swift

class CreateTodoView: UIView, XibLoadable {
    
    @IBOutlet weak var tfTodo: UITextField!
    
    private var blockSave: ((_ data: ItemTodo) -> Void)!
    private var blockShowToast: ((_ message: String) -> Void)!

    public static func show(blockSave: ((_ data: ItemTodo) -> Void)!,
                            blockShowToast: ((_ message: String) -> Void)!) -> CreateTodoView {
        let window = UIApplication.shared.keyWindow!
        let rootView = UIView(frame: CGRect(x: window.frame.origin.x, y: window.frame.origin.y, width: window.frame.width, height: window.frame.height))
        window.addSubview(rootView);
        
        let createTodoView = CreateTodoView.loadFromXib()
        createTodoView.blockSave = blockSave
        createTodoView.blockShowToast = blockShowToast
        rootView.addSubview(createTodoView)
        createTodoView.snp.makeConstraints { (_ make : ConstraintMaker) in
            make.edges.equalTo(rootView)
        }
        return createTodoView
    }
    
    @IBAction func handleCancelAction(_ sender: Any) {
        dissmissView()
    }
    
    @IBAction func handleSaveAction(_ sender: Any) {
        if checkValidate() {
            dissmissView()
            let itemTodo = ItemTodo()
            itemTodo.title = tfTodo.text!
            blockSave(itemTodo)
        }
    }
    
    private func checkValidate() -> Bool {
        if (tfTodo.text?.isEmpty)! {
            self.makeToast("Todo's name not empty", duration: ToastManager.shared.duration, position: .center)
            return false
        }
        return true
    }
    
    private func dissmissView() {
        self.superview?.removeFromSuperview()
    }
}
