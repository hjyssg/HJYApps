//
//  ViewController.swift
//  ExpressionCalculator
//
//  Created by Junyang Huang on 1/15/15.
//  Copyright (c) 2015 HJY. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var outputConsole: UILabel!
    
    @IBAction func button(sender: UIButton) {
        
        let input = sender.titleLabel!.text!
        
    
        
        let noRepeatedOperators = ["-","+","*","/","^","."]
        let nums = ["1","2","3","4","5","6","7","8","9","0"]
        
        let text = self.outputConsole.text!
        
        if input == "AC"
        {
            self.outputConsole.text = ""
        }
        else if input == "<-"
        {
            let text = self.outputConsole.text! as NSString
            if text.length > 0
            {
                self.outputConsole.text = text.substringWithRange(NSRange(location: 0, length: text.length-1))
            }else
            {
                self.outputConsole.text = ""
            }
        }
        else if text.rangeOfString("=") != nil
        {
            //do not evaluate result again.
            return ;
        }
        else if contains(nums, input) || input == "(" || input == ")"
        {
            self.outputConsole.text = text +  input
          
        }
        else if contains(noRepeatedOperators, input)
        {
 
                if text.length == 0 && input == "-"
                {
                    text == "-"
                }else if text.length > 0
                {
                    let lastC = text[text.length-1]
                    if !contains(noRepeatedOperators, lastC!)
                    {
                        self.outputConsole.text = text +  input
                    }
            }
        }
        else if input == "="
        {
                if let result = evaluateExpression(text){
                    self.outputConsole.text =  text + " = " + String(format:"%.2f", result)
                }
            }else
            {
                self.outputConsole.text  = "ERROR EXPRESSION"
            }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.outputConsole.text = ""
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

