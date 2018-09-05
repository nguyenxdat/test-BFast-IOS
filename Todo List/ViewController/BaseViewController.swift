//
//  BaseViewController.swift
//  Todo List
//
//  Created by Dat Nguyen on 9/5/18.
//  Copyright © 2018 Dat Nguyen. All rights reserved.
//

import UIKit
import JGProgressHUD
import Toast_Swift

class BaseViewController: UIViewController {

    private var hud : JGProgressHUD?
    private var rootAlertView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Public Function
    func showWaitingDialog(_ title : String = "Loading...") {
        makeRootAlertView()
        hud = JGProgressHUD(style: .light)
        hud?.textLabel.text = title
        hud?.delegate = self
        hud?.show(in: self.rootAlertView!)
    }
    
    func hideWaitingDialog() {
        hud?.dismiss()
    }
    
    func showToast(message: String) {
        self.view.makeToast(message, duration: ToastManager.shared.duration, position: .center)
    }
    
    func showToast(errorCode: Int, errorMessage: String) {
        self.view.makeToast(errorMessage, duration: ToastManager.shared.duration, position: .center)
    }
    
    // MARK: - Private Function
    private func makeRootAlertView() {
        let window = UIApplication.shared.keyWindow!
        if rootAlertView == nil {
            rootAlertView = UIView(frame: CGRect(x: window.frame.origin.x, y: window.frame.origin.y, width: window.frame.width, height: window.frame.height))
        }
        window.addSubview(rootAlertView!);
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

extension BaseViewController: JGProgressHUDDelegate {
    func progressHUD(_ progressHUD: JGProgressHUD, didDismissFrom view: UIView) {
        rootAlertView?.removeFromSuperview()
    }
}
