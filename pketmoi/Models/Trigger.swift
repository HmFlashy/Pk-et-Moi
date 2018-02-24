//
//  Trigger.swift
//  pketmoi
//
//  Created by Hugo Maitre on 24/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation

/**
 
 Trigger type
 
 **date**: Trigger -> NSDate
 **description**: Trigger -> String

 */
class Trigger {
    var date: NSDate
    var description: String
    
    init(date: NSDate, description: String){
        self.date = date
        self.description = description
    }
}

