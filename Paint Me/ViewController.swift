//
//  ViewController.swift
//  Paint Me
//
//  Created by Adis Mulabdic on 3/30/16.
//  Copyright © 2016 Adis Mulabdic. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIPopoverPresentationControllerDelegate, ColorPickerDelegate {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var setingsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var sliderValue: UISlider!
    @IBOutlet weak var redTest: UIButton!
    @IBOutlet weak var imagePreview: UIImageView!
        
    var lastPoint = CGPoint.zero
    var red : CGFloat = 0.0
    var green : CGFloat = 0.0
    var blue : CGFloat = 0.0
    var isViewOpen = false
    var brush: CGFloat = 10.0
    
    // class varible maintain selected color value
    var selectedColor: UIColor = UIColor.blueColor()
    var selectedColorHex: String = "0000FF"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appResume", name: UIApplicationDidBecomeActiveNotification, object: nil)
        greenColor(UIButton())
    }
    
    func appResume() {
        self.stackView.hidden = false
    }
    
    @IBAction func slider(sender: AnyObject) {
        
        let value = Int(sliderValue.value)
        VALUE = CGFloat(value)
        brush = CGFloat(sliderValue.value)
        imagePreview.tintColor =  COLORCIRCLE
        
        /*self.circleWidth.constant = VALUE
        self.circleHeight.constant = VALUE
        self.makeCircle()*/
        drawPreview()
        
        /*UIView.animateWithDuration(0.3, delay: 0, options: [.CurveLinear], animations: {
            
            self.circleView.layoutIfNeeded()
            
            }, completion: nil)*/
       
    }
    
    func drawPreview() {
        
        UIGraphicsBeginImageContext(self.imagePreview.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetLineCap(context, .Round)
        CGContextSetLineWidth(context, brush)
        
        CGContextSetRGBStrokeColor(context, self.red, self.green, self.blue, 1.0)
        CGContextMoveToPoint(context, 45.0, 45.0)
        CGContextAddLineToPoint(context, 45.0, 45.0)
        CGContextStrokePath(context)
        self.imagePreview.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        /*UIGraphicsBeginImageContext(imagePreview.frame.size)
        context = UIGraphicsGetCurrentContext()
        
        
        CGContextSetLineCap(context, .Round)
        CGContextSetLineWidth(context, 20)
        CGContextMoveToPoint(context, 45.0, 45.0)
        CGContextAddLineToPoint(context, 45.0, 45.0)*/
      
        
        /*CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, opacity)
        CGContextStrokePath(context)
        imageViewOpacity.image = UIGraphicsGetImageFromCurrentImageContext()*/
        
        UIGraphicsEndImageContext()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        sliderValue.hidden = true
        imagePreview.hidden = true
        
        if let touch = touches.first {
            let point = touch.locationInView(self.imageView)
            self.lastPoint = point
        }
        
        self.stackView.hidden = true
        
        self.isViewOpen = true
        self.setingsViewHeight.constant = self.isViewOpen ? 0.0 : 166.0
        
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseOut], animations: {
            
            self.view.layoutIfNeeded()
            self.isViewOpen = false
            
            }, completion: nil)
        
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
        
        if BRUSHSHAPE == 1 {
            CGContextSetLineCap(context, .Round)
        } else if BRUSHSHAPE == 2 {
            CGContextSetLineCap(context, .Square)
        } else if BRUSHSHAPE == 3 {
            CGContextSetLineCap(context, .Butt)
        } else {
            CGContextSetLineCap(context, .Round)
        }
        
        
        CGContextSetLineWidth(context, VALUE)
        
        
        CGContextStrokePath(context)
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    
    func eraseImage() {
        self.imageView.image = nil
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "popOver" {
            let popUp = segue.destinationViewController as! PopUpVC
            popUp.modalPresentationStyle = UIModalPresentationStyle.Popover
            popUp.popoverPresentationController!.delegate = self
        }
        
        
        
        
        /*if segue.identifier == "settings" {
            let settingsVC = segue.destinationViewController as! SettingsVC
            settingsVC.drawingVC = self
        }*/
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        // show popover box for iPhone and iPad both
        return UIModalPresentationStyle.None
    }

    // called by color picker after color selected.
    func colorPickerDidColorSelected(selectedUIColor selectedUIColor: UIColor, selectedHexColor: String) {
      
        COLORCIRCLE = selectedUIColor
        let colors = CGColorGetComponents(selectedUIColor.CGColor)
        self.red = colors[0]
        self.green = colors[1]
        self.blue = colors[2]
       
    }
    
    @IBAction func greenColor(sender: AnyObject) {
        
        //share image
        if let image = self.imageView.image {
            
            let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            
            //if iPhone
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Phone) {
                self.presentViewController(activityVC, animated: true, completion: nil)
            } else { //if iPad
                // Change Rect to position Popover
                let popoverCntlr = UIPopoverController(contentViewController: activityVC)
                popoverCntlr.presentPopoverFromRect(CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0), inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
                
            }
            //self.presentViewController(activityVC, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func redColor(sender: UIButton) {
       //showPopUp()
        
    }
    
    @IBAction func blueColor(sender: AnyObject) {
        eraseImage()
    }
    
    @IBAction func yelloColor(sender: AnyObject) {
        
        drawPreview()
        self.isViewOpen = !self.isViewOpen
        self.setingsViewHeight.constant = self.isViewOpen ? 166.0 : 0.0
        
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseOut], animations: {
            
            self.view.layoutIfNeeded()
            
            }, completion: nil)
        sliderValue.hidden = false
        imagePreview.hidden = false
        
    }
   
    @IBAction func randomColor(sender: AnyObject) {
        
        self.showColorPicker()
    }
    
    private func showColorPicker(){
        
        // initialise color picker view controller
        let colorPickerVc = storyboard?.instantiateViewControllerWithIdentifier("sbColorPicker") as! ColorPicker
        
        // set modal presentation style
        colorPickerVc.modalPresentationStyle = .Popover
        
        // set max. size
        
        //if iPhone
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Phone) {
            colorPickerVc.preferredContentSize = CGSizeMake(265, 400)
        } else { //if iPad
            // Change Rect to position Popover
            colorPickerVc.preferredContentSize = CGSizeMake(465, 600)
            
        }
        
        
        // set color picker deleagate to current view controller
        // must write delegate method to handle selected color
        colorPickerVc.colorPickerDelegate = self
        
        // show popover
        if let popoverController = colorPickerVc.popoverPresentationController {
            
            // set source view
            popoverController.sourceView = self.view
            
            // show popover form button
            //popoverController.sourceRect = self.changeColorButton.frame
            
            // show popover arrow at feasible direction
            popoverController.permittedArrowDirections = UIPopoverArrowDirection.Any
            
            // set popover delegate self
            popoverController.delegate = self
        }
        
        //show color popover
        presentViewController(colorPickerVc, animated: true, completion: nil)
    }

    
    
    
    
    
    
    
    
    
    
    
}

