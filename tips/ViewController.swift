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
//  
//  TODO: Save Tip Defaults to plist
//        Make text fit in box
//        Make README

import UIKit

class ViewController: UIViewController {

    @IBOutlet var billField: UITextField!
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var tipControl: UISegmentedControl!
    @IBOutlet var totalLabel2: UILabel!
    @IBOutlet var totalLabel3: UILabel!
    @IBOutlet var totalLabel4: UILabel!
    
    @IBOutlet var fullView: UIView!
    @IBOutlet var detailView: UIView!
    
    @IBOutlet var ratingSegmentedControl: UISegmentedControl!
    
    let defaults = NSUserDefaults.standardUserDefaults()

    var tipPercentages : [Double] = []
    
    func initializeAmountScreen() {
        
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        totalLabel2.text = "$0.00"
        totalLabel3.text = "$0.00"
        totalLabel4.text = "$0.00"
        tipControl.selectedSegmentIndex = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        self.billField.tintColor = UIColor(white: 0.43, alpha: 0.4)
        
        detailView.alpha = 0
        ratingSegmentedControl.alpha = 0
        
        billField.placeholder = numberFormatter.currencySymbol
        
        initializeAmountScreen()
        
        defaults.setDouble(0.1, forKey: "tipBad")
        defaults.setDouble(0.15, forKey: "tipOK")
        defaults.setDouble(0.18, forKey: "tipGood")
        defaults.setDouble(0.2, forKey: "tipGreat")
        defaults.setBool(false, forKey: "roundUp")
        defaults.setBool(true, forKey: "shakeToClear")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func recalculate() {
        
        var numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        billField.placeholder = numberFormatter.currencySymbol
        
        var tipPercentages = [defaults.doubleForKey("tipBad"),
            defaults.doubleForKey("tipOK"),
            defaults.doubleForKey("tipGood"),
            defaults.doubleForKey("tipGreat")]
        
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue
        var tip =  billAmount * tipPercentage
        var total = billAmount + tip
        
        if (defaults.boolForKey("roundUp")) {
            total = ceil(total)
            tip = total - billAmount
        }

        tipLabel.text = numberFormatter.stringFromNumber(tip)
        totalLabel.text = numberFormatter.stringFromNumber(total)
        totalLabel2.text = numberFormatter.stringFromNumber(total/2)
        totalLabel3.text = numberFormatter.stringFromNumber(total/3)
        totalLabel4.text = numberFormatter.stringFromNumber(total/4)
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if (defaults.boolForKey("shakeToClear")) {
            self.billField.text = ""
            UIView.animateWithDuration(0.3, animations: {
                self.detailView.alpha = 0
                self.ratingSegmentedControl.alpha = 0
            })
            initializeAmountScreen()
        }
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        recalculate()
        if (billField.text == "") {
            UIView.animateWithDuration(0.3, animations: {
                self.detailView.alpha = 0
                self.ratingSegmentedControl.alpha = 0
            })
        }
        else {
            UIView.animateWithDuration(0.3, animations: {
                self.detailView.alpha = 1
                self.ratingSegmentedControl.alpha = 1
            })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        recalculate()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        billField.becomeFirstResponder()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

