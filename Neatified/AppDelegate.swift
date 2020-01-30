//
//  AppDelegate.swift
//  Neatified
//
//  Created by Helloyunho on 2020/01/29.
//  Copyright © 2020 Helloyunho. All rights reserved.
//

import Cocoa
import SwiftUI
import SafariServices
import Sparkle
import AppMover

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    let userState = UserState()
    
    
    func applicationWillBecomeActive(_ notification: Notification) {
        SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: "xyz.helloyunho.Neatified.Neatified-Safari") { (statee, error) in
            if (statee?.isEnabled ?? false) {
                DispatchQueue.main.async {
                    self.userState.extensionEnabled = true
                }
            } else {
                DispatchQueue.main.async {
                    self.userState.extensionEnabled = false
                }
            }
        }
        if let userDefaults = UserDefaults(suiteName: "32Z9KZZ4PU.Neatified") {
            if userDefaults.integer(forKey: "level") == 0 {
                userDefaults.set(1, forKey: "level")
                userDefaults.synchronize()
            }
        }
    }
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        AppMover.moveIfNecessary()
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView().environmentObject(self.userState)

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 275, height: 535),
            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func checkForUpdates(_ sender: Any) {
        let updater = SUUpdater.shared()
        updater?.feedURL = URL(string: "https://s3.ap-northeast-2.amazonaws.com/xyz.helloyunho.neatified/appcast.xml")
        updater?.checkForUpdates(self)
    }


}

