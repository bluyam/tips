//
//  SettingsTableViewController.swift
//  
//
//  Created by Kyle Wilson on 12/6/15.
//
//

import UIKit

class SettingsTableViewController: UITableViewController {

    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var badLabel: UILabel!
    @IBOutlet var OKLabel: UILabel!
    @IBOutlet var goodLabel: UILabel!
    @IBOutlet var greatLabel: UILabel!
    
    @IBOutlet var badStepper: UIStepper!
    @IBOutlet var okStepper: UIStepper!
    @IBOutlet var goodStepper: UIStepper!
    @IBOutlet var greatStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var badTip = defaults.doubleForKey("tipBad")
        var okTip = defaults.doubleForKey("tipOK")
        var goodTip = defaults.doubleForKey("tipGood")
        var greatTip = defaults.doubleForKey("tipGreat")
        
        badLabel.text = String(format: "%.0f%%", defaults.doubleForKey("tipBad")*100)
        OKLabel.text = String(format: "%.0f%%", defaults.doubleForKey("tipOK")*100)
        goodLabel.text = String(format: "%.0f%%", defaults.doubleForKey("tipGood")*100)
        greatLabel.text = String(format: "%.0f%%", defaults.doubleForKey("tipGreat")*100)
        
        badStepper.value = badTip;
        okStepper.value = okTip;
        goodStepper.value = goodTip;
        greatStepper.value = greatTip;
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }

//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 0
//    }

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

}
