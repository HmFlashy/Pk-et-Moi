//
//  ContactPresenter.swift
//  pketmoi
//
//  Created by Loris Zirah on 02/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//


import Foundation
import UIKit

class ContactPresenter {
    
    fileprivate var fullname: String = ""
    fileprivate var status: String = ""
    
    
    fileprivate var contact: Contact? = nil {
        didSet {
            if let contact = self.contact {
                self.fullname = contact.fullname
                self.status = contact.status!
            } else {
                self.fullname = "NIL"
                self.status = "NIL"
            }
        }
    }
    
    /// Configure the cell with the given contact
    ///
    /// - Parameters:
    ///   - forCell: the cell to configure
    ///   - contact: the contact linked to the cell
    /// - Returns: the cell configured
    func configureCell(forCell: ContactTableViewCell?, contact: Contact) -> ContactTableViewCell? {
        self.contact = contact
        guard let cell = forCell else { return nil }
        cell.contact = self.contact
        cell.fullnameLabel.text = self.fullname
        cell.statusLabel.text = self.status
        return cell
    }
}
