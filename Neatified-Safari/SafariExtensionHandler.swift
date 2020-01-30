//
//  SafariExtensionHandler.swift
//  Neatified-Safari
//
//  Created by Helloyunho on 2020/01/29.
//  Copyright © 2020 Helloyunho. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        if messageName == "getLevel" {
            if let userDefaults = UserDefaults(suiteName: "32Z9KZZ4PU.Neatified") {
                if userDefaults.integer(forKey: "level") == 0 {
                    userDefaults.set(1, forKey: "level")
                    userDefaults.synchronize()
                    page.dispatchMessageToScript(withName: "gotLevel", userInfo: ["level": 1])
                } else {
                    page.dispatchMessageToScript(withName: "gotLevel", userInfo: ["level": userDefaults.integer(forKey: "level")])
                }
            }
        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        NSLog("The extension's toolbar item was clicked")
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

}
