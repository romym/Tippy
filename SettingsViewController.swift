//
//  SettingsViewController.swift
//  Tippy
//
//  Created by romy misra1 on 2/26/17.
//  Copyright © 2017 romy misra1. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var selectTip: UISegmentedControl!
    
    
    @IBOutlet weak var calStyle: UISegmentedControl!
    let myDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBAction func saveTip(sender: AnyObject) {
        print(selectTip.selectedSegmentIndex)
        myDefaults.setInteger(selectTip.selectedSegmentIndex, forKey: "tip")
         myDefaults.setInteger(calStyle.selectedSegmentIndex, forKey: "style")
        myDefaults.synchronize()

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        let intValue = myDefaults.integerForKey("tip")
        let styleValue = myDefaults.integerForKey("style")
        print ("tip selection ", intValue)
        print("style selection", styleValue)
        selectTip.selectedSegmentIndex = intValue
        calStyle.selectedSegmentIndex = styleValue
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
