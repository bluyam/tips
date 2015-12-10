//
//  ViewController.swift
//  tips
//
//  Created by Kyle Wilson on 12/1/15.
//  Copyright (c) 2015 Bluyam Inc. All rights reserved.
//
//  Notes from video:
//
//  1) Build Layout
//  2) Tie in Events
//
//  Outlets: Name view elements in code
//  Actions: Tie in to event

import UIKit

class ViewController: UIViewController {

    @IBOutlet var billField: UITextField!
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var tipControl: UISegmentedControl!
    @IBOutlet var totalLabel2: UILabel!
    @IBOutlet var totalLabel3: UILabel!
    @IBOutlet var totalLabel4: UILabel!
    
    @IBOutlet var detailView: UIView!
    
    @IBOutlet var ratingSegmentedControl: UISegmentedControl!
    
    let defaults = NSUserDefaults.standardUserDefaults()

    var tipPercentages : [Double] = []
    
    override func viewDidLoad() {
        print("viewdidload")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        detailView.alpha = 0
        ratingSegmentedControl.alpha = 0

        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        totalLabel2.text = "$0.00"
        totalLabel3.text = "$0.00"
        totalLabel4.text = "$0.00"
        tipControl.selectedSegmentIndex = 1
        
        defaults.setDouble(0.1, forKey: "tipBad")
        defaults.setDouble(0.15, forKey: "tipOK")
        defaults.setDouble(0.18, forKey: "tipGood")
        defaults.setDouble(0.2, forKey: "tipGreat")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func recalculate() {
        
        var tipPercentages = [defaults.doubleForKey("tipBad"),
            defaults.doubleForKey("tipOK"),
            defaults.doubleForKey("tipGood"),
            defaults.doubleForKey("tipGreat")]
        
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue
        var tip =  billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        
        totalLabel.text = String(format: "$%.2f", total)
        totalLabel2.text = String(format: "$%.2f", total/2)
        totalLabel3.text = String(format: "$%.2f", total/3)
        totalLabel4.text = String(format: "$%.2f", total/4)
    }

    @IBAction func onEditingBegin(sender: AnyObject) {

    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        recalculate()
        UIView.animateWithDuration(0.4, animations: {
            self.detailView.alpha = 1
            self.ratingSegmentedControl.alpha = 1
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        detailView.frame.origin.y = 568
        recalculate()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

