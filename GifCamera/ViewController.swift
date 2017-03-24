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
    var windowStyle : NSWindowStyleMask = []
    var engine : GifEngine? = nil
    
    @IBOutlet weak var sizeLabel: NSTextField!
    @IBOutlet weak var previewView: PreviewView!
    @IBOutlet weak var recordButton: NSButton!
    @IBOutlet weak var fpsInput: NSTextField!
    
    @IBAction func recordButtonPressed(_ sender: Any) {
        if(isRecording) {
            isRecording = false
            self.view.window?.hasShadow = true
            self.view.window?.styleMask = windowStyle
            engine?.stop()
            self.recordButton.title = "Start Recording"
            self.recordButton.image = NSImage(named: NSImageNameStatusNone)
        } else {
            let savePanel = NSSavePanel()
            savePanel.allowedFileTypes = ["gif"]
            savePanel.beginSheetModal(for: self.view.window!, completionHandler: { (result: Int) -> Void in
                if result == NSFileHandlingPanelOKButton {
                    self.isRecording = true
                    self.windowStyle = (self.view.window?.styleMask)!
                    self.view.window?.styleMask = NSBorderlessWindowMask
                    self.view.window?.hasShadow = false
                    self.filePath = (savePanel.url?.absoluteString)!.replacingOccurrences(of: "file://", with: "")
                    self.recordButton.title = "Stop Recording"
                    self.recordButton.image = NSImage(named: NSImageNameStatusUnavailable)
                    let cords = self.view.window?.convertToScreen(self.previewView.frame)
                    let fps = Int(self.fpsInput.stringValue)
                    self.engine = GifEngine(destination: NSURL.fileURL(withPath: self.filePath) as NSURL, position: cords!, fps: fps!)
                    self.engine?.start()
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
