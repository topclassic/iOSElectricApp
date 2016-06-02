//
//  MainpagesController.swift
//  iOSDataChart
//
//  Created by Chotipat on 4/23/2559 BE.
//  Copyright © 2559 Chotipat. All rights reserved.
//

import UIKit
import RealmSwift

class DetailController: UITableViewController{
    
    var imageImages = UIImage(named: "tool")
    
    @IBAction func refresh(sender: AnyObject) {
        get()
    }
    var values:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
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
        let cell = self.tableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as! DetailCell
        let maindata = values[indexPath.row]
        if indexPath.row == 0{
                cell.OutletID.text = ""
        }else{
        cell.OutletID.text = "Outlet ID: "+(maindata["outlet_id"] as? String)!
        }
        cell.OutletName.text = "Name: "+(maindata["outlet_name"] as? String)!
        cell.Power.text = "Unit: "+(maindata["elec_power"] as? String)!
        cell.Limit.text = "Limit: "+(maindata["elec_limit"] as? String)!
        cell.Detail.text = "Edit >"
        cell.ImageView.image = imageImages
        return cell;
    }
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        let setlimit = UITableViewRowAction(style: .Normal, title: "Set Limit") { action, index in
            let maindata = self.values[indexPath.row]
            let selectAlert = UIAlertController(title:"Outlet Name: "+(maindata["outlet_name"] as? String)!,message: "Unit: "+(maindata["elec_power"] as? String)!+"\n"+"Limit: "+(maindata["elec_limit"] as? String)!,preferredStyle: UIAlertControllerStyle.Alert)
            let Ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
                if let textField: UITextField = selectAlert.textFields?.first as UITextField!{
                    let request = NSMutableURLRequest(URL: NSURL(string: "http://topelectirc.azurewebsites.net/updatelimit.php")!)
                    request.HTTPMethod = "POST"
                    let postString = "id=\((maindata["outlet_id"] as? String)!)&limit=\(textField.text!)"
                    request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
                    
                    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                        data, response, error in
                        
                        if error != nil {
                            print("error=\(error)")
                            return
                        }
                        
                        print("response = \(response)")
                        
                        let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                        print("responseString = \(responseString)")
                    }
                task.resume()
                let seconds = 1.0
                let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                
                dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                    tableView.reloadData()
                    self.get()
                })
            }
        })
        let Cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
        selectAlert.addAction(Ok)
        selectAlert.addAction(Cancel)
        
        selectAlert.addTextFieldWithConfigurationHandler({(textField)->Void in
            textField.placeholder = "Change your power limit"
        })
        self.presentViewController(selectAlert, animated: true, completion: nil)
            
        }
        setlimit.backgroundColor = UIColor.blackColor()
        
        if indexPath.row != 0{
            
        let delete = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
            let maindata = self.values[indexPath.row]
            let deleteAlert = UIAlertController(title:"Are you sure to delete",message: "Outlet ID: "+(maindata["outlet_id"] as? String)!+"\n"+"Outlet Name: "+(maindata["outlet_name"] as? String)!,preferredStyle: UIAlertControllerStyle.Alert)
            let Ok = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
                let request = NSMutableURLRequest(URL: NSURL(string: "http://topelectirc.azurewebsites.net/deleteoutlet.php")!)
                request.HTTPMethod = "POST"
                let postString = "id=\((maindata["outlet_id"] as? String)!)"
                request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
                
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                    data, response, error in
                    
                    if error != nil {
                        print("error=\(error)")
                        return
                    }
                    
                    print("response = \(response)")
                    
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("responseString = \(responseString)")
                }
                task.resume()
                let seconds = 1.0
                let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                
                dispatch_after(dispatchTime, dispatch_get_main_queue(), {

                    tableView.reloadData()
                    self.get()
                })
            })
            let Cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
            deleteAlert.addAction(Ok)
            deleteAlert.addAction(Cancel)

            self.presentViewController(deleteAlert, animated: true, completion: nil)
                
        }
        delete.backgroundColor = UIColor.redColor()
            
        let editname = UITableViewRowAction(style: .Normal, title: "Edit \n"+" Outletname") { action, index in
        //let cell = tableView.cellForRowAtIndexPath(indexPath) as? DetailCell
        let maindata = self.values[indexPath.row]
        let selectAlert = UIAlertController(title:"Outlet ID: "+(maindata["outlet_id"] as? String)!,message: "Outlet Name: "+(maindata["outlet_name"] as? String)!,preferredStyle: UIAlertControllerStyle.Alert)
        let Ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
            if let textField: UITextField = selectAlert.textFields?.first as UITextField!{
                //cell?.OutletName.text = "Outlet Name: "+textField.text!
                let request = NSMutableURLRequest(URL: NSURL(string: "http://topelectirc.azurewebsites.net/updatename.php")!)
                request.HTTPMethod = "POST"
                let postString = "id=\((maindata["outlet_id"] as? String)!)&name=\(textField.text!)"
                request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
                
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                    data, response, error in
                    
                    if error != nil {
                        print("error=\(error)")
                        return
                    }
                    
                    print("response = \(response)")
                    
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("responseString = \(responseString)")
                }
                task.resume()
                let seconds = 1.0
                let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                
                dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                    tableView.reloadData()
                    self.get()
                })
            }
        })
        let Cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
        selectAlert.addAction(Ok)
        selectAlert.addAction(Cancel)
        
        selectAlert.addTextFieldWithConfigurationHandler({(textField)->Void in
            textField.placeholder = "Change your outlet name"
        })
        self.presentViewController(selectAlert, animated: true, completion: nil)
        }
        editname.backgroundColor = UIColor.lightGrayColor()
        return [delete, setlimit, editname]
        }
        return [setlimit]
    }


    
}
