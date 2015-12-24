//
//  SettingsViewController.swift
//  
//
//  Created by Kyle Wilson on 12/6/15.
//
//

import UIKit

class SettingsViewController: UITableViewController {

    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var settingsTableView: UITableView!
    @IBOutlet var badLabel: UILabel!
    @IBOutlet var OKLabel: UILabel!
    @IBOutlet var goodLabel: UILabel!
    @IBOutlet var greatLabel: UILabel!
    @IBOutlet var taxPercentageLabel: UILabel!
    
    @IBOutlet var badStepper: UIStepper!
    @IBOutlet var okStepper: UIStepper!
    @IBOutlet var goodStepper: UIStepper!
    @IBOutlet var greatStepper: UIStepper!
    
    @IBOutlet var roundSwitch: UISwitch!
    @IBOutlet var shakeSwitch: UISwitch!
    
    @IBOutlet var includeTaxCell: UITableViewCell!
    
    func refreshTaxPercentageLabel() {
        let taxPercentage = defaults.doubleForKey("taxPercentage")
        let includeTax = defaults.boolForKey("includeTax")
        
        if (includeTax) {
            taxPercentageLabel.text = String(format: "%.2f%%", taxPercentage)
        }
        else {
            taxPercentageLabel.text = "None"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsTableView.backgroundView = nil
        
        let badTip = defaults.doubleForKey("tipBad")
        let okTip = defaults.doubleForKey("tipOK")
        let goodTip = defaults.doubleForKey("tipGood")
        let greatTip = defaults.doubleForKey("tipGreat")

        badLabel.text = String(format: "%.0f%%", badTip*100)
        OKLabel.text = String(format: "%.0f%%", okTip*100)
        goodLabel.text = String(format: "%.0f%%", goodTip*100)
        greatLabel.text = String(format: "%.0f%%", greatTip*100)
        
        refreshTaxPercentageLabel()
        
        badStepper.value = badTip;
        okStepper.value = okTip;
        goodStepper.value = goodTip;
        greatStepper.value = greatTip;
        
        roundSwitch.on = defaults.boolForKey("round")
        shakeSwitch.on = defaults.boolForKey("shakeToClear")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func roundSwitchChanged(sender: AnyObject) {
        let previousState = defaults.boolForKey("round")
        defaults.removeObjectForKey("round")
        defaults.setBool(!previousState, forKey: "round")
    }
    
    @IBAction func shakeSwitchChanged(sender: AnyObject) {
        let previousState = defaults.boolForKey("shakeToClear")
        defaults.removeObjectForKey("shakeToClear")
        defaults.setBool(!previousState, forKey: "shakeToClear")
    }
    
    @IBAction func badChanged(sender: AnyObject) {
        defaults.removeObjectForKey("tipBad")
        defaults.setDouble(badStepper.value, forKey: "tipBad")
        badLabel.text = String(format: "%.0f%%", defaults.doubleForKey("tipBad")*100)
    }
    
    @IBAction func okChanged(sender: AnyObject) {
        defaults.removeObjectForKey("tipOK")
        defaults.setDouble(okStepper.value, forKey: "tipOK")
        OKLabel.text = String(format: "%.0f%%", defaults.doubleForKey("tipOK")*100)
    }

    @IBAction func goodChanged(sender: AnyObject) {
        defaults.removeObjectForKey("tipGood")
        defaults.setDouble(goodStepper.value, forKey: "tipGood")
        goodLabel.text = String(format: "%.0f%%", defaults.doubleForKey("tipGood")*100)
    }
    
    @IBAction func greatChanged(sender: AnyObject) {
        defaults.removeObjectForKey("tipGreat")
        defaults.setDouble(greatStepper.value, forKey: "tipGreat")
        greatLabel.text = String(format: "%.0f%%", defaults.doubleForKey("tipGreat")*100)
    }
    
    override func viewDidDisappear(animated: Bool) {
        if includeTaxCell.selected {
            includeTaxCell.selected = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /* override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
          // #warning Potentially incomplete method implementation.
          // Return the number of sections.
         return 0
      }

      override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          // #warning Incomplete method implementation.
          // Return the number of rows in the section.
          return 0
      }
    */
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(animated: Bool) {
        refreshTaxPercentageLabel()
    }

}
