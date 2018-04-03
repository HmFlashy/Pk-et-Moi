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
                self.fullname = doctor.fullname
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
    
    /// Configure the cell with the given doctor
    ///
    /// - Parameters:
    ///   - forCell: the cell to configure
    ///   - doctor: the doctor linked to the cell
    /// - Returns: the cell configured
    func configureCell(forCell: DoctorTableViewCell?, doctor: Doctor) -> DoctorTableViewCell? {
        self.doctor = doctor
        guard let cell: DoctorTableViewCell = forCell else { return nil }
        cell.doctorFullName.text = self.fullname
        cell.doctorProfession.text = self.profession
        return cell
    }
}
