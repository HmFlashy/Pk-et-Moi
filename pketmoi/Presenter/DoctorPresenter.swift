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
    
    
    fileprivate var fullname: String = ""
    fileprivate var profession: String = ""
    
    
    fileprivate var doctor: Doctor? = nil {
        didSet {
            if let doctor = self.doctor {
                if let fullname = doctor.fullname {
                    self.fullname = fullname
                } else {
                    self.fullname = "unknown"
                }
                if let profession = doctor.profession?.title {
                    self.profession = profession
                } else {
                    self.profession = "unknown"
                }
            } else {
                self.fullname = "NIL"
                self.profession = "NIL"
            }
        }
    }
    
    func configureCell(forCell: UITableViewCell?, doctor: Doctor){
        self.doctor = doctor
        guard let cell: DoctorTableViewCell = forCell as? DoctorTableViewCell else { return }
        cell.doctorFullName.text = self.fullname
        cell.doctorProfession.text = self.profession
    }
}
