//
//  PopUpVC.swift
//  Paint Me
//
//  Created by Adis Mulabdic on 4/1/16.
//  Copyright © 2016 Adis Mulabdic. All rights reserved.
//

import UIKit

class PopUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func roundTapp(sender: AnyObject) {
        BRUSHSHAPE = 1
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func squareTapp(sender: AnyObject) {
        BRUSHSHAPE = 2
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func buttTapp(sender: AnyObject) {
        BRUSHSHAPE = 3
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
