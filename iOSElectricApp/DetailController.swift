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
        get();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func get(){
        let url = NSURL(string: "http://topelectirc.azurewebsites.net/showsetname.php")
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
        cell.OutletID.text = "Outlet ID: "+(maindata["outlet_id"] as? String)!
        cell.OutletName.text = "Outlet Name: "+(maindata["outlet_name"] as? String)!
        cell.Power.text = "Unit: "+(maindata["elec_power"] as? String)!
        cell.Limit.text = "Limit: "+(maindata["elec_limit"] as? String)!
        cell.Detail.text = "Edit >"
        cell.ImageView.image = imageImages
        return cell;
    }
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        let editname = UITableViewRowAction(style: .Normal, title: "Edit Outletname") { action, index in
            print ("more button tapped")
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? DetailCell
        let maindata = self.values[indexPath.row]
        let selectAlert = UIAlertController(title:"Outlet ID: "+(maindata["outlet_id"] as? String)!,message: "Outlet Name: "+(maindata["outlet_name"] as? String)!,preferredStyle: UIAlertControllerStyle.Alert)
        let Ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
            if let textField: UITextField = selectAlert.textFields?.first as UITextField!{
                cell?.OutletName.text = "Outlet Name: "+textField.text!
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
        

        
        let shareAction2 = UITableViewRowAction(style: .Normal, title: "Share" , handler: { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            
            let firstActivityItem = self.values[indexPath.row]
            
            let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)
            
            self.presentViewController(activityViewController, animated: true, completion: nil)
        })
        
        shareAction2.backgroundColor = UIColor.blueColor()
        
        return [shareAction2, editname]
    }

    
}
