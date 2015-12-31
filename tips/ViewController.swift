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
//  TODO: Include Bill Field in animation
//        Fix constraint conflicts in settings view
//        Bubble up animation of logo for launch screen
//        Tap anywhere on the screen when blank to select text box
//        Default rating setting (good, bad, etc.) (save to plist)
//        Color theme selector (halloween, pink lemonade, evergreen) (save to plist)

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
    
    @IBOutlet var billFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet var ratingSegmentedControl: UISegmentedControl!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var firstLoad = true
    
    var defaultTopConstraintConstant : CGFloat = 0.0

    var tipPercentages : [Double] = []
    
    func initializeAmountScreen() {
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        totalLabel2.text = "$0.00"
        totalLabel3.text = "$0.00"
        totalLabel4.text = "$0.00"
        tipControl.selectedSegmentIndex = 1
    }
    
    func setDoubleWithPersistance(value: Double, key: String) {
        if (defaults.objectForKey(key) == nil) {
            defaults.setDouble(value, forKey: key)
        }
    }
    
    func setBoolWithPersistance(value: Bool, key: String) {
        if (defaults.objectForKey(key) == nil) {
            defaults.setBool(value, forKey: key)
        }
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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
        
        setDoubleWithPersistance(0.1, key: "tipBad")
        setDoubleWithPersistance(0.15, key: "tipOK")
        setDoubleWithPersistance(0.18, key: "tipGood")
        setDoubleWithPersistance(0.2, key: "tipGreat")
        setBoolWithPersistance(false, key: "round")
        setBoolWithPersistance(true, key: "shakeToClear")
        setBoolWithPersistance(false, key: "includeTax")
        setDoubleWithPersistance(8.25, key: "taxPercentage")
        
        defaultTopConstraintConstant = self.billFieldTopConstraint.constant
        
        print(self.navigationItem.rightBarButtonItem?.titleTextAttributesForState(UIControlState.Normal))
        
        // self.navigationController?.navigationBar.barTintColor = UIColorFromRGB(0xFFB892)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColorFromRGB(0x474948),
            NSFontAttributeName: UIFont.systemFontOfSize(22, weight: UIFontWeightLight)]
        
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(15, weight: UIFontWeightLight)], forState: UIControlState.Normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.detailView.translatesAutoresizingMaskIntoConstraints = true
        self.ratingSegmentedControl.translatesAutoresizingMaskIntoConstraints = true
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
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if (defaults.boolForKey("shakeToClear")) {
            self.hideDetailView()
            self.billField.text = ""
            billField.becomeFirstResponder()
        }
    }
    
    func hideDetailView() {
        UIView.animateWithDuration(0.35, animations: {
            // self.billFieldTopConstraint.constant = CGFloat(154)
            self.detailView.layer.frame.origin.y = self.view.frame.maxY
            self.ratingSegmentedControl.layer.frame.origin.y = CGFloat(self.view.frame.maxY-44)
            self.detailView.alpha = 0
            self.ratingSegmentedControl.alpha = 0
        })
    }
    
    func showDetailView() {
        UIView.animateWithDuration(0.35, animations: {
            // self.billFieldTopConstraint.constant = self.defaultTopConstraintConstant
            self.detailView.frame.origin.y = CGFloat(219)
            self.ratingSegmentedControl.frame.origin.y = CGFloat(175)
            self.detailView.alpha = 1
            self.ratingSegmentedControl.alpha = 1
        })
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        print("on editing changed called")
        if (billField.text == "") {
            self.hideDetailView()
        }
        else {
            if (firstLoad) {
                self.detailView.layer.frame.origin.y = self.view.frame.maxY
                self.ratingSegmentedControl.layer.frame.origin.y = CGFloat(self.view.frame.maxY-44)
                firstLoad = false
            }
            recalculate()
            self.showDetailView()
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

