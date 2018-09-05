//
//  ExtensionView.swift
//  Todo List
//
//  Created by Dat Nguyen on 9/5/18.
//  Copyright © 2018 Dat Nguyen. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

protocol XibLoadable {
    associatedtype CustomViewType
    static func loadFromXib() -> CustomViewType
}

extension XibLoadable where Self: UIView {
    static func loadFromXib() -> Self {
        let nib = UINib(nibName: "\(self)", bundle: Bundle.main)
        guard let customView = nib.instantiate(withOwner: self, options: nil).first as? Self else {
            preconditionFailure("Couldn't load xib for view: \(self)")
        }
        return customView
    }
}
