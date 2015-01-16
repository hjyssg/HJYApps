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
        
        if let text = self.outputConsole.text
        {
            if input == "<="
            {
                
            }
            else if input == "="
            {
                if let  result = evaluateExpression(text){
                self.outputConsole.text =   String(format:"%.2f", result)
                }else
                {
                    self.outputConsole.text  = "ERROR EXPRESSION"
                }
            }
            else if contains(noRepeatedOperators, input) || contains(nums, input)
            {
                
                self.outputConsole.text = text +  input
            }

           
        }else
        {
            self.outputConsole.text = input
        }
        
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

