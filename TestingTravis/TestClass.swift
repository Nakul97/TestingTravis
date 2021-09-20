//
//  testClass.swift
//  TestingTravis
//
//  Created by Zomato on 14/03/19.
//  Copyright © 2019 tester. All rights reserved.
//

import Foundation

class TestClass: NSObject {
    
    //Test commit
    var forceUnwrapMe: String?
    var forceUnwrap2: Int?
    
    override init() {
        print(forceUnwrapMe!)
        print(forceUnwrap2!)
        //testing code owners
        //test 2
        let unused = 0
        
        let unused2 = 0
        
        print(forceUnwrap2!)
    }
    
}
