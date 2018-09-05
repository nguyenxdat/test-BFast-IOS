//
//  LoginViewController.swift
//  Todo List
//
//  Created by Dat Nguyen on 9/5/18.
//  Copyright © 2018 Dat Nguyen. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lblForgotPassword: UILabel!
    
    private var presenter: LoginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblForgotPassword.setUnderLine(text: "Forgot your passwrod?", UIFont.systemFont(ofSize: 17.0), UIColor.init(hexString: "#0000EE"))
        initPresenter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initPresenter() {
        presenter = LoginPresenter(view: self)
    }
    
    @IBAction func handleActionLogin(_ sender: Any) {
        if checkValidate() {
            login()
        }
    }
    
    private func login() {
        showWaitingDialog()
        presenter.login(email: tfEmail.text!, password: tfPassword.text!)
    }
    
    private func checkValidate() -> Bool {
        if (tfEmail.text?.isEmpty)! {
            showToast(message: "You must enter email")
            return false
        }
        if (tfPassword.text?.isEmpty)! {
            showToast(message: "You must enter your password")
            return false
        }
        if !isValid(tfEmail.text!) {
            showToast(message: "Email invalidate")
            return false
        }
        return true
    }
    
    private func isValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
        "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
        "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
        "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
        "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController: LoginView {
    
    func didLoginSuccess() {
        self.hideWaitingDialog()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setupRootViewController()
    }
    
    func didLoginFailure(errorCode: Int, errorMessage: String) {
        self.hideWaitingDialog()
        self.showToast(errorCode: errorCode, errorMessage: errorMessage)
    }
}
