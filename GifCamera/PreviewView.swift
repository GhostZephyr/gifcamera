//
//  PreviewView.swift
//  GifCamera
//
//  Created by Michal Jach on 3/23/17.
//  Copyright © 2017 Michal Jach. All rights reserved.
//

import Cocoa

class PreviewView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        NSRectFillUsingOperation(self.bounds, NSCompositeClear)
    }
}
