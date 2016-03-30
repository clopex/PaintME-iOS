//
//  SettingsVC.swift
//  Paint Me
//
//  Created by Adis Mulabdic on 3/30/16.
//  Copyright © 2016 Adis Mulabdic. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    weak var drawingVC : ViewController? = nil
    

    @IBOutlet weak var valueLbl: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        valueLbl.text = "\(Int(VALUE))"
        self.navigationController?.navigationBarHidden = false
        sliderOutlet.value = Float(VALUE)
    }

    @IBAction func deleteAll(sender: AnyObject) {
        
        self.drawingVC?.eraseImage()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        valueLbl.text = "\(Int(VALUE))"
        sliderOutlet.value = Float(VALUE)
    }
 
    @IBAction func shareTapp(sender: AnyObject) {
        if let image = self.drawingVC?.imageView.image {
            
            let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            
            self.presentViewController(activityVC, animated: true, completion: nil)
            
        }
        
    }

    @IBAction func slider(sender: AnyObject) {
        
        let value = Int(sliderOutlet.value)
        VALUE = CGFloat(value)
        valueLbl.text = String(value)
    }
    
    
    
}
