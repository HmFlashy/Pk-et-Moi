//
//  TimeItemModel.swift
//  pketmoi
//
//  Created by Loris Zirah on 13/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

class TimeItemModel {
    public var dao: TimeItem
    var itemDescription: String?{
        get{
            return self.dao.itemDescription
        }
        set{
            self.dao.itemDescription = newValue
        }
    }
    
    var date: Date?{
        get{
            return self.dao.date
        }
        set{
            self.dao.date = newValue
        }
    }
    
    init(itemDescription: String, date: Date){
        guard let dao = TimeItem.getNewTimeItemDao() else{
            fatalError()
        }
        self.dao = dao
        self.dao.itemDescription = itemDescription
        self.dao.date = date
    }
}

extension TimeItem{
    static func getNewTimeItemDao() -> TimeItem?{
        guard let entity = NSEntityDescription.entity(forEntityName: "TimeItem", in: CoreDataManager.context) else{
            return nil
        }
        return TimeItem(entity: entity, insertInto: CoreDataManager.context)
    }
}
