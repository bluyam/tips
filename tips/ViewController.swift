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
    @IBOutlet var percentageLabel: UILabel!
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
        
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        self.billField.tintColor = UIColor(white: 0.3, alpha: 0.3)
        
        detailView.alpha = 0
        ratingSegmentedControl.alpha = 0
        
        billField.placeholder = numberFormatter.currencySymbol
        billField.becomeFirstResponder()
        
        initializeAmountScreen()
        
        defaults.setDouble(0.1, forKey: "tipBad")
        defaults.setDouble(0.15, forKey: "tipOK")
        defaults.setDouble(0.18, forKey: "tipGood")
        defaults.setDouble(0.2, forKey: "tipGreat")
        defaults.setBool(false, forKey: "round")
        defaults.setBool(true, forKey: "shakeToClear")
        defaults.setBool(false, forKey: "includeTax")
        defaults.setDouble(8.25, forKey: "taxPercentage")
        
        self.detailView.layer.frame.origin.y = self.view.frame.maxY
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func recalculate() {
        
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        billField.placeholder = numberFormatter.currencySymbol
        
        var tipPercentages = [defaults.doubleForKey("tipBad"),
            defaults.doubleForKey("tipOK"),
            defaults.doubleForKey("tipGood"),
            defaults.doubleForKey("tipGreat")]
        
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        percentageLabel.text = String(format: "+%.0f%%", tipPercentage*100)
        
        var billAmount = billField.text!._bridgeToObjectiveC().doubleValue
        
        if (defaults.boolForKey("includeTax")) {
            billAmount = billAmount * (1 + defaults.doubleForKey("taxPercentage")/100)
        }
        
        var tip =  billAmount * tipPercentage
        var total = billAmount + tip
        
        if (defaults.boolForKey("round")) {
            total = round(total)
            tip = total - billAmount
        }

        tipLabel.text = numberFormatter.stringFromNumber(tip)
        totalLabel.text = numberFormatter.stringFromNumber(total)
        totalLabel2.text = numberFormatter.stringFromNumber(total/2)
        totalLabel3.text = numberFormatter.stringFromNumber(total/3)
        totalLabel4.text = numberFormatter.stringFromNumber(total/4)
    }
    
    // probably an autolayout issue
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if (defaults.boolForKey("shakeToClear")) {
            self.hideDetailView()
            self.billField.text = ""
            // billField.becomeFirstResponder()
        }
    }
    
    func hideDetailView() {
        UIView.animateWithDuration(0.4, animations: {
            self.detailView.layer.frame.origin.y = self.view.frame.maxY
            self.ratingSegmentedControl.layer.frame.origin.y = CGFloat(self.view.frame.maxY-44)
            self.detailView.alpha = 0
            self.ratingSegmentedControl.alpha = 0
        })
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        if (billField.text == "") {
            self.hideDetailView()
        }
        else {
            recalculate()
            UIView.animateWithDuration(0.4, animations: {
                self.detailView.frame.origin.y = CGFloat(219)
                self.ratingSegmentedControl.frame.origin.y = CGFloat(175)
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
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

