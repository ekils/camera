//
//  bluecamera.swift
//  lens
//
//  Created by 劉 家寯 on 7/8/16.
//  Copyright © 2016 劉 家寯. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import AssetsLibrary

//,AVCaptureFileOutputRecordingDelegate

class bluecamera: UIViewController, AVCaptureFileOutputRecordingDelegate, AVCaptureVideoDataOutputSampleBufferDelegate,UICollectionViewDelegate,  AVPlayerViewControllerDelegate {
    

    @IBOutlet weak var recordBtn: UIButton!
    
    @IBOutlet weak var preView: UIView!

    var output:AVCaptureMovieFileOutput!
    
    //    var timer:NSTimer?
    var recordingInProgress = false

    
    
    
    @IBAction func goback1(sender: AnyObject) {
        self.performSegueWithIdentifier("goback1", sender: nil)
    }
    



    
    @IBAction func record(sender: AnyObject) {
        
        if recordingInProgress {
           
            output.stopRecording()
            
        }else{
    
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
            let date = NSDate()
            let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
            let outputPath = "\(documentsPath)/\(formatter.stringFromDate(date)).mp4"
            let outputURL = NSURL(fileURLWithPath: outputPath)
            output.startRecordingToOutputFileURL(outputURL, recordingDelegate: self)
                  }
        
        recordingInProgress = !recordingInProgress
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        setupCameraSession()
        let imagename = "black"
        let image = UIImage(named: imagename)
        let imageview = UIImageView(image: image!)
        //let screenSize:CGRect = UIScreen.mainScreen().bounds
        imageview.frame = CGRect(x: 0, y: 0, width: self.preView.bounds.width,
                                             height: 1000)
     
        preView.addSubview(imageview)
        preView.bringSubviewToFront(imageview)
        imageview.layer.zPosition = CGFloat.max
        imageview.alpha = 0.3
        //imagepicker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Off
        UIScreen.mainScreen().brightness = CGFloat(0.5)
//
//        //beginSession()
//        
  
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        preView.layer.addSublayer(previewLayer)
        cameraSession.startRunning()

    }
    
    
    
    
    
    lazy var cameraSession: AVCaptureSession = {
        let s = AVCaptureSession()
        s.sessionPreset = AVCaptureSessionPresetHigh
        return s
    }()
    
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let preview =  AVCaptureVideoPreviewLayer(session: self.cameraSession)
        preview.bounds = CGRect(x: 0, y: 0, width: self.preView.bounds.width, height: self.preView.bounds.height)
        preview.position = CGPoint(x: CGRectGetMidX(self.preView.bounds), y: CGRectGetMidY(self.preView.bounds))
        preview.videoGravity = AVLayerVideoGravityResize
        return preview
    }()
    
    func setupCameraSession() {
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo) as AVCaptureDevice
        
        do {
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            cameraSession.beginConfiguration()
            
            if (cameraSession.canAddInput(deviceInput) == true) {
                cameraSession.addInput(deviceInput)
            }
            
            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(unsignedInt: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            dataOutput.alwaysDiscardsLateVideoFrames = true
            
            if (cameraSession.canAddOutput(dataOutput) == true) {
                cameraSession.addOutput(dataOutput)
            }
            
            cameraSession.commitConfiguration()
            
            let queue = dispatch_queue_create("com.invasivecode.videoQueue", DISPATCH_QUEUE_SERIAL)
            dataOutput.setSampleBufferDelegate(self, queue: queue)
            
        }
        catch let error as NSError {
            NSLog("\(error), \(error.localizedDescription)")
        }
//        let image = UIImage(named: "cam-camera-record-video-film-movie-round-512")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
//
//        recordBtn.setImage(image, forState: UIControlState.Normal)
//        
//        recordBtn.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {

    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {
    }
 
    


}
