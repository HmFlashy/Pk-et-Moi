//
//  DoctorModel.swift
//  pketmoi
//
//  Created by Hugo Maitre on 13/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

class DoctorModel: PersonModel {
    
    private var dao: Doctor
    
    var timeTravel: Int16 {
        get {
            return self.dao.timeTravel
        }
        set {
            self.dao.timeTravel = newValue
        }
    }
    
    var profession: String {
        get {
            guard let professionTitle = self.dao.profession?.title else {
                fatalError()
            }
            return professionTitle
        }
    }
    
    var typeProfession: String {
        get {
            guard let typeProfessionTitle = self.dao.profession?.typeProfession?.title else {
                fatalError()
            }
            return typeProfessionTitle
        }
    }
    
    init(firstname: String, lastname: String, address: String, postalCode: String, phoneNumber: String, email: String, timeTravel: Int16, profession: String, typeProfession: String){
        guard let dao = Doctor.getNewDoctorDAO() else{
            fatalError()
        }
        self.dao = dao
        super.init(firstname: firstname, lastname: lastname, address: address, postalCode: postalCode, phoneNumber: phoneNumber, email: email)
        self.timeTravel = timeTravel
        self.dao.profession = Profession.getProfession(forTitle: profession)
    }
    
    fileprivate init(doctor: Doctor){
        self.dao = doctor
        super.init(firstname: doctor.firstname!, lastname: doctor.lastname!, address: doctor.address!, postalCode: doctor.zip!, phoneNumber: doctor.phone!, email: doctor.email!)
    }
}
