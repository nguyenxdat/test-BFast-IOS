//
//  StoryBoardHelper.swift
//  Todo List
//
//  Created by Dat Nguyen on 9/5/18.
//  Copyright © 2018 Dat Nguyen. All rights reserved.
//

import UIKit

class StoryBoardHelper: NSObject {
    
    public func getInitialViewController() -> UIViewController {
        let storyboardName = self.storyBoardName()
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
    }
    
    public func getViewControllerByIdentifier(identifier : String) -> UIViewController {
        let storyboardName = self.storyBoardName()
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    func storyBoardName() -> String {
        return ""
    }
    
}

class MainStoryboard: StoryBoardHelper {
    override func storyBoardName() -> String {
        return "Main"
    }
}

class LoginStoryboard: StoryBoardHelper {
    override func storyBoardName() -> String {
        return "Login"
    }
}
