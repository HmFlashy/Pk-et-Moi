//
//  AppointmentPresenter.swift
//  pketmoi
//
//  Created by Hugo Maitre on 20/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import UIKit

class AppointmentPresenter {
    
    fileprivate var profession: String = ""
    fileprivate var lastname: String = ""
    fileprivate var firstname: String = ""
    fileprivate var time: String = ""
    
    fileprivate var appointment: Appointment? = nil {
        didSet {
            if let appointment = self.appointment {
                if let aprofession = appointment.doctor?.profession?.title {
                    self.profession = aprofession
                } else {
                    self.profession = "unknown"
                }
                if let alastname = appointment.doctor?.lastname {
                    self.lastname = alastname
                } else {
                    self.lastname = "unknown"
                }
                if let afirstname = appointment.doctor?.firstname {
                    self.firstname = afirstname
                    
                } else {
                    self.firstname = "unknown"
                }
                if let atime = appointment.date {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm"
                    formatter.timeZone = TimeZone(abbreviation: "UTC+1")
                    self.time = formatter.string(from: atime)
                } else {
                    self.time = "unknown"
                }
            } else {
                self.profession = "NIL"
                self.lastname = "NIL"
                self.firstname = "NIL"
                self.time = "NIL"
            }
        }
    }
    
    /// Configure the cell with the given appointment
    ///
    /// - Parameters:
    ///   - forCollectionCell: the cell to configure
    ///   - appointment: the appointment linked to the cell
    /// - Returns: the cell configured
    func configureCollectionCell(forCollectionCell: UICollectionViewCell?, appointment: Appointment) -> AppointmentCollectionViewCell? {
        self.appointment = appointment
        guard let cell: AppointmentCollectionViewCell = forCollectionCell as? AppointmentCollectionViewCell else {
            return nil
        }
        cell.professionLabel.text = self.profession
        cell.lastnameLabel.text = self.lastname
        cell.firstnameLabel.text = self.firstname
        cell.timeLabel.text = self.time
        cell.backgroundColor = UIColor(red: 0.5, green: 0.2, blue: 0.1, alpha: 0.1)
        return cell
    }
    
    /// Configure the cell with the given appointment
    ///
    /// - Parameters:
    ///   - forTableViewCell: the cell to configure
    ///   - appointment: the appointment linked to the cell
    /// - Returns: the cell configured
    func configureTableViewCell(forTableViewCell: UITableViewCell?, appointment: Appointment) -> AppointmentTableViewCell? {
        self.appointment = appointment
        guard let cell: AppointmentTableViewCell = forTableViewCell as? AppointmentTableViewCell else {
            return nil
        }
        cell.professionLabel.text = self.profession
        cell.doctorNameLabel.text = self.lastname + " " + self.firstname
        cell.hourLabel.text = self.time
        cell.backgroundColor = UIColor(red: 0.5, green: 0.2, blue: 0.1, alpha: 0.1)
        return cell
    }
}
import Foundation
