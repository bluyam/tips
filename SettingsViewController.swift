//
//  SettingsViewController.swift
//  tips
//
//  Created by Kyle Wilson on 12/2/15.
//  Copyright (c) 2015 Bluyam Inc. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var defaultSlider: UISlider!
    @IBOutlet var defaultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        var percentage = defaultSlider.value
        defaultLabel.text = String(format: "%.0f%%", percentage)
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

}
