//
//  GifEngine.swift
//  GifCamera
//
//  Created by Michał Jach on 23/03/2017.
//  Copyright © 2017 Michal Jach. All rights reserved.
//

import Cocoa
import AVFoundation
import Regift

class GifEngine: NSObject, AVCaptureFileOutputRecordingDelegate {
    var destinationUrl: NSURL
    var tempPath = NSTemporaryDirectory() + "gifcam.mp4"
    var session: AVCaptureSession?
    var movieFileOutput: AVCaptureMovieFileOutput?
    var viewPosition: CGRect
    var fps: Int
    
    public var destination: NSURL {
        get {
            return self.destinationUrl
        }
    }
    
    public var position: CGRect {
        get {
            return self.viewPosition
        }
    }
    
    public init(destination: NSURL, position: CGRect, fps: Int) {
        self.destinationUrl = destination
        self.viewPosition = position
        self.fps = fps
        
        self.session = AVCaptureSession()
        self.session?.sessionPreset = AVCaptureSessionPresetHigh
        
//        for(node in NSScreen.screens()) {
//            
//        }
        
        let displayId: CGDirectDisplayID = CGMainDisplayID()
        
        let input: AVCaptureScreenInput = AVCaptureScreenInput(displayID: displayId)
        input.cropRect = position
        input.scaleFactor = 1 // retina thing
        
        if ((self.session?.canAddInput(input)) != nil) {
            self.session?.addInput(input)
        }
        
        self.movieFileOutput = AVCaptureMovieFileOutput()
        
        
        if ((self.session?.canAddOutput(self.movieFileOutput)) != nil) {
            self.session?.addOutput(self.movieFileOutput)
        }
        
        let fileManager = FileManager.default
        
        do {
            try fileManager.removeItem(atPath: (tempPath))
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
    
    public func start() {
        self.session?.startRunning()
        self.movieFileOutput?.startRecording(toOutputFileURL: NSURL.fileURL(withPath: tempPath), recordingDelegate: self)
    }
    
    public func stop() {
        self.movieFileOutput?.stopRecording()
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        self.session?.stopRunning()
        self.session = nil
        createGif()
    }
    
    func createGif() {
        let regift = Regift(sourceFileURL: NSURL.fileURL(withPath: tempPath) as URL, destinationFileURL: destinationUrl as URL, startTime: 0, frameRate: self.fps, loopCount: 0)
        
        print("Gif saved to \(regift.createGif())")
    }
}
