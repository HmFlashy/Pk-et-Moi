//
//  DoctorExtension.swift
//  pketmoi
//
//  Created by Hugo Maitre on 20/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension Doctor {
    
    convenience init?(lastname: String!, firstname: String!, phone: String!, email: String!, address: String?, city: String?, zip: String?, travelTime: Int16!) throws {
        self.init(context: CoreDataManager.context)
        do {
            if(try Doctor.existDoctor(byEmail: email)) {
                CoreDataManager.context.delete(self)
                throw DAOError.dataAlreadyExist
            } else {
                self.lastname = lastname
                self.firstname = firstname
                self.phone = phone
                self.email = email
                self.address = address
                self.city = city
                self.zip = zip
                self.travelTime = travelTime
                try CoreDataManager.context.save()
                return
            }
        } catch DAOError.requestError {
            print("Error requesting")
        } catch {
            print("Error DataCore")
        }
        return nil
    }
    
    
    
    static func existDoctor(byEmail: String) throws -> Bool  {
        let request: NSFetchRequest<Doctor> = Doctor.fetchRequest()
        request.predicate = NSPredicate(format: "email = %@", byEmail)
        do {
            let doctors = try request.execute()
            if(doctors.count > 0) {
                return true
            } else {
                return false
            }
        } catch {
            print("Error exectuing the request")
            throw DAOError.requestError
        }
    }
    
    static func getAll() -> [Doctor]?{
        let request: NSFetchRequest<Doctor> = Doctor.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Doctor.lastname), ascending: true)]
        do {
            let doctors = try request.execute()
            return doctors
        } catch {
            return nil
        }
    }
}
