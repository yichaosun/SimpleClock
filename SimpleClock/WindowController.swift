//
//  WindowController.swift
//  SimpleClock
//
//  Created by 曾天宇 on 25/01/2018.
//  Copyright © 2018 曾天宇. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    @IBOutlet weak var SecondChanger: NSSegmentedControl!
    
    @IBAction func ChangeSecond(_ sender: NSSegmentedControl) {
        let rootViewController = NSApplication.shared.mainWindow?.windowController?.contentViewController as! ViewController
        rootViewController.SecondChanger.performClick(nil)
        
    }
    
    @IBAction func DarkLight(_ sender: Any) {
        let rootViewController = NSApplication.shared.mainWindow?.windowController?.contentViewController as! ViewController
        rootViewController.NightModeChange.performClick(nil)
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
}
