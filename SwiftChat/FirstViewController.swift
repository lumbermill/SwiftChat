//
//  FirstViewController.swift
//  SwiftChat
//
//  Created by ItoYosei on 4/12/15.
//  Copyright (c) 2015 LumberMill, Inc. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UITableViewDataSource {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var table: UITableView!
    
    var data: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let ud: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let name = ud.stringForKey("name")
        if name == nil || name!.isEmpty {
            nameLabel.text = "NoName"
        }else{
            nameLabel.text = name
        }
        reloadChats()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
            if let row = data.objectAtIndex(indexPath.row) as? Dictionary<String,String> {
                cell.textLabel!.text = row["message"]
                cell.detailTextLabel!.text = row["user"]! + " " + row["created_at"]!
            }
            return cell
    }

    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int{
            return data.count;
    }
    
    func reloadChats(){
        self.data = NSMutableArray()
        
        let URL = "http://chat.lmlab.net/chats.json"
        let url: NSURL? = NSURL(string: URL)
        if url == nil {
            NSLog("Invalid constant. %@", URL)
            return;
        }
        let request: NSURLRequest = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: {
            (resp:NSURLResponse?, data:NSData?, e1:NSError?) -> Void in
            if e1 != nil {
                NSLog("%@", e1!.description)
                return
            }
            if data == nil {
                NSLog("data is null")
                return
            }
            var e2: NSError?
            if let chats = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &e2) as? NSArray {
                for c in chats {
                    var row = ["user":"","message":"","created_at":""]
                    if let user = c["user"] as? String {
                        row["user"] = user
                        println(user)
                    }
                    if let message = c["message"] as? String {
                        row["message"] = message
                        println(message)
                    }
                    if let created_at = c["created_at"] as? String {
                        row["created_at"] = created_at
                    }
                    self.data.addObject(row)
                }
            }
            NSLog("%d rows loaded.", self.data.count)
            dispatch_async(dispatch_get_main_queue(), {
                self.table.reloadData()
            })
        });
    }
    
    @IBAction func sendPushed(sender: AnyObject) {
        textField.resignFirstResponder()
        let name = nameLabel.text
        let text = textField.text
        if !text.isEmpty {
            // TODO: Send text
        }
        reloadChats()
    }
}

