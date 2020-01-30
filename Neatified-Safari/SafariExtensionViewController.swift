//
//  SafariExtensionViewController.swift
//  Neatified-Safari
//
//  Created by Helloyunho on 2020/01/29.
//  Copyright © 2020 Helloyunho. All rights reserved.
//

import SafariServices
import SwiftUI

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:275, height:535)
        shared.view = NSHostingView(rootView: ExtensionView())
        return shared
    }()
    
    func popoverViewController() -> SafariExtensionViewController {
        return SafariExtensionViewController.shared
    }
}
