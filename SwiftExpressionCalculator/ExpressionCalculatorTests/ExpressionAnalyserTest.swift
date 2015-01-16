//
//  ExpressionAnalyserTest.swift
//  ExpressionCalculator
//
//  Created by Junyang Huang on 1/15/15.
//  Copyright (c) 2015 HJY. All rights reserved.
//


import XCTest


class ExpressionAnalyserTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCompute()
    {
        var r = compute(1.1, withNumber2: 0.9, ByOperator: "+" )
        assert(r == 2, "test computer add")
        
        
        r = compute(10, withNumber2: 9, ByOperator: "-" )
        assert(r == 1, "test computer sub")
        
        r = compute(11, withNumber2: 9, ByOperator: "*" )
        assert(r == 99, "test computer *")
        
        r = compute(2, withNumber2: 4, ByOperator: "/" )
        assert(r == 0.5, "test computer /")
        
        r = compute(2, withNumber2: 4, ByOperator: "^" )
        assert(r == 16, "test computer ^")
    }
    
    func testTokenizeExpression()
    {
        let e1 = "-4+(-1.5-4)*5^3.3"
        let r1 = tokenizeExpression(e1)
        assert(r1 == ["-4", "+", "(", "-1.5", "-", "4", ")", "*", "5", "^", "3.3" ], " test Tokenize Expression")
    }
    
    
    func testEvaluateExpression()
    {
         let e1 = "-4+10*23"
        let r1 = evaluateExpression(e1)
        assert(r1 == 226, "")
        
        let e2 = "3^(4/2)"
        let r2 = evaluateExpression(e2)
        assert(r2 == 9, " ")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
