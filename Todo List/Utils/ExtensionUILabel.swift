//
//  ExtensionUILabel.swift
//  Todo List
//
//  Created by Dat Nguyen on 9/5/18.
//  Copyright © 2018 Dat Nguyen. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setUnderLine(text: String, _ fontType: UIFont = UIFont.systemFont(ofSize: 16.0), _ foregroundColor: UIColor = UIColor.white) {
        let attributes : [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.font : fontType,
            NSAttributedStringKey.foregroundColor : foregroundColor,
            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue
        ]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        self.attributedText = attributedString
    }
    
}
