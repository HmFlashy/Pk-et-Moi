//
//  ActivityModel.swift
//  pketmoi
//
//  Created by Loris Zirah on 13/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

/*class ActivityModel: TimeItemModel{
    private var dao: Activity
    var duration: String?{
        get{
            return self.dao.duration
        }
        set{
            self.dao.duration = newValue
        }
    }
    
    var typeActivityName: String{
        get{
            guard let name = self.dao.typeActivity?.name else{
                fatalError()
            }
            return name
        }
    }
    
    var typeActivityDescription: String{
        get{
            guard let description = self.dao.typeActivity?.description else{
                fatalError()
            }
            return description
        }
    }
    
    init(itemDescription: String, date: Date, duration: String, typeActivityName: String, typeActivityDescription: String) {
        guard let dao = Activity.getNewActivityDao() else{
            fatalError()
        }
        self.dao = dao
        super.init(itemDescription: itemDescription, date: date)
        self.dao.duration = duration
        self.dao.typeActivity = TypeActivity.getTypeActivityDao(forName: typeActivityName)
    }
}
*/
extension Activity{
    static func getNewActivityDao() -> Activity?{
        guard let entity = NSEntityDescription.entity(forEntityName: "Activity", in: CoreDataManager.context) else{
            return nil
        }
        return Activity(entity: entity, insertInto: CoreDataManager.context)
    }
    
    static func createActivity(itemDescription: String?, date: Date, duration: String, typeActivity: TypeActivity) -> Activity {
        let newActivity = NSEntityDescription.insertNewObject(forEntityName: "Activity", into: CoreDataManager.context) as! Activity
        newActivity.itemDescription = itemDescription
        newActivity.date = date
        newActivity.duration = duration
        newActivity.typeActivity = typeActivity
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        return newActivity
    }
}

