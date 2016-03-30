//
//  ViewController.swift
//  Paint Me
//
//  Created by Adis Mulabdic on 3/30/16.
//  Copyright © 2016 Adis Mulabdic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    
    var lastPoint = CGPoint.zero
    var red : CGFloat = 0.0
    var green : CGFloat = 0.0
    var blue : CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appResume", name: UIApplicationDidBecomeActiveNotification, object: nil)
        greenColor(UIButton())
    }
    
    func appResume() {
        self.stackView.hidden = false
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            let point = touch.locationInView(self.imageView)
            self.lastPoint = point
        }
        
        self.stackView.hidden = true
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        if let touch = touches.first {
            let point = touch.locationInView(self.imageView)
            drawLine(self.lastPoint, secondPoint: point)
                        
        }
        
        self.stackView.hidden = false
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            let point = touch.locationInView(self.imageView)
            drawLine(self.lastPoint, secondPoint: point)
            
            self.lastPoint = point
        }
        
    }
    
    func drawLine(firstPoint:CGPoint, secondPoint:CGPoint) {
        
        UIGraphicsBeginImageContext(self.imageView.frame.size)
        
        let context = UIGraphicsGetCurrentContext()
        self.imageView.image?.drawInRect(CGRect(x: 0, y: 0, width: self.imageView.frame.size.width, height: self.imageView.frame.size.height))
        CGContextMoveToPoint(context, firstPoint.x, firstPoint.y)
        CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y)
        
        //customizing :)
        CGContextSetRGBStrokeColor(context, self.red, self.green, self.blue, 1.0)
        CGContextSetLineCap(context, .Round)
        CGContextSetLineWidth(context, VALUE)
        
        
        CGContextStrokePath(context)
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    
    func eraseImage() {
        self.imageView.image = nil
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "settings" {
            let settingsVC = segue.destinationViewController as! SettingsVC
            settingsVC.drawingVC = self
        }
    }
    
    @IBAction func greenColor(sender: AnyObject) {
        self.red = 37 / 255
        self.green = 235 / 255
        self.blue = 114 / 255
    }
    
    @IBAction func redColor(sender: AnyObject) {
        self.red = 229 / 255
        self.green = 56 / 255
        self.blue = 56 / 255
    }
    
    @IBAction func blueColor(sender: AnyObject) {
        self.red = 56 / 255
        self.green = 109 / 255
        self.blue = 229 / 255
    }
    
    @IBAction func yelloColor(sender: AnyObject) {
        self.red = 249 / 255
        self.green = 215 / 255
        self.blue = 23 / 255
    }
   
    @IBAction func randomColor(sender: AnyObject) {
        self.red = CGFloat(arc4random_uniform(256)) / 255
        self.green = CGFloat(arc4random_uniform(256)) / 255
        self.blue = CGFloat(arc4random_uniform(256)) / 255
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}

