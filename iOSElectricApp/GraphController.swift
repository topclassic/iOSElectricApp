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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func get(){
        let url = NSURL(string: "http://topelectirc.azurewebsites.net/showsetlimit.php")
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
        cell.ImageView.image = imageImages
        return cell;
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath){
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? GraphCell
        let maindata = values[indexPath.row]
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
    
}