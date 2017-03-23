//
//  WindowController.swift
//  GifCamera
//
//  Created by Michal Jach on 3/23/17.
//  Copyright © 2017 Michal Jach. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        self.window?.isOpaque = false
        self.window?.level = Int(CGWindowLevelForKey(.floatingWindow))
    }
}
