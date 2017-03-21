//
//  BaseClient.swift
//  HDOFinder
//
//  Created by Bao (Brian) L. LE on 3/20/17.
//  Copyright © 2017 Bao (Brian) L. LE. All rights reserved.
//

import Cocoa

class BaseClient: NSObject {
    
    //Singleton
    static let sharedInstance = BaseClient()
    
    //Block
    typealias ServiceGetResponse = (Bool?, NSError?, AnyObject?) -> Void

}
