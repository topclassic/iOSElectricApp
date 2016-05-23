//
//  MainpagesController.swift
//  iOSDataChart
//
//  Created by Chotipat on 4/23/2559 BE.
//  Copyright © 2559 Chotipat. All rights reserved.
//

import UIKit
import RealmSwift

class GraphController: UITableViewController{
    
    var imageImages = UIImage(named: "graph")
    var sendName: String = ""
    var sendMonth: String = ""
    var values:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get();
        refreshControl?.addTarget(self, action: #selector(DetailController.refresh as (DetailController) -> () -> ()), forControlEvents: UIControlEvents.ValueChanged)
    }
    func refresh(){
        tableView.reloadData()
        get()
        refreshControl?.endRefreshing()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        get()
    }
    
    func get(){
        let url = NSURL(string: "http://topelectirc.azurewebsites.net/showdetail.php")
        let data = NSData(contentsOfURL: url!)
        values = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath) as! GraphCell
        let maindata = values[indexPath.row]
        cell.OutletName.text = "Outlet Name: "+(maindata["outlet_name"] as? String)!
        cell.Power.text = "Unit: "+(maindata["elec_power"] as? String)!
        cell.View.text = "Select Graph >"
        cell.ImageView.image = imageImages
        return cell;
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath){
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let DestViewController: MonthChartController = segue.destinationViewController as! MonthChartController
        DestViewController.textName = sendName
        DestViewController.textMonth = sendMonth
    }
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        let maindata = values[indexPath.row]
        self.sendName = (maindata["outlet_name"] as? String)!
        let selectweek = UITableViewRowAction(style: .Normal, title: "Week") { action, index in
            
        }
        selectweek.backgroundColor = UIColor.blueColor()
        let selectmonth = UITableViewRowAction(style: .Normal, title: "Month") { action, index in
            let selectAlert = UIAlertController(title:"View Graph", message: "Outlet Name: "+(maindata["outlet_name"] as? String)!,preferredStyle: UIAlertControllerStyle.Alert)
            let jan = UIAlertAction(title: "January", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
                self.sendMonth = "January"
                self.performSegueWithIdentifier("ShowDayGraph", sender: self)
            })
            let feb = UIAlertAction(title: "February", style: UIAlertActionStyle.Default, handler: nil)
            let mar = UIAlertAction(title: "March", style: UIAlertActionStyle.Default, handler: nil)
            let apr = UIAlertAction(title: "April", style: UIAlertActionStyle.Default, handler: nil)
            let may = UIAlertAction(title: "May", style: UIAlertActionStyle.Default, handler: nil)
            let jun = UIAlertAction(title: "June", style: UIAlertActionStyle.Default, handler: nil)
            let jul = UIAlertAction(title: "July", style: UIAlertActionStyle.Default, handler: nil)
            let aug = UIAlertAction(title: "August", style: UIAlertActionStyle.Default, handler: nil)
            let sep = UIAlertAction(title: "September", style: UIAlertActionStyle.Default, handler: nil)
            let oct = UIAlertAction(title: "October", style: UIAlertActionStyle.Default, handler: nil)
            let nov = UIAlertAction(title: "November", style: UIAlertActionStyle.Default, handler: nil)
            let dec = UIAlertAction(title: "December", style: UIAlertActionStyle.Default, handler: nil)
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
            selectAlert.addAction(jan)
            selectAlert.addAction(feb)
            selectAlert.addAction(mar)
            selectAlert.addAction(apr)
            selectAlert.addAction(may)
            selectAlert.addAction(jun)
            selectAlert.addAction(jul)
            selectAlert.addAction(aug)
            selectAlert.addAction(sep)
            selectAlert.addAction(oct)
            selectAlert.addAction(nov)
            selectAlert.addAction(dec)
            selectAlert.addAction(cancel)
            self.presentViewController(selectAlert, animated: true, completion: nil)
        }
        selectmonth.backgroundColor = UIColor.orangeColor()
        return [selectmonth, selectweek]
        
       
        
    }
    
}