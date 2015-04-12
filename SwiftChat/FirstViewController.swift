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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
            
            // Configure the cell...
            
            return cell
    }

    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int{
            return 0;
    }
}

