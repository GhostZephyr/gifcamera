//
//  GifEngine.swift
//  GifCamera
//
//  Created by Michał Jach on 23/03/2017.
//  Copyright © 2017 Michal Jach. All rights reserved.
//

import Cocoa

class GifEngine: NSObject {
    var images = [CGImage]()
    var timer = Timer()
    var previewView = NSView()
    var filePath = ""
    var position = NSRect()
    
    func startRecording(path: String, view: NSView, position: NSRect) {
        self.previewView = view
        self.filePath = path
        self.position = position
        
        timer = Timer.scheduledTimer(timeInterval: 1/30, target: self, selector: #selector(getScreenshot), userInfo: nil, repeats: true)
    }
    
    func getScreenshot() {
        let screenshot = CGDisplayCreateImage(CGMainDisplayID(), rect: self.position)
        images.append(screenshot!)
    }
    
    func createGif() {
        let destinationURL = NSURL(fileURLWithPath: self.filePath)
        let destinationGIF = CGImageDestinationCreateWithURL(destinationURL, kUTTypeGIF, images.count, nil)!
        
        let properties = [
            (kCGImagePropertyGIFDictionary as String): [(kCGImagePropertyGIFUnclampedDelayTime as String): 0]
        ]
        
        for img in images {
            CGImageDestinationAddImage(destinationGIF, img, nil)
        }
        
        CGImageDestinationFinalize(destinationGIF)
    }
}
