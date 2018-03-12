//
//  DoctorPresenter.swift
//  pketmoi
//
//  Created by Hugo Maitre on 12/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import UIKit

class DoctorPresenter {
    
    
    fileprivate var fullName: String = ""
    fileprivate var profession: String = ""
    
    
    fileprivate var doctor: Doctor? = nil {
        didSet {
            if let doctor = self.doctor {
                if let fullName = doctor.fullName {
                    self.fullName = fullName
                } else {
                    self.fullName = "unknown"
                }
                if doctor.profession != nil {
                    self.profession = (doctor.profession?.title)!
                } else {
                    self.profession = "unknown"
                }
            } else {
                self.fullName = "NIL"
                self.profession = "NIL"
            }
        }
    }
    
    func configureCell(forCell: UITableViewCell?, doctor: Doctor){
        self.doctor = doctor
        guard let cell: DoctorTableViewCell = forCell as? DoctorTableViewCell else { return }
        cell.doctorFullName.text = self.fullName
        cell.doctorProfession.text = self.profession
    }
}
