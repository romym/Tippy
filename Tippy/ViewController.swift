//
//  ViewController.swift
//  Tippy
//
//  Created by romy misra1 on 2/23/17.
//  Copyright © 2017 romy misra1. All rights reserved.
// testing

import UIKit

class ViewController: UIViewController {

    // Threshold time to retain the bill amount - 10 minutes
    let time_threshold = Double(10 * 60)
    
    @IBOutlet weak var navHeading: UINavigationItem!
    @IBOutlet weak var tipCaptionLabel: UILabel!
    @IBOutlet weak var totalCaptionLabel: UILabel!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        let myDefaults = NSUserDefaults.standardUserDefaults()
        let intValue = myDefaults.integerForKey("tip")
        tipControl.selectedSegmentIndex = intValue
        let styleValue = myDefaults.integerForKey("style")
        
        let secPrevEnd = myDefaults.objectForKey("seconds_at_end") as? Double ?? 0
        let curSec = NSDate().timeIntervalSince1970
        
        print("Time elapsed so far", curSec - secPrevEnd)
        
        if (curSec - secPrevEnd < time_threshold) {
            let savedBill = myDefaults.objectForKey("bill") as? Double ?? 0
            billField.text = String(savedBill)
        }
        
        calculateTip(totalLabel)
        
        updateDisplay(styleValue)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        billField.becomeFirstResponder()
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let myDefaults = NSUserDefaults.standardUserDefaults()
        
        let bill = Double(billField.text!) ?? 0
        myDefaults.setDouble(bill, forKey: "bill")
        
        let secondsAtEnd = NSDate().timeIntervalSince1970
        myDefaults.setDouble(secondsAtEnd, forKey: "seconds_at_end")
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    // Function to update the display depending on serious or playful
    private func updateDisplay(styleValue: Int) {
        let serious = 0
        let playful = 1
        var font: UIFont
        var bgColor: UIColor
        var tintColor: UIColor
        let defaultTintColor = UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1)
        
        switch(styleValue) {
            case serious:
                bgColor = UIColor.whiteColor()
                
                tintColor = defaultTintColor
                font = UIFont (name: "Helvetica Neue", size: 15)!
                break;
        
            case playful:
                bgColor = UIColor(red: 94/255, green: 227/255, blue:174/255, alpha: 1)

                 tintColor = UIColor(red: 85/255, green: 85/255, blue:85/255, alpha: 1)
                 font = UIFont (name: "Papyrus", size: 15)!
                 break;
        
            default:
                bgColor = UIColor.whiteColor()
                tintColor = UIColor.blueColor()
                font = UIFont (name: "Helvetica Neue", size: 15)!
                break;
        }
        
        self.view.backgroundColor = bgColor
        self.view.tintColor = tintColor
        tipLabel.font = font
        totalLabel.font = font
        billField.font = font
        billLabel.font = font
        tipCaptionLabel.font = font
        totalCaptionLabel.font = font
        tipControl.setTitleTextAttributes([NSFontAttributeName: font],
            forState: UIControlState.Normal)
        }
    
    // Function to format currency fields based on location
    
    func formatTextPerLocation(value: Double) -> String {
        let fmt = NSNumberFormatter()
        fmt.locale = NSLocale.currentLocale()
        fmt.numberStyle = .CurrencyStyle
        return fmt.stringFromNumber(value)!
    }
    

    @IBAction func calculateTip(sender: AnyObject) {
        
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = formatTextPerLocation(tip)
        totalLabel.text = formatTextPerLocation(total)
        
    }
}

