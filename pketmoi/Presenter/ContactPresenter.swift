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
    
    func configureCell(forCell: UITableViewCell?, contact: Contact){
        self.contact = contact
        guard let cell: ContactTableViewCell = forCell as? ContactTableViewCell else { return }
        cell.contact = self.contact
        cell.fullnameLabel.text = self.fullname
        cell.statusLabel.text = self.status
    }
}
