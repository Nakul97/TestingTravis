//
//  testClass.swift
//  TestingTravis
//
//  Created by Zomato on 14/03/19.
//  Copyright © 2019 tester. All rights reserved.
//

import Foundation

class TestClass: NSObject {
    
    var forceUnwrapMe: String?
    var forceUnwrap2: Int?
    
    override init() {
        print(forceUnwrapMe!)
        print(forceUnwrap2!)
        
        let unused = 0
    }
    
}
