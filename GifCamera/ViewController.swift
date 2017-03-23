//
//  ViewController.swift
//  GifCamera
//
//  Created by Michal Jach on 3/23/17.
//  Copyright © 2017 Michal Jach. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSWindowDelegate {
    var isRecording = false
    var filePath = ""
    
    @IBOutlet weak var sizeLabel: NSTextField!
    @IBOutlet weak var previewView: PreviewView!
    @IBOutlet weak var recordButton: NSButton!
    
    @IBAction func recordButtonPressed(_ sender: Any) {
        if(isRecording) {
            isRecording = false
        } else {
            let savePanel = NSSavePanel()
            savePanel.allowedFileTypes = ["gif"]
            savePanel.beginSheetModal(for: self.view.window!, completionHandler: { (result: Int) -> Void in
                if result == NSFileHandlingPanelOKButton {
                    self.isRecording = true
                    self.filePath = (savePanel.url?.absoluteString)!
                    print(self.filePath)
                }
            })
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
