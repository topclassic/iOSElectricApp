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
    var checklink = 0
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
        if checklink == 0{
            let DestMonthController = segue.destinationViewController as! MonthChartController
            DestMonthController.textName = sendName
        }else{
            let DestDayController = segue.destinationViewController as! DayChartController
            DestDayController.textName = sendName
            DestDayController.textMonth = sendMonth
        }
    }
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        let maindata = values[indexPath.row]
        self.sendName = (maindata["outlet_name"] as? String)!
        let selectday = UITableViewRowAction(style: .Normal, title: "Day Graph") { action, index in
            self.checklink = 1
            let selectAlert = UIAlertController(title:"Select the month for day", message: "Outlet Name: "+(maindata["outlet_name"] as? String)!,preferredStyle: UIAlertControllerStyle.Alert)
            let jan = UIAlertAction(title: "January", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
                self.sendMonth = "January"
                self.performSegueWithIdentifier("ShowDayGraph", sender: self)
            })
            let feb = UIAlertAction(title: "February", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
                self.sendMonth = "February"
                self.performSegueWithIdentifier("ShowDayGraph", sender: self)
            })
            let mar = UIAlertAction(title: "March", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
                self.sendMonth = "March"
                self.performSegueWithIdentifier("ShowDayGraph", sender: self)
            })
            let apr = UIAlertAction(title: "April", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
                self.sendMonth = "April"
                self.performSegueWithIdentifier("ShowDayGraph", sender: self)
            })
            let may = UIAlertAction(title: "May", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
                self.sendMonth = "May"
                self.performSegueWithIdentifier("ShowDayGraph", sender: self)
            })
            let jun = UIAlertAction(title: "June", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
                self.sendMonth = "June"
                self.performSegueWithIdentifier("ShowDayGraph", sender: self)
            })
            let jul = UIAlertAction(title: "July", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
                self.sendMonth = "July"
                self.performSegueWithIdentifier("ShowDayGraph", sender: self)
            })
            let aug = UIAlertAction(title: "August", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
                self.sendMonth = "August"
                self.performSegueWithIdentifier("ShowDayGraph", sender: self)
            })
            let sep = UIAlertAction(title: "September", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
                self.sendMonth = "September"
                self.performSegueWithIdentifier("ShowDayGraph", sender: self)
            })
            let oct = UIAlertAction(title: "October", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
                self.sendMonth = "October"
                self.performSegueWithIdentifier("ShowDayGraph", sender: self)
            })
            let nov = UIAlertAction(title: "November", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
                self.sendMonth = "November"
                self.performSegueWithIdentifier("ShowDayGraph", sender: self)
            })
            let dec = UIAlertAction(title: "December", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
                self.sendMonth = "December"
                self.performSegueWithIdentifier("ShowDayGraph", sender: self)
            })
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
        selectday.backgroundColor = UIColor.blueColor()

        let selectmonth = UITableViewRowAction(style: .Normal, title: "Month Graph") { action, index in
            self.checklink = 0
            self.performSegueWithIdentifier("ShowMonthGraph", sender: self)
            
        }
        selectmonth.backgroundColor = UIColor.orangeColor()

        return [selectmonth, selectday]
        
       
        
    }
    
}