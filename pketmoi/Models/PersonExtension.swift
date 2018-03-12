//
//  PersonExtension.swift
//  pketmoi
//
//  Created by Hugo Maitre on 12/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation

extension Person {
    
    var fullName : String? {
        get {
            guard (self.firstname != nil && self.lastname != nil) else {
                return nil
            }
            return self.firstname! + " " + self.lastname!
        }
    }
    
}
