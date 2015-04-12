//
//  SecondViewController.swift
//  SwiftChat
//
//  Created by ItoYosei on 4/12/15.
//  Copyright (c) 2015 LumberMill, Inc. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let ud: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        textField.text = ud.stringForKey("name")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        let name = textField.text
        NSLog("disappear %@",name)
        
        let ud: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        ud.setValue(name, forKey: "name")
        ud.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

