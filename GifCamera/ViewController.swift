//
//  ViewController.swift
//  GifCamera
//
//  Created by Michal Jach on 3/23/17.
//  Copyright © 2017 Michal Jach. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSWindowDelegate {
    let isRecording = false
    
    @IBOutlet weak var sizeLabel: NSTextField!
    @IBOutlet weak var previewView: PreviewView!
    @IBOutlet weak var recordButton: NSButton!
    
    @IBAction func recordButtonPressed(_ sender: Any) {
        if(isRecording) {
            
        } else {
            let savePanel = NSSavePanel()
            savePanel.allowedFileTypes = ["gif"]
            savePanel.begin { (result: Int) -> Void in
                if result == NSFileHandlingPanelOKButton {
                    let exportedFileURL = savePanel.url
                    print(exportedFileURL)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        NSApplication.shared().windows.first?.delegate = self
    }
    
    func windowWillResize(_ sender: NSWindow, to frameSize: NSSize) -> NSSize {
        sizeLabel.stringValue = "\(Int(previewView.frame.size.width)) x \(Int(previewView.frame.size.height))"
        
        return frameSize
    }
}
