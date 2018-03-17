//
//  TypeActivityModel.swift
//  pketmoi
//
//  Created by Loris Zirah on 14/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import CoreData

class TypeActivityModel {
    private var dao: TypeActivity
    
    var name: String{
        get{
            return self.name
        }
        set{
            self.dao.name = newValue
        }
    }
    
    var descriptionTypeActivity: String?{
        get{
            return self.dao.descriptionTypeActivity
        }
        set{
            self.dao.descriptionTypeActivity = newValue
        }
    }
    
    init(name: String, descriptionTypeActivity: String?) {
        guard let dao = TypeActivity.getNewTypeActivityDao() else{
            fatalError()
        }
        self.dao = dao
        self.dao.name = name
        self.dao.descriptionTypeActivity = descriptionTypeActivity
    }
}

extension TypeActivity{
    static func getNewTypeActivityDao() -> TypeActivity?{
        guard let entity = NSEntityDescription.entity(forEntityName: "TypeActivity", in: CoreDataManager.context) else{
            return nil
        }
        return TypeActivity(entity: entity, insertInto: CoreDataManager.context)
    }
    
    static func getTypeActivityDao(forName: String) -> TypeActivity{
        let request: NSFetchRequest<TypeActivity> = TypeActivity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(TypeActivity.name), ascending: false)]
        request.predicate = NSPredicate(format: "name == %@",forName)
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        do{
            try fetchedResultController.performFetch()
        }catch{
            print("error")
        }
        print("coucou")
        print(fetchedResultController.object(at: IndexPath(row: 0, section: 0)))
        return fetchedResultController.object(at: IndexPath(row: 0, section: 0))
    }
    
    static func createTypeActivity(name: String, description: String) -> TypeActivity {
        let newTypeActivity = NSEntityDescription.insertNewObject(forEntityName: "TypeActivity", into: CoreDataManager.context) as! TypeActivity
        newTypeActivity.name = name
        newTypeActivity.descriptionTypeActivity = description
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        return newTypeActivity
    }
}
