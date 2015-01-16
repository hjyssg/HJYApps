//
//  ExpressionAnalyser.swift
//  ExpressionCalculator
//
//  Created by Junyang Huang on 1/15/15.
//  Copyright (c) 2015 HJY. All rights reserved.
//

import Foundation


public extension String {
    
    var length: Int { return countElements(self) }
    
    /**
    Parses a string containing a double numerical value into an optional double if the string is a well formed number.
    
    :returns: A double parsed from the string or nil if it cannot be parsed.
    */
    func toDouble() -> Double? {
        return (self as NSString).doubleValue
        
    }
    

    
}

//Assume the expression is correct and calculatable
func tokenizeExpression(expression: String!) -> [String]
{
    let operators = ["-","+","*","/","^","(",")"]
    let numbers = ["1","2","3","4","5","6","7","8","9","0","."]
    
    var tokens = [String]()
    var buff = ""
    
    var chars = Array(expression)
    
    var index = 0
    for  (index, element) in enumerate(chars)
    {
        let tempCC = String(element)
        
        if contains(operators, tempCC)
        {
            // - is also the minus sign
            if tempCC == "-"
            {
                if index == 0 || chars[index-1] == "("
                {
                    buff += tempCC
                    continue
                }
            }
            
            if buff.length > 0
            {
                tokens.append(buff)
                buff = ""
            }
            
            tokens.append(tempCC)
            
        }else if contains(numbers, tempCC)
        {
            buff += tempCC
        }
    }
    
    if buff.length > 0
    {
        tokens.append(buff)
    }
    
    return tokens
}




func compute(num1: Double, withNumber2 num2: Double, ByOperator  Operator: String ) -> Double?
{
    
    
    if (Operator=="*")
    {
        return num1 * num2;
    }
    if (Operator=="/")
    {
        return num1 / num2;
    }
    if (Operator=="+")
    {
        return num1 + num2;
    }
    if (Operator=="-")
    {
        return num1 - num2;
    }
    if (Operator=="^")
    {
        return  pow(num1,num2);
    }
    
    return nil
}


func getOpPrecedence(op:String ) -> Int
{
    if (op=="^")
    {
        return 4;   // ^ precedence is 3
    } else if (op=="*" || op=="/")
    {
        return 3;  // * / precedence is 2
    } else if (op=="+" || op == "-")
    {
        return 2;
    } ///I did not count the precedence of ()  !!!_
    else if (op=="(" || op==")")
    {
        return 1;
    }
    
    return 0;
}


func evaluateExpression(expression: String) -> Double?
{
    let basicOperators = ["-","+","*","/"]
    let tokens = tokenizeExpression(expression)
    
    var valueStack = [Double]()
    var operatorStack = [String]()
    
    for token in tokens
    {
        if(token == "^")
        {
            operatorStack.append(token)
        }
        else if(contains(basicOperators, token))
        {
            //finish early operator with higher precedence
            while(!operatorStack.isEmpty && getOpPrecedence(token) <= getOpPrecedence(operatorStack.last!))
            {
                let op = operatorStack.removeLast()
                let x = valueStack.removeLast()
                let y = valueStack.removeLast()
                let result = compute(x, withNumber2: y, ByOperator: op)
                valueStack.append(result!)
            }
            
            operatorStack.append(token)
            
        }else if token == "("
        {
            operatorStack.append(token)
        }
        else if token == ")"
        {
            
            var op = operatorStack.removeLast()
            
            while true
            {
                
                let y = valueStack.removeLast()
                let x = valueStack.removeLast()
                let result = compute(x, withNumber2: y, ByOperator: op)
                valueStack.append(result!)
                
                op = operatorStack.removeLast()
                if op == "("
                {
                    break
                }
            }
        }else
        {
            if let num = token.toDouble()
            {
                valueStack.append(num)
            }
        }
    }
    
    while(!operatorStack.isEmpty)
    {
        let op = operatorStack.removeLast()
        let y = valueStack.removeLast()
        let x = valueStack.removeLast()
        let result = compute(x, withNumber2: y, ByOperator: op)
        valueStack.append(result!)
    }
    
    return valueStack.removeLast()
}
