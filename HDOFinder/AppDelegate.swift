//
//  AppDelegate.swift
//  HDOFinder
//
//  Created by Bao (Brian) L. LE on 3/20/17.
//  Copyright © 2017 Bao (Brian) L. LE. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldOpenUntitledFile(_ sender: NSApplication) -> Bool {
        let window = NSApplication.shared().windows[0]
        window.makeKeyAndOrderFront(self)
        return false
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        let window = NSApplication.shared().windows[0]
        window.makeKeyAndOrderFront(self)
        return true
    }


}

