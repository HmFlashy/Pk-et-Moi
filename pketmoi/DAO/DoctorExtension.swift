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
    
    
    var lastname: String! {
        get {
            return self.plastname
        }
        set {
            self.plastname = newValue
        }
    }
    
    var firstname: String! {
        get {
            return self.pfirstname
        }
        set {
            self.pfirstname = newValue
        }
    }
    
    var phone: String! {
        get {
            return self.pphone
        }
        set {
            self.pphone = newValue
        }
    }
    
    var email: String! {
        get {
            return self.pemail
        }
        set {
            self.pemail = newValue
        }
    }
    
    var city: String? {
        get {
            return self.pcity
        }
        set {
            self.pcity = newValue
        }
    }
    
    var address: String? {
        get {
            return self.paddress
        }
        set {
            self.paddress = newValue
        }
    }
    
    var zip: String? {
        get {
            return self.pzip
        }
        set {
            self.pzip = newValue
        }
    }
    
    var travelTime: Int16! {
        get {
            return self.ptravelTime
        }
        set {
            self.ptravelTime = newValue
        }
    }
    
    static func existDoctor(byEmail: String) throws -> Bool  {
        let request: NSFetchRequest<Doctor> = Doctor.fetchRequest()
        request.predicate = NSPredicate(format: "pemail = %@", byEmail)
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
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Doctor.plastname), ascending: true)]
        do {
            let doctors = try request.execute()
            return doctors
        } catch {
            return nil
        }
    }
}
