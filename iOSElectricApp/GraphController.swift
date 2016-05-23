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
    
    @IBAction func refresh(sender: AnyObject) {
        get()
    }
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
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        let maindata = values[indexPath.row]
        let selectweek = UITableViewRowAction(style: .Normal, title: "Week") { action, index in
            
        }
        selectweek.backgroundColor = UIColor.blueColor()
        let selectmonth = UITableViewRowAction(style: .Normal, title: "Month") { action, index in
            
        }
        selectmonth.backgroundColor = UIColor.orangeColor()
        return [selectmonth, selectweek]
        
        let selectAlert = UIAlertController(title:"Outlet ID: "+(maindata["outlet_id"] as? String)!,message: "Outlet Name: "+(maindata["outlet_name"] as? String)!,preferredStyle: UIAlertControllerStyle.Alert)
        let week = UIAlertAction(title: "Week", style: UIAlertActionStyle.Default, handler: nil)
        let month = UIAlertAction(title: "Month", style: UIAlertActionStyle.Default, handler: nil)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
        selectAlert.addAction(week)
        selectAlert.addAction(month)
        selectAlert.addAction(cancel)
        self.presentViewController(selectAlert, animated: true, completion: nil)
        self.performSegueWithIdentifier("ShowDayGraph", sender: self)
    }
    
}